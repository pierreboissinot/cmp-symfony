local cmp = require('cmp')

local log = require("plenary.log").new({
	plugin = "cmp-symfony-route",
	level = "info",
	use_console = true,
	highlight = true,
}) -- dependency
log.level = 'info'

local routeSource = {}

routeSource.new = function()
  log.info("Source created")
  return setmetatable({}, { __index = routeSource })
end


routeSource.complete = function(_, params, callback)
    log.info("Completing routes")
    local input = params.context.cursor_before_line
    local query = input:match(".*$") or ""
    query = query:gsub("^'", "") -- ignore starting single quote
    log.info("Query: " .. query)
    local stderr = false
    require("plenary.job")
        :new({
            command = "docker",
            args = {"compose", "exec", "php", "bin/console", "debug:router", "--raw", "--no-interaction", "--format=json"},
            cwd = vim.loop.cwd(),
            on_stderr = function(_, data)
                log.error("Error: " .. data)
                stderr = true
                callback({})
            end,
            on_exit = function(job)
                if stderr then 
                  log.error("Job exited with error")
                  return callback({}) 
                end

                local result = job:result()
                log.info("Job result: " .. vim.inspect(result))
                if type(result) ~= "table" or #result == 0 then
                    log.error("No output from debug:router")
                    return callback({})
                end

                local json_str = table.concat(result, "\n")
                local ok, routes = pcall(vim.json.decode, json_str)
                if not ok or type(routes) ~= "table" then
                    log.error("Failed to parse JSON output")
                    return callback({})
                end

                log.info("Parsed JSON output successfully")

                local items = {}
                for name, route in pairs(routes) do
                    if query == "" or name:lower():find(query:lower(), 1, true) then
				                log.info("Matched route: " .. name)
                        local controller = (route.controller or (route.defaults and route.defaults._controller)) or "N/A"
                        table.insert(items, {
                            label = name,
                            kind = cmp.lsp.CompletionItemKind.Value,
                            documentation = {
                                kind = 'markdown',
                                value = string.format('Controller: `%s`\nPath: `%s`', controller, route.path or "")
                            }
                        })
                    end
                end
                callback({ items = items, isIncomplete = false })
            end,
        })
        :start()
end

return routeSource
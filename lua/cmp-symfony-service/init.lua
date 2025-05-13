local serviceSource = {}

local function log(msg)
  vim.notify("[cmp-symfony-service] " .. msg, vim.log.levels.INFO)
end

serviceSource.new = function()
  log("Source created")
  return setmetatable({}, { __index = serviceSource })
end

serviceSource.get_trigger_characters = function()
  return { '@' }
end

serviceSource.get_keyword_pattern = function()
  return [[@\k*]]
end

serviceSource.complete = function(_, params, callback)
  local input = params.context.cursor_before_line
  local query = input:match("@(%w*)$") or ""
  local items = require('cmp-symfony-service.services').find_services(query)
  -- log("Fetched " .. tostring(#items) .. " services")
  callback(items)
end

return serviceSource
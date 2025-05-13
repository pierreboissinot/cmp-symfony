# cmp-symfony

cmp plugin to complete Symfony related code.

Status:

- cmp-symfony-service: WIP
- cmp-symfony-route: TODO
- ...

## Dependencies

- lxpat
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) is required

## Installation

Using vim-plug:

 ```lua
 call plug#begin('~/.vim/plugged')

Plug 'pierreboissinot/cmp-symfony'

call plug#end()
 ```

 ## Usage

Add `symfony_router` as cmp source

```lua
require("cmp").setup {
    sources = {
        {
            name = "symfony_router",
            -- these options are default, you don't need to include them in setup
            option = {
                console_command = { "php", "bin/console" }, -- see Configuration section
                cwd = nil, -- string|nil Defaults to vim.loop.cwd()
                cwd_files = { "composer.json", "bin/console" }, -- all these files must exist in cwd to trigger completion
                filetypes = { "php", "twig" },
            }
        },
    },
}
```

Inspirations:

- [fbuchlak/cmp-symfony-router](https://github.com/fbuchlak/cmp-symfony-router)
- [Haehnchen/idea-php-symfony2-plugin](https://github.com/Haehnchen/idea-php-symfony2-plugin)


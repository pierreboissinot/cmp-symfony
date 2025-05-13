# cmp-symfony

[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) plugin to complete Symfony related code.

Status:

- cmp-symfony-service: WIP
- cmp-symfony-route: WIP
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

Add `symfony_service` and `symfony_route` as cmp sources

```lua
require('cmp').setup({
  sources = cmp.config.sources({
    { name = 'symfony_service' },
    { name = 'symfony_route' },

    -- other sources like buffer, path, etc.
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  }),
})
```

Inspirations:

- [fbuchlak/cmp-symfony-router](https://github.com/fbuchlak/cmp-symfony-router)
- [Haehnchen/idea-php-symfony2-plugin](https://github.com/Haehnchen/idea-php-symfony2-plugin)
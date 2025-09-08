vim.o.winborder = 'single'
vim.cmd 'colorscheme gruvdark'
vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.laststatus = 3
vim.o.numberwidth = 3
vim.o.statuscolumn =
"%=%{(&number || &relativenumber) && v:virtnum==0 ? (v:relnum ? v:relnum : (v:lnum<10 ? v:lnum . ' ' : v:lnum)) : (v:virtnum>0 ? '↪' : '')}%=%s"
vim.o.signcolumn = 'yes'
vim.o.list = true
vim.o.listchars = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.scrolloff = 10
vim.o.smoothscroll = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.updatetime = 1000
vim.opt.iskeyword:append('-')
vim.o.spelllang = 'en'
vim.o.spelloptions = 'camel'
vim.opt.complete:append('kspell')
vim.o.path = vim.o.path .. ',**'
vim.opt.sessionoptions:remove('blank')
vim.o.swapfile = false
vim.o.shortmess = 'csCFSW'
vim.o.winblend = 0
vim.o.guicursor =
'n-v-c:block-Cursor/lCursor,i-ci-ve-t:ver25-blinkwait700-blinkoff125-blinkon125-Cursor/lCursor,r-cr:hor20,o:hor50'

pcall(function()
  require('hardtime').setup()
  require('ibl').setup()
  -- blink.cmp: minimal config using Lua fuzzy matcher (no downloads)
  -- require('blink.cmp').setup({
  --   keymap = { preset = 'default' },
  --   appearance = { nerd_font_variant = 'mono' },
  --   completion = { documentation = { auto_show = false } },
  --   sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  --   fuzzy = { implementation = 'lua' },
  -- })
  -- Use builtin LSP servers, without builtin completion (see profile-local lsp.lua)
  require('lsp').setup()
end)

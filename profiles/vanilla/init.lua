-- Vanilla profile: minimal, light look, obvious banner

vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = false
vim.o.laststatus = 3
vim.o.background = 'light'

pcall(vim.cmd, 'colorscheme morning')

-- Distinct lualine with a big VANILLA marker
pcall(function()
  require('lualine').setup({
    options = {
      theme = 'auto',
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = ' ', right = ' ' },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { function() return 'VANILLA' end, color = { fg = '#000000', bg = '#ffd866', gui = 'bold' } },
      },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  })
end)

-- Clear and show profile on enter
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.notify('Profile: VANILLA', vim.log.levels.INFO)
  end,
})


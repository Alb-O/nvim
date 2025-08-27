return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lsp').setup()
    end,
  },
  require('plugins.colorscheme'),
  require('plugins.lualine'),
}

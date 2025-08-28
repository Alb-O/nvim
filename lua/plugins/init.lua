return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lsp').setup()
    end,
  },
}

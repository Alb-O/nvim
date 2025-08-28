return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    formatters = {
      stylua = {
        command = "stylua",
        args = { "--stdin-filepath", "$FILENAME", "-" },
      },
    },
  },
}

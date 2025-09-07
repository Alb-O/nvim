local M = {}

function M.setup()
  require('zk').setup({
    picker = "select",
    lsp = {
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
      },
      auto_attach = { enabled = true },
    },
  })
end

return M


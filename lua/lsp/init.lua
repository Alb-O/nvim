local M = {}

function M.setup()
  vim.lsp.enable('luals')
  vim.lsp.config.luals = require('lsp.lua')
end

return M
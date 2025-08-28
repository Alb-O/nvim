local M = {}

function M.setup()
  vim.lsp.enable('luals')
  vim.lsp.config.luals = require('lsp.lua')
  
  vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

return M
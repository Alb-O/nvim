local M = {}

-- Profile-local LSP setup for the experiment profile
-- Uses builtin servers and enables the builtin completion UI via autocmd.
function M.setup()
  -- Enable core servers
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('nixd')
  vim.lsp.enable('vscode-json-languageserver')

  -- Format on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })

  -- Diagnostics config
  vim.diagnostic.config({
    virtual_text = { current_line = true },
  })

  -- Enable builtin LSP completion when a client attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
    end,
  })
end

return M

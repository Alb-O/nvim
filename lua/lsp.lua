local M = {}

function M.setup()
  -- Configure JSON LSP server
  vim.lsp.config('vscode-json-languageserver', {
    cmd = { 'vscode-json-languageserver', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
      provideFormatter = true,
    },
  })

  -- Enable common LSP servers available in all profiles
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('nixd')
  vim.lsp.enable('vscode-json-languageserver')
  vim.lsp.enable('rust_analyzer')

  -- Configure conform.nvim for formatting
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixpkgs-fmt' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      markdown = { 'prettier' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        vim.keymap.set('i', '<C-Space>', function()
          vim.lsp.completion.get()
        end)
      end
    end,
  })

  -- Diagnostics
  vim.diagnostic.config({
    virtual_text = {
      -- Only show virtual line diagnostics for the current cursor line
      current_line = true,
    },
  })
end

return M

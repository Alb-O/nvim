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
    virtual_lines = { current_line = true },
  })
  -- Completion UI options (nightly): prefer CTRL-Y to accept
  vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }
  vim.o.pumheight = 10
  vim.o.autocomplete = true -- nightly: show popup as you type
  -- ensure omnifunc source is included in 'complete'
  do
    local c = ',' .. vim.o.complete .. ','
    if not c:find(',o,', 1, true) then
      vim.o.complete = vim.o.complete .. ',o'
    end
  end

  -- Enable builtin LSP completion when a client attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        -- ensure omnifunc is set so 'o' complete source uses LSP
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Optionally broaden trigger characters so autotrigger fires more often
        local caps = client.server_capabilities
        if caps and caps.completionProvider then
          local seen = {}
          for _, ch in ipairs(caps.completionProvider.triggerCharacters or {}) do seen[ch] = true end
          for _, ch in ipairs({ '.', ':', '/', '\\', '>' }) do seen[ch] = true end
          local list = {}
          for ch, _ in pairs(seen) do table.insert(list, ch) end
          caps.completionProvider.triggerCharacters = list
        end

        vim.lsp.completion.enable(true, client.id, ev.buf, {
          autotrigger = true,
          -- Optional formatting of items in popup menu
          convert = function(item)
            local abbr = item.label
            abbr = abbr:gsub('%b()', ''):gsub('%b{}', '')
            abbr = abbr:match('[%w_.]+.*') or abbr
            abbr = #abbr > 15 and abbr:sub(1, 14) .. '…' or abbr

            local menu = item.detail or ''
            menu = #menu > 15 and menu:sub(1, 14) .. '…' or menu
            return { abbr = abbr, menu = menu }
          end,
        })

        -- Manual trigger for completion/docs
        vim.keymap.set('i', '<C-Space>', function()
          vim.lsp.completion.get()
        end, { buffer = ev.buf, desc = 'LSP completion' })
      end
    end,
  })
end

return M

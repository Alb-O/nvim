local M = {}

function M.setup()
  vim.api.nvim_command "augroup terminal_setup | au!"
  vim.api.nvim_command "autocmd TermOpen * nnoremap <buffer><silent> <LeftRelease> <LeftRelease>i"
  vim.api.nvim_command "autocmd TermOpen * vnoremap <buffer><silent> <LeftRelease> y<LeftRelease>i"
  vim.api.nvim_command "augroup end"
  require('toggleterm').setup({
    start_in_insert = true,
    persist_mode = true,
    shade_terminals = true,
    auto_scroll = true,
  })
end

return M


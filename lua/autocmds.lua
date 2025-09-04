-- Automatically Split help Buffers to the right
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L"
})

-- Autosave on Idle
-- vim.o.updatetime controls the amount of time
-- set this in init.lua
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--     pattern = "*",
--     command = "silent! w"
-- })

-- Navigate the Quickfix List
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', '<C-j>', '<cmd>cn<CR>zz<cmd>wincmd p<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<cmd>cN<CR>zz<cmd>wincmd p<CR>', opts)
  end,
})

-- Show line numbers only in focused window
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.number = true
      vim.opt_local.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})


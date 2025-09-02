-- Automatically close terminal Buffers when their Process is done
-- vim.api.nvim_create_autocmd("TermClose", {
--     callback = function()
--         vim.cmd("bdelete")
--     end
-- })

-- Disable Linenumbers in Terminals
vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

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


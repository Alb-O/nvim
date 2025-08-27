vim.api.nvim_create_augroup("LineNumbers", { clear = true })

-- Disable line numbers in unfocused windows and terminals
vim.api.nvim_create_autocmd("WinEnter", {
  group = "LineNumbers",
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true
    end
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = "LineNumbers",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})

-- Change cursor shape in different modes
vim.opt.guicursor = "n-v-c:block,i:ver25,r-cr-o:hor20"

-- Remove command line height
vim.o.cmdheight = 0
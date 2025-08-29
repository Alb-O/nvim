vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Quit all without saving" })
vim.keymap.set("n", "<leader>qw", ":wq!<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qr", ":wa!<CR> :restart<CR>", { desc = "Save and restart" })
-- Better window navigation using alt + hjkl
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })

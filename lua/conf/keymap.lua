vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Quit all without saving" })
vim.keymap.set("n", "<leader>qw", ":wq!<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qr", ":wa!<CR> :restart<CR>", { desc = "Save and restart" })

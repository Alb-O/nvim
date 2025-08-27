-- Set XDG_RUNTIME_DIR for fzf-lua server
local handle = io.popen("id -u")
local user_id = handle:read("l") -- Reads one line from the command output
handle:close()
vim.env.XDG_RUNTIME_DIR = "/run/user/" .. user_id

-- Set leader key to space (must be set before lazy)
vim.g.mapleader = " "

-- Bootstrap lazy.nvim using vim.pack
vim.pack.add({
	{ src = "https://github.com/folke/lazy.nvim", name = "lazy" }
})

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

-- Load configuration module
require("conf")

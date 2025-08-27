return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "tokyonight-night"

    -- Set status line as same color as background
    vim.cmd.highlight "StatusLine guibg=NONE"
    vim.cmd.highlight "StatusLineNC guibg=NONE"

    -- Status line text in unfocused windows is same as focused windows
    vim.cmd.highlight "StatusLineNC guifg=#c0caf5"
  end,
}
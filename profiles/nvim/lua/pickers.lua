local M = {}

function M.setup()
  require('fzf-lua').setup({
    winopts = {
      fullscreen = true,
      border = "none",
      preview = {
        wrap = "nowrap",
        hidden = "nohidden",
        layout = "horizontal",
        border = "none",
        delay = 0,
        winopts = { number = false },
      },
    },
    keymap = {
      fzf = {
        ["ctrl-l"]     = "accept",
        ["ctrl-q"]     = "select-all+accept",
        ["ctrl-z"]     = "abort",
        ["ctrl-u"]     = "unix-line-discard",
        ["ctrl-f"]     = "half-page-down",
        ["ctrl-b"]     = "half-page-up",
        ["ctrl-a"]     = "beginning-of-line",
        ["ctrl-e"]     = "end-of-line",
        ["alt-a"]      = "toggle-all",
        ["alt-g"]      = "first",
        ["alt-G"]      = "last",
        ["f3"]         = "toggle-preview-wrap",
        ["f4"]         = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"]   = "preview-page-up",
      },
    },
  })

  require('fzf-lua-frecency').setup({ cwd_only = true, all_files = true })

  vim.ui.select = require('fzf-lua').complete_bline

  local keymap = vim.keymap.set
  local pick_colorscheme = function() require('fzf-lua').colorschemes() end

  keymap("n", "<leader>ff", function() require('fzf-lua-frecency').frecency() end, { desc = 'Find File (Frecency)' })
  keymap("n", "<leader>fr", function() require('fzf-lua').resume() end, { desc = 'Resume Last' })
  keymap("n", "<leader><space>", function() require('fzf-lua').buffers() end, { desc = 'Find Buffer' })
  keymap("n", "<leader>fz", function() require('fzf-lua').zoxide() end, { desc = 'Find Working Directory' })
  keymap("n", "<leader>fg", function() require('fzf-lua').live_grep() end, { desc = 'Find String' })
  keymap("n", "<leader>fG", function() require('fzf-lua').grep_cword() end, { desc = 'Find String Cursor' })
  keymap("n", "<leader>fh", function() require('fzf-lua').help_tags() end, { desc = 'Find Help' })
  keymap("n", "<leader>fl", function() require('fzf-lua').highlights() end, { desc = 'Find HL Groups' })
  keymap("n", "<leader>fc", pick_colorscheme, { desc = 'Change Colorscheme' })
  keymap('n', ',', function() require('fzf-lua').blines() end, { nowait = true, desc = 'Search Lines' })

  keymap("n", "<leader>ls", function() require('fzf-lua').lsp_document_symbols() end, { desc = 'Show all Symbols' })
  keymap("n", "<leader>le", function() require('fzf-lua').lsp_document_diagnostics() end, { desc = 'LSP Errors in Buffer' })
end

return M


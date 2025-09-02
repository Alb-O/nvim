local M = {}

function M.setup()
    MiniDeps.add('ibhagwan/fzf-lua')
    MiniDeps.add('elanmed/fzf-lua-frecency.nvim')

    require('fzf-lua').setup({
        'ivy',
        winopts = {
            fullscreen = true,
            preview = {
                wrap = "nowrap",
                hidden = "nohidden",
            },
        },
        keymap = {
            fzf = {
                ["ctrl-l"] = "accept",
                ["ctrl-q"] = "select-all+accept",
                ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      ["alt-g"]       = "first",
      ["alt-G"]       = "last",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
            },
        },
    })

    require('fzf-lua-frecency').setup({
        cwd_only = true,
        all_files = true,
    })

    vim.ui.select = require('fzf-lua').complete_bline
end

return M

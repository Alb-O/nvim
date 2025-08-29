-- Session management
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  {
    "rmagatti/auto-session",
    lazy = false,

    --- enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
      session_lens = {
        picker_opts = {
          previewer = true,
        },
      },
      cwd_change_handling = true,
      pre_cwd_changed_cmds = {

      },

      post_cwd_changed_cmds = {
        function()
          require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
        end,
      },
    },
  },
}

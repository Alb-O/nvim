return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      -- C sections background same as normal background
      local custom_theme = require('lualine.themes.tokyonight')
      custom_theme.normal.c.bg = '#1A1B26'

      require("lualine").setup({
        options = {
          globalstatus = true,
          theme = custom_theme,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          always_show_tabline = true,
        },
        extensions = { "fzf" },
        tabline = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "tabs",
              mode = 1, -- 0: Shows tab_nr, 1: Shows tab_name, 2: Shows tab_nr + tab_name
              use_mode_colors = true,
            },
          },
          lualine_c = {},
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "branch", "diff", "diagnostics" },
          lualine_z = { "progress" },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'copilot',
              show_colors = true,
            },
            'lsp_progress' },
          lualine_x = {},
          lualine_y = {
            {
              'datetime',
              style = '%Y-%m-%d %I:%M %p',
              color = { fg = '', gui = 'bold', bg = 'NONE' }
            },
          },
          lualine_z = {},
        },
        winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              color = { bg = 'NONE' },
              path = 1
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              color = { bg = 'NONE' },
              path = 1
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        }
      })
    end,
  },
  {
    'AndreM222/copilot-lualine',
  },
  {
    'arkav/lualine-lsp-progress',
  },
}

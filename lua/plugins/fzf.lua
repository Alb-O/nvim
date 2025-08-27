return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      'skim', -- use skim instead of fzf
      defaults = {
        git_icons = true,
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          border = "none",
          preview = {
            border = "none",
            scrollbar = false,
            delay = 0,
          },
        },
      },
    },

    config = function(_, opts)
      require("fzf-lua").setup(opts)
      -- Register fzf-lua as the handler for vim.ui.select
      require("fzf-lua").register_ui_select()
    end,

    -- Keymaps
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" }),
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Find content (grep)" }),
  },
}

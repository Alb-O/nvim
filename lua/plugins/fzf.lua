return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      'border-fused',
      hls = {
        normal = "Normal",
        preview_normal = "Normal",
        border = "NonText",
        preview_border = "NonText",
      },
      fzf_bin = 'sk',
      defaults = {
        git_icons = true,
      },
      winopts = {
        backdrop = 100,
        border = "single",
        preview = {
          border = "single",
        },
      },
    },

    config = function(_, opts)
      require("fzf-lua").setup(opts)
      -- Register fzf-lua as the handler for vim.ui.select
      require("fzf-lua").register_ui_select()
      -- Keymaps
      vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Find content (grep)" })
      vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
        function() require("fzf-lua").complete_path() end,
        { silent = true, desc = "Fuzzy complete path" })
    end,
  },
}

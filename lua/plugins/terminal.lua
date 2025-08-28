return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = { --[[ things you want to change go here]] },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- Keymaps
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=vertical size=80<CR>",
        { desc = "Toggle vertical terminal" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=20<CR>",
        { desc = "Toggle horizontal terminal" })
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
      vim.keymap.set("n", "<leader>tq", "<cmd>ToggleTermToggleAll!<CR>", { desc = "Toggle all terminals" })
      -- Exit terminal mode with Esc
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        -- Fullscreen lazygit
        float_opts = {
          width = vim.o.columns,
          height = vim.o.lines,
          border = "none",
        },
        -- Allow escape key to be sent to lazygit, rather than exiting terminal mode
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<leader>G", "<cmd>lua _lazygit_toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle Lazygit" })
    end
  },
}

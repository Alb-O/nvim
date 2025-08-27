return {
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
          },
        },
        suggestion = {
          auto_trigger = true,
          trigger_on_accept = true,
          keymap = {
            accept = "<C-F>",
          },
        }
      })
    end,
  },
}

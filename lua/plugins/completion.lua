return {
  {
    "Saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require('blink.cmp').setup({
        completion = {
          documentation = { auto_show = false },
        },

        fuzzy = {
          implementation = "lua"
        },

        cmdline = {
          keymap = { preset = 'inherit' },
          completion = { menu = { auto_show = true } },
          sources = { 'buffer', 'cmdline' },
        },

        term = {
          enabled = true,
          sources = { },
        },

        keymap = {
          preset = 'default',
          -- tab to confirm selection
          ['<Tab>'] = { 'accept' },
        }
      })
    end,
  },
}

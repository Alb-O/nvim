local M = {}

function M.setup()
  require("monokai-v2").setup({
    filter = "ristretto",
  })
  vim.cmd [[colorscheme monokai-v2]]

  -- Inverted selection color

  local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
  local normal_fg = string.format("#%06x", normal_hl.foreground)
  local normal_bg = string.format("#%06x", normal_hl.background)

  vim.api.nvim_set_hl(0, "Visual", { fg = normal_bg, bg = normal_fg })
end

return M

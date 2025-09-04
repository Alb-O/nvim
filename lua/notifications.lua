local M = {}

function M.setup()
  require('noice').setup({
    routes = {
      {
        filter = { event = "msg_show" },
        view = "notify"
      }
    },
    views = {
      cmdline_popup = {
        border = {
          style = "none",
          padding = { 1, 2 },
        },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    },
  })
end

return M

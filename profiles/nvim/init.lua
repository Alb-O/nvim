--      ╔═════════════════════════════════════════════════════════╗
--      ║                          MVIM                           ║
--      ╚═════════════════════════════════════════════════════════╝

-- nixCats provides plugins via Nix; no dynamic manager. Define simple wrappers
local function now(fn) fn() end
local function later(fn) vim.schedule(fn) end

-- Neovim Options
now(function()
  vim.g.mapleader = " "
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.cursorline = true
  vim.o.wrap = true
  vim.o.linebreak = true
  vim.o.laststatus = 3
  vim.o.numberwidth = 3
  vim.o.statuscolumn =
  "%=%{(&number || &relativenumber) && v:virtnum==0 ? (v:relnum ? v:relnum : (v:lnum<10 ? v:lnum . ' ' : v:lnum)) : (v:virtnum>0 ? '↪' : '')}%=%s"
  vim.o.list = true
  vim.o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
  vim.o.autoindent = true
  vim.o.shiftwidth = 2
  vim.o.tabstop = 2
  vim.o.softtabstop = -1
  vim.o.expandtab = true
  vim.o.scrolloff = 10
  vim.o.smoothscroll = true
  vim.o.clipboard = "unnamed,unnamedplus"
  vim.o.updatetime = 1000
  vim.opt.iskeyword:append("-")
  vim.o.spelllang = "en"
  vim.o.spelloptions = "camel"
  vim.opt.complete:append("kspell")
  vim.o.path = vim.o.path .. ",**"
  vim.opt.sessionoptions:remove('blank')
  vim.o.swapfile = false
  vim.o.shortmess = "csCFSW"
  vim.o.cmdheight = 0
  vim.o.winblend = 0
  vim.o.guicursor =
  "n-v-c:block-Cursor/lCursor,i-ci-ve-t:ver25-blinkwait700-blinkoff125-blinkon125-Cursor/lCursor,r-cr:hor20,o:hor50"
end)

now(function()
  require("mini.basics").setup({
    options = {
      bRRic = true,
      extra_ui = true,
      win_borders = "bold",
    },
    mappings = {
      basic = true,
      windows = true,
    },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
  })
end)

later(function() require("mini.bracketed").setup() end)

later(function() require("mini.bufremove").setup() end)

later(function()
  require("mini.clue").setup({
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "\\" },
      { mode = "i", keys = "<C-x>" },
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      { mode = "n", keys = "s" },
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },

    clues = {
      { mode = "n", keys = "<Leader>b", desc = " Buffer" },
      { mode = "n", keys = "<Leader>f", desc = " Find" },
      { mode = "n", keys = "<Leader>g", desc = "󰊢 Git" },
      { mode = "n", keys = "<Leader>i", desc = "󰏪 Insert" },
      { mode = "n", keys = "<Leader>l", desc = "󰘦 LSP" },
      { mode = "n", keys = "<Leader>m", desc = " Mini" },
      { mode = "n", keys = "<Leader>q", desc = " NVim" },
      { mode = "n", keys = "<Leader>s", desc = "󰆓 Session" },
      { mode = "n", keys = "<Leader>t", desc = " Terminal" },
      { mode = "n", keys = "<Leader>u", desc = "󰔃 UI" },
      { mode = "n", keys = "<Leader>w", desc = " Window" },
      require("mini.clue").gen_clues.g(),
      require("mini.clue").gen_clues.builtin_completion(),
      require("mini.clue").gen_clues.marks(),
      require("mini.clue").gen_clues.registers(),
      require("mini.clue").gen_clues.windows(),
      require("mini.clue").gen_clues.z(),
    },
    window = { delay = 300 },
  })
end)

later(function() require('mini.colors').setup() end)

later(function() require("mini.comment").setup() end)

later(function()
  require("mini.completion").setup({
    mappings = { go_in = "<RET>" },
    window = { info = { border = "solid" }, signature = { border = "solid" } },
  })
end)

later(function() require("mini.cursorword").setup() end)

later(function()
  require("mini.diff").setup({
    view = { style = 'number', signs = { add = '｜', change = '｜', delete = '¦' } },
  })
end)

later(function() require("mini.doc").setup() end)

later(function() require("mini.extra").setup() end)

later(function()
  require("mini.files").setup({
    mappings = { close = '<ESC>' },
    windows = { preview = true, border = "rounded", width_preview = 80 },
  })
end)

later(function() require("mini.fuzzy").setup() end)

-- gitsigns and git config loaded via lua/git.lua from base lua/
later(function() require("git").setup() end)

later(function() require("mini.icons").setup() end)

later(function()
  require("mini.indentscope").setup({
    draw = { animation = function() return 1 end },
    symbol = "│",
  })
end)

later(function() require("mini.jump").setup() end)

later(function() require("mini.jump2d").setup() end)

later(function()
  require("mini.keymap").setup()
  local map_combo = require('mini.keymap').map_combo
  local mode = { 'i', 'c', 'x', 's' }
  map_combo(mode, 'jk', '<BS><BS><Esc>')
  map_combo(mode, 'kj', '<BS><BS><Esc>')
  local map_multistep = require('mini.keymap').map_multistep
  map_multistep('i', '<Tab>', { 'pmenu_next' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function() require("mini.misc").setup() end)

later(function()
  require("mini.move").setup({
    mappings = {
      left = '<M-S-h>', right = '<M-S-l>', down = '<M-S-j>', up = '<M-S-k>',
      line_left = '<M-S-h>', line_right = '<M-S-l>', line_down = '<M-S-j>', line_up = '<M-S-k>',
    },
  })
end)

later(function() require("mini.operators").setup() end)

later(function() require("mini.pairs").setup() end)

later(function() require('pickers').setup() end)

later(function() require("notifications").setup() end)

now(function() require("mini.sessions").setup({ autowrite = true }) end)

later(function() require("mini.splitjoin").setup() end)

later(function()
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = {
      gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      gen_loader.from_lang(),
    },
  })
end)

now(function()
  Mvim_starter_custom = function()
    return {
      { name = "Recent Files", action = function() require("fzf-lua-frecency").frecency() end, section = "Search" },
      { name = "Session",      action = function() require("mini.sessions").select() end,      section = "Search" },
    }
  end
  require("mini.starter").setup({
    autoopen = true,
    items = {
      Mvim_starter_custom(),
      require("mini.starter").sections.recent_files(5, false, false),
      require("mini.starter").sections.recent_files(5, true, false),
      require("mini.starter").sections.sessions(5, true),
    },
    header = function()
      local v = vim.version()
      local versionstring = string.format("  Neovim Version: %d.%d.%d", v.major, v.minor, v.patch)
      local image = [[
┌─────────────────────────────────────────┐
│                                         │
│    ███╗   ███╗██╗   ██╗██╗███╗   ███╗   │
│    ████╗ ████║██║   ██║██║████╗ ████║   │
│    ██╔████╔██║██║   ██║██║██╔████╔██║   │
│    ██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║   │
│    ██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║   │
│    ╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝   │
└─────────────────────────────────────────┘
]]
      finalimage = image .. versionstring
      return finalimage
    end
  })
end)

now(function() require("colorscheme").setup() end)

now(function() require("lsp").setup() end)

later(function() require("terminals").setup() end)

later(function() require("statusline").setup() end)

later(function() require("mini.surround").setup() end)

later(function() require("mini.trailspace").setup() end)

later(function() require("mini.visits").setup() end)

later(function() require("md").setup() end)

require("autocmds")
require("highlights")
require("keybinds")

-- If you want to add additional personal Plugins
-- add lua/personal.lua as a file and configure what ever you need
local path_modules = vim.fn.stdpath("config") .. "/lua/"
if vim.uv.fs_stat(path_modules .. "personal.lua") then require("personal") end


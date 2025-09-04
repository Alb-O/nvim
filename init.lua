--      ╔═════════════════════════════════════════════════════════╗
--      ║                          MVIM                           ║
--      ╚═════════════════════════════════════════════════════════╝

-- mini setup
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- mini.deps base setup
require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

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
    vim.o.statuscolumn = "%=%{(&number || &relativenumber) && v:virtnum==0 ? (v:relnum ? v:relnum : (v:lnum<10 ? v:lnum . ' ' : v:lnum)) : (v:virtnum>0 ? '↪' : '')}%=%s"
    vim.o.list = true
    vim.o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
    vim.o.autoindent = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
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
    vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve-t:ver25-blinkwait700-blinkoff125-blinkon125-Cursor/lCursor,r-cr:hor20,o:hor50"
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
            -- Leader triggers
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },

            { mode = "n", keys = "\\" },

            -- Built-in completion
            { mode = "i", keys = "<C-x>" },

            -- `g` key
            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },

            -- Surround
            { mode = "n", keys = "s" },

            -- Marks
            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },

            -- Registers
            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },

            -- Window commands
            { mode = "n", keys = "<C-w>" },

            -- `z` key
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
        window = {
            delay = 300,
        },
    })
end)

later(function() require('mini.colors').setup() end)

later(function() require("mini.comment").setup() end)

later(function()
    require("mini.completion").setup({
        mappings = {
            go_in = "<RET>",
        },
        window = {
            info = { border = "solid" },
            signature = { border = "solid" },
        },
    })
end)

later(function() require("mini.cursorword").setup() end)

later(function() require("mini.diff").setup({
    view = {
        style = 'sign',
        signs = { add = '｜', change = '｜', delete = '¦' },
    }
}) end)

later(function() require("mini.doc").setup() end)

later(function() require("mini.extra").setup() end)

later(function()
    require("mini.files").setup({
        mappings = {
            close = '<ESC>',
        },
        windows = {
            preview = true,
            border = "rounded",
            width_preview = 80,
        },
    })
end)

later(function() require("mini.fuzzy").setup() end)

later(function() require("mini.git").setup() end)

later(function()
    local hipatterns = require("mini.hipatterns")

    local censor_extmark_opts = function(_, match, _)
        local mask = string.rep("*", vim.fn.strchars(match))
        return {
            virt_text = { { mask, "Comment" } },
            virt_text_pos = "overlay",
            priority = 200,
            right_gravity = false,
        }
    end

    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end)

later(function() require("mini.icons").setup() end)

later(function()
    require("mini.indentscope").setup({
        draw = {
            animation = function()
                return 1
            end,
        },
        symbol = "│",
    })
end)

later(function() require("mini.jump").setup() end)

later(function() require("mini.jump2d").setup() end)

later(function()
    require("mini.keymap").setup()
    local map_combo = require('mini.keymap').map_combo

    -- Support most common modes. This can also contain 't', but would
    -- only mean to press `<Esc>` inside terminal.
    local mode = { 'i', 'c', 'x', 's' }
    map_combo(mode, 'jk', '<BS><BS><Esc>')

    -- To not have to worry about the order of keys, also map "kj"
    map_combo(mode, 'kj', '<BS><BS><Esc>')

    local map_multistep = require('mini.keymap').map_multistep

    map_multistep('i', '<Tab>', { 'pmenu_next' })
    map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
    map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function() require("mini.map").setup() end)

later(function() require("mini.misc").setup() end)

later(function()
    require("mini.move").setup({
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<M-S-h>',
            right = '<M-S-l>',
            down = '<M-S-j>',
            up = '<M-S-k>',

            -- Move current line in Normal mode
            line_left = '<M-S-h>',
            line_right = '<M-S-l>',
            line_down = '<M-S-j>',
            line_up = '<M-S-k>',
        },
    }
    )
end)

later(function() require("mini.operators").setup() end)

later(function()require("mini.pairs").setup()end)

later(function()require('pickers').setup()end)

later(function()require("notifications").setup()end)

now(function() require("mini.sessions").setup({ autowrite = true, }) end)

later(function() require("mini.splitjoin").setup() end)

later(function()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup({
        snippets = {
            -- Load custom file with global snippets first (adjust for Windows)
            gen_loader.from_file('~/.config/nvim/snippets/global.json'),

            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
    })
end)

now(function()
    Mvim_starter_custom = function()
        return {
            { name = "Recent Files", action = function() require("fzf-lua-frecency").frecency() end, section = "Search" },
            { name = "Session",      action = function() require("mini.sessions").select() end,        section = "Search" },
        }
    end
    require("mini.starter").setup({
        autoopen = true,
        items = {
            -- require("mini.starter").sections.builtin_actions(),
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

later(function () require("terminals").setup() end)

later(function () require("statusline").setup() end)

later(function() require("mini.surround").setup() end)

later(function() require("mini.trailspace").setup() end)

later(function() require("mini.visits").setup() end)

require("autocmds")
require("highlights")
require("keybinds")

-- If you want to add additional personal Plugins
-- add lua/personal.lua as a file and configure what ever you need
local path_modules = vim.fn.stdpath("config") .. "/lua/"
if vim.uv.fs_stat(path_modules .. "personal.lua") then require("personal") end

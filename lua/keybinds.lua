-- ╔══════════════════════╗
-- ║    Local Variables    ║
-- ╚═══════════════════════╝
local keymap = vim.keymap.set

local split_sensibly = function()
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
        vim.cmd("vs")
    else
        vim.cmd("split")
    end
end



-- ╔═══════════════════════╗
-- ║    General Keymaps    ║
-- ╚═══════════════════════╝
keymap("n", "<leader>q", "<cmd>wqa<cr>", { desc = 'Quit' })
keymap("n", "ö", ":")
keymap("i", "<C-S-v>", "<C-r><C-o>*", { desc = 'Paste from System in Insertmode' })
keymap("n", "<leader>mu", function() require('mini.deps').update() end, { desc = 'Update Plugins' })
keymap("n", "<S-Insert>", "p", { desc = 'Remap Paste for CopyQ' })
keymap("i", "<S-Insert>", "<C-R>+", { desc = 'Remap Paste for CopyQ' })

-- Terminal
keymap("n", "<leader>tj", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0,10)
end,
{desc = 'Terminal Below'})
keymap("n", "<leader>tl", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0,120)
end,
{desc = 'Terminal Right'})
keymap("t", "<M-l>", "<cmd>wincmd l<cr>", { desc = 'Focus Left' })
keymap("t", "<M-k>", "<cmd>wincmd k<cr>", { desc = 'Focus Up' })
keymap("t", "<M-j>", "<cmd>wincmd j<cr>", { desc = 'Focus Down' })
keymap("t", "<M-h>", "<cmd>wincmd h<cr>", { desc = 'Focus Right' })

-- ╔════════════════════╗
-- ║    Find Keymaps    ║
-- ╚════════════════════╝
keymap("n", "<leader>e", function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    if buffer_name == "" or string.match(buffer_name, "Starter") then
        require('mini.files').open(vim.loop.cwd())
    else
        require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end
end,
{ desc = 'Find Manualy' })

-- ╔═══════════════════════╗
-- ║    Session Keymaps    ║
-- ╚═══════════════════════╝
keymap("n", "<leader>ss", function()
    vim.cmd('wa')
    require('mini.sessions').write()
    require('mini.sessions').select()
end, { desc = 'Switch Session' })
keymap("n", "<leader>sw", function()
    local cwd = vim.fn.getcwd()
    local last_folder = cwd:match("([^/]+)$")
    require('mini.sessions').write(last_folder)
end, { desc = 'Save Session' })
keymap("n", "<leader>sf", function()
    vim.cmd('wa')
    require('mini.sessions').select()
end,
{ desc = 'Load Session' })

-- ╔═══════════════════════╗
-- ║    Editing Keymaps    ║
-- ╚═══════════════════════╝
-- Insert a Password at point
keymap("n", "<leader>ip",
function()
    local command = 'pwgen -N 1 -B 32'
    for _, line in ipairs(vim.fn.systemlist(command)) do
        vim.api.nvim_put({ line }, '', true, true)
    end
end,
{ desc = 'Insert Password' })

keymap("n", "YY", "<cmd>%y<cr>", { desc = 'Yank Buffer' })
keymap("n", "<Esc>", "<cmd>noh<cr>", { desc = 'Clear Search' })

-- Replace
keymap("n", "<leader>re", function() vim.api.nvim_feedkeys(":%s/", "n", false) end , { desc = 'Start Replace' })
keymap("n", "<leader>rs", '<cmd>%s/\\n/\r/g<cr>', { desc = 'Replace \n with Newline' })
keymap("n", "<leader>rw", function()
    local word = vim.fn.expand("<cword>")
    local cmd = ":%s/" .. word .. "/"
    vim.api.nvim_feedkeys(cmd, "n", false) end , { desc = 'Start Replace' })

    -- ╔══════════════════════╗
    -- ║    Buffer Keymaps    ║
    -- ╚══════════════════════╝
    keymap("n", "<leader>bd", "<cmd>bd<cr>", { desc = 'Close Buffer' })
    keymap("n", "<leader>bq", "<cmd>%bd|e#<cr>", { desc = 'Close other Buffers' })
    keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = 'Next Buffer' })
    keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = 'Previous Buffer' })
    keymap("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })
    -- Format Buffer
    -- With and without LSP
    if vim.tbl_isempty(vim.lsp.get_clients()) then
        keymap("n", "<leader>bf", function() vim.lsp.buf.format() end,
        { desc = 'Format Buffer' })
    else
        keymap("n", "<leader>bf", "gg=G<C-o>", { desc = 'Format Buffer' })
    end

    -- ╔═══════════════════╗
    -- ║    Git Keymaps    ║
    -- ╚═══════════════════╝
    keymap("n", "<leader>gl", function()
        split_sensibly()
        vim.cmd('terminal lazygit')
    end, { desc = 'Lazygit' })
    keymap("n", "<leader>gp", "<cmd>:Git pull<cr>", { desc = 'Git Push' })
    keymap("n", "<leader>gs", "<cmd>:Git push<cr>", { desc = 'Git Pull' })
    keymap("n", "<leader>ga", "<cmd>:Git add .<cr>", { desc = 'Git Add All' })
    keymap("n", "<leader>gc", '<cmd>:Git commit -m "Autocommit from MVIM"<cr>',
    { desc = 'Git Autocommit' })
    keymap("", "<leader>gd", function() require('mini.diff').toggle_overlay() end,
    { desc = 'Visual Diff Buffer' })
    keymap("", "<leader>gh", function() require('mini.git').show_range_history() end,
    { desc = 'Git Range History' })
    keymap("n", "<leader>gx", function() require('mini.git').show_at_cursor() end,
    { desc = 'Git Context Cursor' })

    -- ╔═══════════════════╗
    -- ║    LSP Keymaps    ║
    -- ╚═══════════════════╝
    keymap("n", "<leader>ld", function() vim.lsp.buf.definition() end,
    { desc = 'Go To Definition' })
    keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = 'Rename This' })
    keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end,
    { desc = 'Code Actions' })
    keymap("n", "<leader>lf", function()
        vim.diagnostic.setqflist({ open = true })
    end, { desc = "LSP Quickfix" })

    -- ╔══════════════════╗
    -- ║    UI Keymaps    ║
    -- ╚══════════════════╝
    -- Window Navigation
    keymap("n", "<M-l>", "<cmd>wincmd l<cr>", { desc = 'Focus Left' })
    keymap("n", "<M-k>", "<cmd>wincmd k<cr>", { desc = 'Focus Up' })
    keymap("n", "<M-j>", "<cmd>wincmd j<cr>", { desc = 'Focus Down' })
    keymap("n", "<M-h>", "<cmd>wincmd h<cr>", { desc = 'Focus Right' })

    keymap("n", "<leader>ur", "<cmd>colorscheme randomhue<cr>", { desc = 'Random Colorscheme' })

    keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = 'Close Window' })
    keymap("n", "<leader>n", "<cmd>noh<cr>", { desc = 'Clear Search Highlight' })

    --  ─( Split "Sensibly" )───────────────────────────────────────────────
    -- Should automatically split or vsplit based on Ratios
    keymap("n", "<leader>bs", split_sensibly, { desc = "Alternate buffers" })

    --  ─( Change Colorscheme )─────────────────────────────────────────────
    keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { desc = 'Dark Background' })
    keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { desc = 'Light Background' })
    keymap("n", "<leader>um", "<cmd>lua MiniMap.open()<cr>", { desc = 'Mini Map' })

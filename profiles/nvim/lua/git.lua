local M = {}

function M.setup()
  local gitsigns = require('gitsigns')
  local fzf = require('fzf-lua')

  gitsigns.setup({
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '' },
      topdelete    = { text = '' },
      changedelete = { text = '┃' },
      untracked    = { text = '┆' },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = { delay = 300, virt_text_pos = 'eol' },
    preview_config = { border = 'rounded' },
  })

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  map('n', ']h', gitsigns.next_hunk, { desc = 'Next Hunk', unpack(opts) })
  map('n', '[h', gitsigns.prev_hunk, { desc = 'Prev Hunk', unpack(opts) })

  map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk', unpack(opts) })
  map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk', unpack(opts) })
  map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo Stage Hunk', unpack(opts) })
  map('v', '<leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Stage Selection', unpack(opts) })
  map('v', '<leader>gr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Reset Selection', unpack(opts) })

  map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage Buffer', unpack(opts) })
  map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset Buffer', unpack(opts) })

  map('n', '<leader>gx', gitsigns.preview_hunk, { desc = 'Preview Hunk', unpack(opts) })
  map('n', '<leader>gh', function() gitsigns.blame_line({ full = true }) end, { desc = 'Blame Line', unpack(opts) })
  map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff This', unpack(opts) })
  map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = 'Diff Against HEAD', unpack(opts) })

  map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = 'Toggle Deleted', unpack(opts) })
  map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Blame', unpack(opts) })

  local function split_sensibly()
    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)
    if w > math.floor(h * 2.3) then vim.cmd('vnew') else vim.cmd('new') end
  end

  map('n', '<leader>gl', function()
    split_sensibly()
    vim.cmd('terminal lazygit')
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
      vim.cmd('wincmd L'); vim.api.nvim_win_set_width(0, 120)
    else
      vim.cmd('wincmd J'); vim.api.nvim_win_set_height(0, 10)
    end
  end, { desc = 'Lazygit', unpack(opts) })

  map('n', '<leader>gp', '<cmd>Git pull<cr>', { desc = 'Git Pull', unpack(opts) })
  map('n', '<leader>gs', '<cmd>Git push<cr>', { desc = 'Git Push', unpack(opts) })
  map('n', '<leader>ga', '<cmd>Git add .<cr>', { desc = 'Git Add All', unpack(opts) })
  map('n', '<leader>gc', '<cmd>Git commit -m "Autocommit from MVIM"<cr>', { desc = 'Git Autocommit', unpack(opts) })

  map('n', '<leader>gb', function() fzf.git_bcommits() end, { desc = 'Git Log this File', unpack(opts) })
end

return M


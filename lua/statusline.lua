local M = {}

-- Winbar functionality
local function setup_winbar_highlights()
    local cwd_hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })
    vim.api.nvim_set_hl(0, "WinbarCwdSeparator", { fg = cwd_hl.bg })
    vim.api.nvim_set_hl(0, "WinbarCwd", { fg = cwd_hl.fg, bold = true })
    vim.api.nvim_set_hl(0, "WinBarNC", { link = "WinBar" })
end

local function get_winbar_breadcrumb()
    -- Don't show winbar for terminal buffers
    if vim.bo.buftype == 'terminal' then
        return ""
    end
    
    local sep = " / "
    
    -- Get current working directory with highlighting
    local cwd = vim.fn.getcwd()
    local home = os.getenv("HOME")
    if home then
        cwd = cwd:gsub(home, "~")
    end
    cwd = table.concat(vim.fn.split(cwd, "/"), sep)
    
    -- Format cwd with highlighting
    local formatted_cwd = "%#WinbarCwd#" .. cwd .. "%#Normal#"
    
    -- Get file path breadcrumb
    local head = vim.fn.expand("%:.:h")
    head = table.concat(vim.fn.split(head, "/"), sep)
    
    local tail = vim.fn.expand("%:t")
    if tail == "" then
        return formatted_cwd
    end
    
    -- Get file icon
    local icon = ""
    local ok, mini_icons = pcall(require, "mini.icons")
    if ok then
        local filetype_icon, filetype_hl = mini_icons.get('filetype', vim.bo.filetype)
        if filetype_icon then
            icon = "%#" .. filetype_hl .. "#" .. filetype_icon .. " "
        end
    end
    
    -- File status indicators
    local readonly = vim.bo.readonly and "%#Error# []" or ""
    local modified = vim.bo.modified and "%#WarningMsg# [+]" or ""
    
    -- Combine everything
    local file_breadcrumb = formatted_cwd .. sep
        .. (head == "." and "" or head .. sep)
        .. icon
        .. "%#Normal#" .. tail .. readonly .. modified
    
    return file_breadcrumb
end

function M.setup()
    MiniDeps.add('nvim-lualine/lualine.nvim')
    
    setup_winbar_highlights()
    
    require('lualine').setup({
        options = {
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
        },
        winbar = {
            lualine_c = {
                {
                    get_winbar_breadcrumb,
                }
            }
        },
        inactive_winbar = {
            lualine_c = {
                {
                    get_winbar_breadcrumb,
                }
            }
        }
    })
end

return M

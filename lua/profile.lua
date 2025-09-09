-- Profile-aware loader to support multiple alternative Lua trees.
--
-- How it works:
-- - Pick profile name from NVIM_PROFILE env var (or NVIM_APPNAME), default "nvim".
-- - If profiles/<name> exists, prepend it to runtimepath and package.path so
--   modules in profiles/<name>/lua override the base lua/ tree.
-- - If profiles/<name>/init.lua exists, execute it after paths are set.
-- - Additionally, keep legacy overrides loader: overrides/<name>.lua.

local M = {}

-- Determine current profile name
-- Priority: NVIM_PROFILE > NVIM_APPNAME > "nvim"
function M.current()
  local profile = vim.env.NVIM_PROFILE or vim.env.NVIM_APPNAME or "nvim"
  return profile
end

-- Resolve repo root (folder that contains lua/ and optional profiles/)
local function repo_root()
  local src = debug.getinfo(1, 'S').source
  if src:sub(1, 1) == '@' then src = src:sub(2) end
  local lua_dir = vim.fn.fnamemodify(src, ':h')
  return vim.fn.fnamemodify(lua_dir, ':h')
end

local function exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function try_require(mod)
  local ok, res = pcall(require, mod)
  if ok then return res end
  return nil
end

local function prepend_paths(profile_root)
  -- Prepend to runtimepath
  if not string.find(',' .. vim.o.runtimepath .. ',', ',' .. profile_root .. ',', 1, true) then
    vim.opt.runtimepath:prepend(profile_root)
  end
  -- Ensure Lua loader can find profile modules (profiles/<name>/lua/**)
  local lua1 = profile_root .. '/lua/?.lua'
  local lua2 = profile_root .. '/lua/?/init.lua'
  if not string.find(package.path, lua1, 1, true) then
    package.path = table.concat({ lua1, lua2, package.path }, ';')
  end
end

-- Set up paths and load per-profile init/overrides
function M.setup()
  local name = M.current()
  local root = repo_root()
  local prof_root = root .. '/profiles/' .. name

  if exists(prof_root) then
    prepend_paths(prof_root)
    -- Load optional per-profile init.lua from profiles/<name>/init.lua
    local prof_init = prof_root .. '/init.lua'
    if exists(prof_init) then
      pcall(dofile, prof_init)
    end
  end

  -- Back-compat overrides loader (lua/overrides/<name>.lua)
  try_require(string.format('overrides.%s', name))
  try_require(string.format('overrides.%s.init', name))

  -- Load global LSP configuration for all profiles (unless overridden)
  local lsp = try_require('lsp')
  if lsp and lsp.setup then
    lsp.setup()
  end

  -- Helper commands
  local function list_profiles()
    local out = {}
    local base = root .. '/profiles'
    local iter = vim.uv.fs_scandir(base)
    if not iter then return out end
    while true do
      local ent = vim.uv.fs_scandir_next(iter)
      if not ent then break end
      if ent.type == 'directory' then table.insert(out, ent.name) end
    end
    table.sort(out)
    return out
  end

  vim.api.nvim_create_user_command('ProfilesList', function()
    local items = list_profiles()
    if #items == 0 then
      vim.notify('No profiles found in profiles/', vim.log.levels.INFO)
      return
    end
    vim.notify('Profiles: ' .. table.concat(items, ', '), vim.log.levels.INFO)
  end, {})

  vim.api.nvim_create_user_command('ProfileInfo', function()
    local msg = string.format('Profile=%s\nRoot=%s\nActivePath=%s', name, root, prof_root)
    vim.notify(msg, vim.log.levels.INFO)
  end, {})
end

return M

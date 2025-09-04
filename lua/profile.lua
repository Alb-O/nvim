-- Profile detection and override loader

local M = {}

-- Determine current profile name
-- Priority: NVIM_PROFILE > NVIM_APPNAME > "nvim"
function M.current()
  local profile = vim.env.NVIM_PROFILE or vim.env.NVIM_APPNAME or "nvim"
  return profile
end

-- Try requiring a module safely
local function try_require(mod)
  local ok, res = pcall(require, mod)
  if ok then return res end
  return nil
end

-- Load an overrides module if present: overrides/<profile>.lua
function M.load_overrides()
  local profile = M.current()
  -- Allow both overrides/<profile>.lua and overrides/<profile>/init.lua
  try_require(string.format("overrides.%s", profile))
  try_require(string.format("overrides.%s.init", profile))
end

return M

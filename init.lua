-- Minimal bootstrap: ensure repo on rtp and activate profile

-- Ensure this repo is on runtimepath and Lua package.path when launched via '-u init.lua'
do
	local src = debug.getinfo(1, "S").source
	if src:sub(1, 1) == "@" then
		src = src:sub(2)
	end
	local root = vim.fn.fnamemodify(src, ":h")
	if not string.find("," .. vim.o.runtimepath .. ",", "," .. root .. ",", 1, true) then
		vim.opt.runtimepath:append(root)
	end
	local lua1 = root .. "/lua/?.lua"
	local lua2 = root .. "/lua/?/init.lua"
	local lsp1 = root .. "/lsp/?.lua"
	local lsp2 = root .. "/lsp/?/init.lua"
	if not string.find(package.path, lua1, 1, true) then
		package.path = table.concat({ lua1, lua2, package.path }, ";")
	end
end

-- Activate profile layering (profiles/<name>/lua overrides base lua/)
pcall(function()
	require("profile").setup()
end)

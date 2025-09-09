local M = {}

function M.setup()
	-- Enable common LSP servers available in all profiles
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("nixd")
	vim.lsp.enable("jsonls")
	vim.lsp.enable("rust_analyzer")

	-- Configure conform.nvim for formatting
	require("conform").setup({
		formatters_by_ft = {
			-- Web dev
			json = { "prettier" },
			jsonc = { "prettier" },
			markdown = { "prettier" },

			lua = { "stylua" },
			nix = { "nixfmt" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
				vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
				vim.keymap.set("i", "<C-Space>", function()
					vim.lsp.completion.get()
				end)
			end
		end,
	})

	-- Diagnostics
	vim.diagnostic.config({
		virtual_text = {
			-- Only show virtual line diagnostics for the current cursor line
			current_line = true,
		},
	})
end

return M

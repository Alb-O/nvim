local M = {}

function M.setup()
	-- Enable common LSP servers available in all profiles
	vim.lsp.enable("lua_ls")
	vim.lsp.enable("nixd")
	vim.lsp.enable("jsonls")
	vim.lsp.enable("rust_analyzer")
	vim.lsp.enable("ts_ls")
	vim.lsp.enable("biome")
	vim.lsp.enable("yamlls")
	vim.lsp.enable("cssls")
	vim.lsp.enable("html")
	vim.lsp.enable("pyright")
	vim.lsp.enable("bashls")

	-- Configure conform.nvim for formatting
	require("conform").setup({
		formatters_by_ft = {
			-- Web dev (prefer biome, fallback to prettier)
			javascript = { "biome", "prettier", stop_after_first = true },
			typescript = { "biome", "prettier", stop_after_first = true },
			javascriptreact = { "biome", "prettier", stop_after_first = true },
			typescriptreact = { "biome", "prettier", stop_after_first = true },
			json = { "biome", "prettier", stop_after_first = true },
			jsonc = { "biome", "prettier", stop_after_first = true },
			css = { "biome", "prettier", stop_after_first = true },
			html = { "biome", "prettier", stop_after_first = true },
			markdown = { "biome", "prettier", stop_after_first = true },

			-- Other languages
			lua = { "stylua" },
			nix = { "nixfmt" },
			rust = { "rustfmt" },
			python = { "ruff_format", "black", stop_after_first = true },
			yaml = { "yamlfmt" },
			toml = { "taplo" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			go = { "gofmt", "goimports" },
			sql = { "sqlfluff" },
			xml = { "xmllint" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		-- Custom formatter configurations
		formatters = {
			biome = {
				command = "biome",
			},
			shfmt = {
				prepend_args = { "-i", "2" }, -- 2 spaces indentation
			},
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

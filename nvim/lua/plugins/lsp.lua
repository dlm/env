return {
	{ -- LSP Plugins
		"neovim/nvim-lspconfig",
		version = "v0.1.8",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				-- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementation")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[l]sp [d]ocument [s]ymbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>ltd", require("telescope.builtin").lsp_type_definitions, "[l]sp [t]ype [d]efinition")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>lws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[l]sp dynamic [w]orkspace [s]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>lr", vim.lsp.buf.rename, "[l]sp [r]ename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>lca", vim.lsp.buf.code_action, "[l]sp [c]ode [a]ction", { "n", "x" })

					-- Show hover information
					map("K", function()
						vim.lsp.buf.hover({
							border = "rounded",
							width = 80,
							wrap = true,
							height = 20,
						})
					end, "lsp [K]ode docs")
				end,
			})

			local lspconfig = require("lspconfig")

			-- Configure LSP servers (managed outside of Neovim)
			-- You'll need to install these LSPs externally

			-- Go
			lspconfig.gopls.setup({})

			-- Rust
			lspconfig.rust_analyzer.setup({})

			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports" },
				nix = { "nixfmt" },
			},
			formatters = {
				goimports = {
					prepend_args = { "-local", "github.com/blocky" },
				},
			},
		},
	},
}

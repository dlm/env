return {
	{ -- LSP Plugins
		-- nvim-lspconfig now only provides server configs (lsp/*.lua);
		-- setup is done with the built-in vim.lsp.config / vim.lsp.enable
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			-- Built-in defaults (0.11+) cover the rest:
			--   K hover, grn rename, gra code action, grr references,
			--   gri implementation, grt type definition, gO document symbols,
			--   <C-s> signature help (insert)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end
					local builtin = require("telescope.builtin")

					-- Telescope pickers in place of the quickfix-based defaults
					map("gd", builtin.lsp_definitions, "[g]oto [d]efinition")
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("grr", builtin.lsp_references, "[g]oto [r]eferences")
					map("gI", builtin.lsp_implementations, "[g]oto [I]mplementation")

					-- quick <leader>l shortcuts for exploring a codebase
					map("<leader>lds", builtin.lsp_document_symbols, "[l]sp [d]ocument [s]ymbols")
					map("<leader>ltd", builtin.lsp_type_definitions, "[l]sp [t]ype [d]efinition")
					map("<leader>lws", builtin.lsp_dynamic_workspace_symbols, "[l]sp dynamic [w]orkspace [s]ymbols")
					map("<leader>lr", vim.lsp.buf.rename, "[l]sp [r]ename")
					map("<leader>lca", vim.lsp.buf.code_action, "[l]sp [c]ode [a]ction", { "n", "x" })
				end,
			})

			-- Configure LSP servers (managed outside of Neovim)
			-- You'll need to install these LSPs externally
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						telemetry = { enable = false },
					},
				},
			})

			-- completion/hover for nixpkgs and NixOS options, evaluated from the
			-- project's flake when it defines nixosConfigurations (e.g. homelab),
			-- otherwise from this machine's config in the nixos flake
			local default_flake = vim.env.HOME .. "/repos/dlm/nixos"

			-- this machine's host if the flake defines it, otherwise the first one
			local nixos_options = function(flake)
				return string.format(
					'(let cs = (builtins.getFlake "%s").nixosConfigurations; in cs."%s" or cs.${builtins.head (builtins.attrNames cs)}).options',
					flake,
					vim.uv.os_gethostname()
				)
			end

			local defines_nixos = function(dir)
				local f = dir and io.open(dir .. "/flake.nix")
				if not f then
					return false
				end
				local found = f:read("*a"):find("nixosConfigurations", 1, true) ~= nil
				f:close()
				return found
			end

			vim.lsp.config("nixd", {
				settings = {},
				-- one client per flake (root_markers), so each gets its own settings;
				-- modify in place, the client already holds this settings table
				before_init = function(_, config)
					local flake = defines_nixos(config.root_dir) and config.root_dir or default_flake
					local nixd = {
						nixpkgs = { expr = string.format('import (builtins.getFlake "%s").inputs.nixpkgs { }', flake) },
						options = { nixos = { expr = nixos_options(flake) } },
					}
					if flake == default_flake then
						-- home-manager is a NixOS module there
						nixd.options.home_manager = {
							expr = nixos_options(flake) .. ".home-manager.users.type.getSubOptions [ ]",
						}
					end
					config.settings.nixd = nixd
				end,
			})

			vim.lsp.enable({ "gopls", "rust_analyzer", "lua_ls", "nixd" })
		end,
	},

	{ -- Neovim runtime/plugin types for lua_ls, only loaded when editing lua
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
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
				go = { "goimports" },
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

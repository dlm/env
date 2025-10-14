return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = { "L3MON4D3/LuaSnip" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					max_width = 80,
					max_height = 20,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		snippets = {
			preset = "luasnip",
		},
	},
	opts_extend = { "sources.default" },
}

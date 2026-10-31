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
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 200,
				window = {
					max_width = 80,
					max_height = 20,
				},
			},
		},
		signature = {
			enabled = true,
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

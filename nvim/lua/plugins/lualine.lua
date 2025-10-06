return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local inactive_bg = "#292c3c" -- mantle
		local inactive_fg = "#b5bfe2" -- subtext1

		require("lualine").setup({
			options = {
				theme = "catppuccin-frappe",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", path = 1, shorting_target = 40 },
				},

				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ "filename", path = 1, shorting_target = 40, color = { bg = inactive_bg, fg = inactive_fg } },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = inactive_bg }),
		})
	end,
}

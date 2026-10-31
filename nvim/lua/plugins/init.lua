return {
	-- colors, main one last
	{ "folke/tokyonight.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	"tpope/vim-surround",
	{ "stevearc/oil.nvim", opts = {} },
	{ "nvim-mini/mini.trailspace", opts = {} },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
}

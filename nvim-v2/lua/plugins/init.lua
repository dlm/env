return {
	-- colors, main one last
	"catppuccin/nvim",
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	{
		"navarasu/onedark.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ "stevearc/oil.nvim", opts = {} },
}

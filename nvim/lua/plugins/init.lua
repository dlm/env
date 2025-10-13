return {
	-- colors, main one last
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	"navarasu/onedark.nvim",
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
				-- integrations = {
				-- 	cmp = true,
				-- 	gitsigns = true,
				-- 	telescope = true,
				-- 	nvimtree = true,
				-- 	notify = true,
				-- 	mini = true,
				-- 	-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				-- },
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	"tpope/vim-surround",
	{ "stevearc/oil.nvim", opts = {} },
	{ "echasnovski/mini.trailspace", opts = {} },
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

	--   {
	--       "github/copilot.vim",
	-- -- config = function()
	-- --           -- vim.g.copilot_no_tab_map = true
	-- --           -- vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
	-- -- end,
	--   },
	--
	{
		"supermaven-inc/supermaven-nvim", opts = {},
	},
}

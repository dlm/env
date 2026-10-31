return {
	{
		"vim-test/vim-test",
		config = function()
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#term_position"] = "belowright"
			vim.g["test#go#runner"] = "gotest"
			vim.g["test#go#gotest#options"] = "-v -race -count=1"
		end,
		keys = {
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "[t]est [n]earest" },
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "[t]est [f]ile" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "[t]est [s]uite" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "[t]est [l]ast" },
		},
	},
}

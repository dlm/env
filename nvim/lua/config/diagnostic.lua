-- Suggestions for displaying diagnostics in a more useful way came from:
--https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed

-- Setup the diagnostics to present a sign in the gutter and the full
-- text as virtual lines under the cursor's line. The float is still
-- available on demand with <C-w>d.
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
	severity_sort = false,
	float = {
		source = true,
		prefix = " ",
		scope = "cursor",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󰋼 ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
})


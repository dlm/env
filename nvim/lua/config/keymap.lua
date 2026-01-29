vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "<leader>w", ":w!<cr>")

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- "special projects"
vim.keymap.set("n", "<leader>pe", ":e! ~/.config/nvim/.<cr>")

--------------------------------------------------------------------------------
-- cleanups
--------------------------------------------------------------------------------

-- clear the search highlighting
vim.keymap.set("n", "??", ":nohlsearch<cr>")

local close_all_floating_windows = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end
vim.keymap.set("n", "<Esc>", close_all_floating_windows)

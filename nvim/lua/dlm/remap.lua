vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "<leader>w", ":w!<cr>")

vim.keymap.set("n", "<leader>pe", ":e! ~/.nvim/.<cr>")
vim.keymap.set("n", "<leader>pv", ":NERDTreeToggle<cr>")

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- clean up highlight after searching
vim.keymap.set("n", "<cr>", ":nohlsearch<cr>")

-- golang
local dlmGoGroup = vim.api.nvim_create_augroup('dlmGo', { clear = true })
vim.api.nvim_create_autocmd('Filetype', { group = dlmGoGroup, pattern = "go", callback = function()
    vim.opt.expandtab = false
    vim.keymap.set("n", "<leader>dd", ":DlvToggleBreakpoint<cr>", { silent = true })
    vim.keymap.set("n", "<leader>dt", ":DlvTest<cr>", { silent = true })
    vim.keymap.set("n", "<leader>a", function()
        vim.cmd("vsplit")
        vim.cmd("GoAlternate")
    end, { silent = true })

	vim.keymap.set('n', '<leader>cu', ":GoRename<CR>", { silent = true })
end })

-- testing
vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { silent = true })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { silent = true })

-- use the leap default mappings
-- require('leap').add_default_mappings()
--
--

-- code
vim.keymap.set('n', '<leader>cr', function()
	require('telescope.builtin').lsp_references()
end)


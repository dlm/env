vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "<leader>w", ":w!<cr>")

vim.keymap.set("n", "<leader>pe", ":e! ~/.nvim/.<cr>")
vim.keymap.set("n", "<leader>pv", ":NERDTreeToggle<cr>")

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- clean up highlight after searching
vim.keymap.set("n", "??", ":nohlsearch<cr>")

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


-- use the leap default mappings
require('leap').create_default_mappings()
--
--

-- code
local tb =  require('telescope.builtin')
vim.keymap.set('n', '<leader>cr', tb.lsp_references)
-- gd -> go to definition -> require('telescope.builtin').lsp_definitions()
vim.keymap.set('n', '<leader>cd', tb.lsp_definitions)     -- pretty much gd
vim.keymap.set('n', '<leader>ci', tb.lsp_implementations) -- pretty much gi
vim.keymap.set('n', '<leader>ca', tb.lsp_incoming_calls)

-- programming stuff:
-- to figure out
-- - for interface implementors, can I always get a list even if there is only one?
-- - K popup docs

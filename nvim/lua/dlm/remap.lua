vim.keymap.set("n", "<leader>w", ":w!<cr>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- testing
vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { silent = true })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { silent = true })

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
end })

-- vim.test#go#runner = 'richgo'
vim.g.go_term_mode = "split"
vim.g.go_fmt_command = "goimports"
vim.g.syntastic_go_checkers = {'golint', 'govet', 'errcheck'}

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1

vim.g.go_list_type = 'quickfix'
vim.g.go_def_mapping_enabled = 0
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = ('gopls')

vim.g['test#strategy'] = "basic"
vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { silent = true })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { silent = true })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { silent = true })

vim.g['test#go#runner'] = 'richgo'
vim.g['test#go#richgo#options'] = '-v'

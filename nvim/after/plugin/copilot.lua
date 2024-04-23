-- vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', {expr=true, silent=true})
vim.keymap.set("i", "<C-j>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false })

vim.g.copilot_no_tab_map = "v:true"

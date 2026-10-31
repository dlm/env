vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- make vertical splits open to the right (affects things like Oil preview)
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- default border for all floating windows (hover, diagnostics, blink, ...)
vim.opt.winborder = "rounded"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.spell = true

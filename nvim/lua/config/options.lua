vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	command = "setlocal shiftwidth=2 tabstop=2",
})

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- make vertical splits open to the right (affects things like Oil preview)
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.spell = true

-- copy the contents of the clipboard to the
-- system clipboard when we exit neovim
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if vim.fn.has("clipboard") == 0 then
			return
		end

		local clipboard_content = vim.fn.getreg("+")
		if vim.fn.executable("xclip") == 1 then
			vim.fn.system("xclip -selection clipboard", clipboard_content)
		elseif vim.fn.executable("xsel") == 1 then
			vim.fn.system("xsel --clipboard --input", clipboard_content)
		elseif vim.fn.executable("wl-copy") == 1 then -- Wayland
			vim.fn.system("wl-copy", clipboard_content)
		end
	end,
})

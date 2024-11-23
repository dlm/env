-- golang
local dlmGoGroup = vim.api.nvim_create_augroup("dlmGo", { clear = true })
vim.api.nvim_create_autocmd("Filetype", {
	group = dlmGoGroup,
	pattern = "go",
	callback = function()
		vim.opt.expandtab = false
	end,
})

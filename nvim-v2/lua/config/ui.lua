local dlmGroup = vim.api.nvim_create_augroup("dlm", { clear = true })

-- flash a highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = dlmGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
	end,
})

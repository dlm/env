require("dlm.set")
require("dlm.remap")
require("dlm.packer")

local dlmGroup = vim.api.nvim_create_augroup('dlm', { clear = true })

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = dlmGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({"TextYankPost"}, {
    group = dlmGroup,
    pattern = "*",
    callback =  function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
	end
})

require("dlm.set")
require("dlm.remap")
require("dlm.packer")

local dlmGroup = vim.api.nvim_create_augroup('dlm', { clear = true })

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = dlmGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

function ColorMyPencilsWithOneDark()
	vim.cmd.colorscheme("onedark")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function ColorMyPencilsWithCats()
	vim.cmd.colorscheme( "catppuccin-mocha")
end

ColorMyPencilsWithOneDark()
-- ColorMyPencilsWithCats()

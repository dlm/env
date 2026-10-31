return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		-- highlight/injection queries for filetypes without core Neovim
		-- queries (e.g. gitcommit) only live in nvim-treesitter's own
		-- runtime dir, which isn't on 'runtimepath' by default
		vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

		require("nvim-treesitter").install({
			"lua",
			"bash",
			"go",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"nix",
			"json",
			"gitcommit",
			"git_rebase",
			"git_config",
			"diff",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				local ok, added = pcall(vim.treesitter.language.add, lang)
				if lang and ok and added then
					vim.treesitter.start(args.buf, lang)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}


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

		local ts = require("nvim-treesitter")

		-- parsers are installed the first time a buffer of that filetype is
		-- opened (see the FileType autocmd); dependencies come along with them

		local start = function(buf, lang)
			vim.treesitter.start(buf, lang)
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end

		local available -- parsers nvim-treesitter knows how to install, loaded on first use
		local installing = {}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if not lang then
					return
				end

				local ok, added = pcall(vim.treesitter.language.add, lang)
				if ok and added then
					start(args.buf, lang)
					return
				end

				available = available or ts.get_available()
				if installing[lang] or not vim.list_contains(available, lang) then
					return
				end

				installing[lang] = true
				ts.install(lang):await(function(err)
					installing[lang] = nil
					vim.schedule(function()
						if err or not vim.api.nvim_buf_is_valid(args.buf) then
							return
						end
						local loaded, now_added = pcall(vim.treesitter.language.add, lang)
						if loaded and now_added then
							start(args.buf, lang)
						end
					end)
				end)
			end,
		})
	end,
}


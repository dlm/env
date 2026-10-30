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

-- these are all kind of broken
--   incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = 'gnn',
--         -- scope_incremental = 'grn',
--         node_incremental = '<TAB>',
--         node_decremental = '<S-TAB>',
--       },
--   },
--
--   textobjects = {
--     select = {
--       enable = true,
--
--       lookahead = true,
--
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ["af"] = { query = "@function.outer", desc = "Select a function region"},
--         ["if"] = { query = "@function.inner", desc = "Select inner part of a function region"},
--         ["ac"] = { query = "@class.outer", desc = "Select a class region" },
--         ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
--       },
--
--       selection_modes = {
--         ['@parameter.outer'] = 'v', -- charwise
--         ['@function.outer'] = 'V', -- linewise
--         ['@class.outer'] = '<c-v>', -- blockwise
--       },
--
--     },
--   },
--
--   move = {
--     enable = true,
--     set_jumps = true, -- whether to set jumps in the jumplist
--
-- 	-- currently  there seems to be some bugs with mving and treesitter text
-- 	-- objects and
-- 	-- go class jumping seems to jump correctly for functions
-- 	-- conditionals and
--
--     goto_next_start = {
--       ["]m"] = { query = "@function.outer", desc = "Next function start" },
--       ["]]"] = { query = "@class.outer", desc = "Next class start" },
--     },
--     goto_next_end = {
--       ["]M"] = "@function.outer",
--       ["]["] = "@class.outer",
--     },
--     goto_previous_start = {
--       ["[m"] = "@function.outer",
--       ["[["] = "@class.outer",
--     },
--     goto_previous_end = {
--       ["[M"] = "@function.outer",
--       ["[]"] = "@class.outer",
--
-- 	-- this just doesn't work at all
--     -- -- Below will go to either the start or the end, whichever is closer.
--     -- -- Use if you want more granular movements
--     -- -- Make it even more gradual by adding multiple queries and regex.
--     -- goto_next = {
--     --   ["]d"] = "@conditional.outer",
--     -- },
--     -- goto_previous = {
--     --   ["[d"] = "@conditional.outer",
--     -- }
--   },
-- }
--
-- repeat is also kind of broken
-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- -- Repeat movement with ; and ,
-- -- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- -- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
--
-- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

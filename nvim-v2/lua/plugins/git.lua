return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "g7", ":diffget //2<cr>", desc = "Get from left", silent = true },
			{ "g8", ":diffget //3<cr>", desc = "Get from right", silent = true },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local map = function(keys, desc, func)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				-- Actions
				map("<leader>hs", "[h]g..it [s]tage hunk", gitsigns.stage_hunk)
				map("<leader>hr", "[h]g..it [r]eset hunk", gitsigns.reset_hunk)
				map("<leader>hS", "[h]g..it [s]tage buffer", gitsigns.stage_buffer)
				map("<leader>hR", "[h]g..it [r]eset buffer", gitsigns.reset_buffer)
				map("<leader>hp", "[h]g..it [p]review hunk", gitsigns.preview_hunk)
				map("<leader>hd", "[h]g..it [d]iff index", gitsigns.diffthis)
				map("<leader>hD", "[h]g..it [D]iff last commit", function()
					gitsigns.diffthis("~")
				end)

				-- Undoing the last staged hunk is not very useful
				-- unless you are playing with the git signs plugin.
				-- But, since it is useful for that, I will leave it in.
				map("<leader>hu", "[h]g..it [u]ndo stage hunk", gitsigns.undo_stage_hunk)
				--
				map("<leader>hb", "[h]g..it [b]lame", function()
					gitsigns.blame_line({ full = true })
				end)

				-- Mode toggles
				map("<leader>htb", "[h]g..it [t]oggle cur line [b]lame", gitsigns.toggle_current_line_blame)
				map("<leader>htd", "[h]g..it [t]oggle show [d]elted", gitsigns.toggle_deleted)

				-- Navigation
				local mapNav = function(keys, direction, desc)
					map(keys, desc, function()
						if vim.wo.diff then
							vim.cmd.normal({ keys, bang = true })
						else
							gitsigns.nav_hunk(direction)
						end
					end)
				end
				mapNav("]c", "next", "jump to next [c]hange")
				mapNav("[c", "prev", "jump to prev [c]hange")
			end,
		},
	},
}

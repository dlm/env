return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 15,
			open_mapping = [[<C-t>]], -- global toggle
			direction = "horizontal",
			shade_terminals = true,
			persist_mode = true,
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal
			-- Dedicated REPL terminal (count = 7 is arbitrary but stable)
			local repl = Terminal:new({ cmd = os.getenv("SHELL"), count = 7, direction = "horizontal" })
			vim.keymap.set("n", "<leader>tt", function()
				repl:toggle()
			end, { desc = "Toggle REPL terminal" })
			vim.keymap.set("t", "kj", "<C-\\><C-n>")

			-- Optional: open REPL immediately on start
			-- repl:toggle()
			--
		end,
	},

	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "tmux"
			vim.g.slime_no_mappings = 1 -- Don't auto-create mappings
			vim.g.slime_cell_delimiter = "```" -- Markdown fenced blocks

			-- current session, current window and pane before the one I was in before this one
			vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
		end,
		config = function()
			-- sometimes getting the previous pane is annoying and so
			-- it is easier to use a little tmux to get the pane numbers
			local function slime_pick()
				vim.fn.system("tmux display-panes")
				vim.ui.input({ prompt = "Pane number: " }, function(input)
					if input then
						local target = vim.env.TMUX_PANE:gsub("%%(%d+)", input)
						vim.b.slime_config = { socket_name = "default", target_pane = target }
					end
				end)
			end

			vim.api.nvim_create_user_command("SlimePick", slime_pick, {})

			vim.keymap.set("n", "<leader>ss", "<Plug>SlimeSendCell", { desc = "Slime send fenced block" })
			vim.keymap.set("v", "<leader>ss", "<Plug>SlimeRegionSend", { desc = "Slime send selection" })
			vim.keymap.set("n", "<leader>sl", "<Plug>SlimeLineSend", { desc = "Slime send line" })
			vim.keymap.set("n", "<leader>sc", "<Plug>SlimeConfig", { desc = "[s]lime [c]onfiguration" })
			vim.keymap.set("n", "<leader>sp", ":SlimePick<CR>", { desc = "Pick slime target pane" })
		end,
	},
}

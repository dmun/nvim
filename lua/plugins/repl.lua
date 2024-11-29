return {
	"Vigemus/iron.nvim",
	-- enabled = false,
	cmd = "IronRepl",
	ft = { "python", "r" },
	config = function()
		local iron = require("iron.core")
		local python_format = require("iron.fts.common").bracketed_paste
		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					r = {
						-- command = {
						-- 	'jupyter',
						-- 	'console',
						-- 	'--kernel=ark',
						-- 	"--ZMQTerminalInteractiveShell.image_handler='tempfile'",
						-- },
						command = { "R" },
					},
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" },
					},
					python = {
						-- command = { "ipython", "--no-autoindent", "--matplotlib" },
						command = { "jupyter-console", "--existing" },
						format = python_format,
					},
				},
				-- How the repl window will be displayed
				-- See below for more information
				-- repl_open_cmd = require('iron.view').right(40),
				repl_open_cmd = require("iron.view").split(10, {
					winfixwidth = true,
					winfixheight = true,
					number = false,
				}),
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				send_motion = "<space>s",
				visual_send = "<cr>",
				send_file = "<M-r>",
				send_line = "<space>sl",
				send_paragraph = "<space>sp",
				send_until_cursor = "<space>su",
				send_mark = "<space>sm",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				bold = false,
				italic = false,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set("n", "<CR>", " sic", { remap = true, buffer = true })
		vim.keymap.set("n", "<M-b>", "O# %%0j", { remap = true, buffer = true })
		vim.keymap.set("n", "<space>rs", "<Cmd>IronRepl<CR>")
		vim.keymap.set("n", "<space>rr", "<Cmd>IronRestart<CR>")
		vim.keymap.set("n", "<space>rf", "<Cmd>IronFocus<CR>")
		vim.keymap.set("n", "<space>rh", "<Cmd>IronHide<CR>")
	end,
}

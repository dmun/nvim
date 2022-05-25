map("n", "<leader><leader>", [[:lua require('config.util').find_project_files()<CR>]], { silent = true })
-- map('n', '<leader>ff', ':Telescope file_browser<CR>', { silent = true })
map("n", "<leader>/", [[:lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
map("n", "<leader>,", [[:lua require('telescope.builtin').buffers()<CR>]], { silent = true })
map("n", "<leader>.", [[:lua require('telescope.builtin').file_browser()<CR>]], { silent = true })
map("n", "<leader>fh", [[:lua require('telescope.builtin').help_tags()<CR>]], { silent = true })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { silent = true })
map("n", "<leader>pp", ":Telescope projects<CR>", { silent = true })
map("n", "<M-x>", ":Telescope keymaps<CR>", { silent = true })

local actions = require "telescope.actions"
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				["<ESC>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		file_ignore_patterns = { "node_modules", ".git" },
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
}

-- require('telescope').load_extension "file_browser"
require("project_nvim").setup()
require("telescope").load_extension "projects"

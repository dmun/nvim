return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	keys = {
		{ "<leader>f", "<cmd>Telescope find_files<cr>" },
		{ "<leader>l", "<cmd>Telescope oldfiles<cr>" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>,", "<cmd>Telescope buffers<cr>" },
		{ "<leader><leader>", "<cmd>Telescope<cr>" },
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			extensions = {
				["ui-select"] = {},
			},
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
				results_title = "",
				sorting_strategy = "ascending",
				-- layout_strategy = 'center',
				layout_config = {
					prompt_position = "top",
				},
				border = {
					prompt = { 1, 1, 1, 1 },
					results = { 1, 1, 1, 1 },
					preview = { 1, 1, 1, 1 },
				},
				borderchars = {
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
			},
		})

		require("telescope").load_extension("ui-select")
	end,
}

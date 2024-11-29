return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("noice").setup({
			lsp = { signature = { enabled = false } },
			views = {
				cmdline_popup = {
					size = {
						width = "50",
					},
					position = {
						row = "33%",
						col = "50%",
					},
					border = {
						style = "single",
					},
				},
				mini = {
					timeout = 1500,
					position = {
						row = -1,
						col = -1,
					},
					size = {
						-- max_height = 1,
					},
					win_options = {
						winblend = 30,
					},
				},
			},
			notify = {
				enabled = true,
			},
			messages = {
				enabled = true,
			},
			routes = {
				-- { filter = { event = "msg_showmode" } },
				{
					filter = { event = "msg_show", kind = "search_count" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "", find = "before" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "", find = "after" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "", find = "written" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "", find = "Modified" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "", find = "lines" },
					opts = { skip = true },
				},
				-- {
				-- 	filter = { event = "msg_show", kind = "", find = "--" },
				-- 	opts = { skip = true },
				-- },
			},
		})
	end,
}

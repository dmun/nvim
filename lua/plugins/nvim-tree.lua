return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<M-e>", "<cmd>NvimTreeOpen<cr>" },
	},
	opts = {
		view = {
			cursorline = false,
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "<M-e>", api.tree.close, opts("Close"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end,
	},
}

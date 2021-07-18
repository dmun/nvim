require("which-key").setup {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»",
		gsgeparator = "➜",
		group = "+",
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom",
		margin = { 1, 1, 1, 1 },
		padding = { 2, 2, 2, 2 },
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
	show_help = false,
}

require('which-key').register({
	e = { name = 'Explorer' },
	f = { name = 'Finder' },
	h = { name = 'Hunk (GitGutter)' },
	l = { name = 'LazyGit' },
	t = { name = 'Terminal' },
	p = { name = 'Packer' }
}, { prefix = '<leader>' })

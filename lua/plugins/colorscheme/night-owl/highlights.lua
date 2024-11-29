local palette = require("plugins.colorscheme.night-owl.palette")

return {
	fg = palette.fg,
	cursorlinenr = palette.line_number_active_fg,
	dimmed = {
		inactive = palette.line_number_fg,
		subtle = palette.gray6,
	},
	built_in = {
		["function"] = palette.blue,
		constant = palette.blue,
		keyword = palette.magenta,
		variable = palette.cyan2,
		type = palette.orange2,
	},
	gitsigns = {
		remove = palette.sign_delete,
		add = palette.sign_add,
		change = palette.sign_change,
	},
	pum = {
		sbar = palette.dark,
		sel = {
			fg = palette.fg,
			bg = palette.quickfix_line,
		},
		fg = palette.fg,
		bg = palette.dark,
		thumb = palette.ui_border,
	},
	heading = {
		h1 = palette.title,
		h2 = palette.title,
	},
	uri = palette.light_red,
	inc_search = {
		fg = palette.fg,
		bg = palette.incremental_search_blue,
	},
	syntax = {
		tag = palette.light_cyan,
		constant = palette.blue,
		preproc = palette.magenta,
		string = palette.light_orange,
		parameter = palette.parameter,
		field = palette.cyan5,
		variable = palette.parameter,
		number = palette.orange,
		statement = palette.magenta,
		todo = {
			fg = palette.bg,
			bg = palette.fg,
		},
		["function"] = palette.blue,
		punctuation = palette.fg,
		struct = palette.orange2,
		operator = palette.magenta,
		conditional = palette.magenta,
		type = palette.orange2,
		comment = palette.dark_cyan,
		keyword = palette.magenta,
		property = palette.cyan5,
		constructor = palette.blue,
		include = palette.magenta,
	},
	border = palette.ui_border,
	match = palette.match_paren,
	diagnostic = {
		warn = palette.sign_change,
		info = palette.blue,
		error = palette.error_red,
		hint = palette.cyan2,
	},
	bg = {
		alt = palette.dark,
		selected = palette.visual,
		base = palette.bg,
	},
	diff = {
		text = palette.fg,
		remove = palette.sign_delete,
		add = palette.sign_add,
		change = palette.sign_change,
	},
	accent = palette.title,
	search_result = {
		fg = palette.fg,
		bg = palette.search_blue,
		telescope = palette.nvim_tree_file,
	},
}

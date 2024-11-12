return {
	'Saghen/blink.cmp',
	enabled = false,
	lazy = false,
	dependencies = 'rafamadriz/friendly-snippets',
	version = 'v0.*',
	-- build = 'cargo +nightly build --release',
	opts = {
		highlight = { use_nvim_cmp_as_default = true },
		nerd_font_variant = 'normal',
		accept = {
			auto_brackets = { enabled = true },
			kind_resolution = { enabled = true },
			semantic_token_resolution = { enabled = true },
		},
		-- trigger = { signature_help = { enabled = false } },
		windows = { autocomplete = { draw = 'simple' } },
		keymap = {
			show = '<C-space>',
			hide = '<C-c>',
			accept = '<Tab>',
			select_prev = { '<Up>', '<C-p>' },
			select_next = { '<Down>', '<C-n>' },

			show_documentation = {},
			hide_documentation = {},
			scroll_documentation_up = '<C-u>',
			scroll_documentation_down = '<C-d>',

			snippet_forward = '<C-f>',
			snippet_backward = '<C-b>',
		},
	},
}

return {
	'stevearc/conform.nvim',
	keys = {
		{
			'<M-f>',
			function()
				require('conform').format { lsp_format = 'fallback' }
			end,
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			python = { 'black' },
			rust = { 'rustfmt' },
			go = { 'gofmt' },
			typescript = { 'prettier' },
			json = { 'prettier' },
			cpp = { 'clang-format' },
			c = { 'clang-format' },
			tex = { 'latexindent' },
			typst = { 'typstyle' },
			swift = { 'swift-format' },
			odin = { 'odinfmt' },
		},
		formatters = {
			stylua = {
				condition = function(_, ctx)
					return vim.fs.basename(ctx.filename) ~= 'xmake.lua'
				end,
			},
			['swift-format'] = {
				command = 'swift-format',
				args = { '--configuration', '.swift-format' },
			},
			typstyle = {
				command = 'typstyle',
			},
			['clang-format'] = {
				command = 'clang-format',
				args = { '--style', '{BasedOnStyle: LLVM, IndentWidth: 4}' },
			},
		},
	},
}

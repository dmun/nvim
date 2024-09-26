Plug("romainl/vim-cool")
	:disabled()

Plug("numToStr/Comment.nvim")
	:on(Event.VeryLazy)
	:opts()

Plug("echasnovski/mini.nvim")
	:disabled()
	:name("mini.ai")
	:opts()

Plug("kylechui/nvim-surround")
	:disabled()
	:on(Event.VeryLazy)
	:opts()

Plug("windwp/nvim-autopairs")
	:on(Event.InsertEnter)
	:opts()

Plug("VidocqH/auto-indent.nvim")
	:on(Event.InsertEnter)
	:opts()

Plug("lukas-reineke/indent-blankline.nvim")
	:disabled()
	:name("ibl")
	:opts {
		indent = {
			char = "▏",
		},
		scope = { enabled = false },
	}

Plug("RRethy/vim-illuminate")
	:config(function()
		require("illuminate").configure {
			providers = { "lsp", "treesitter" }
		}
	end)

Plug("NMAC427/guess-indent.nvim")
	:on(Event.BufReadPre, Event.BufNewFile)
	:opts()

Plug("kosayoda/nvim-lightbulb") {
	autocmd = { enabled = true },
	sign = {
		text = "",
		hl = "DiagnosticWarn"
	}
}

Plug("kevinhwang91/nvim-ufo")
	:on(Event.BufRead, Event.BufNewFile)
	:dependencies { "kevinhwang91/promise-async" }
	:opts {
		provider_selector = function()
			return { "treesitter", "indent" }
		end
	}

Plug("folke/trouble.nvim")
	:opts {
		focus = true
	}

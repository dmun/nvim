Plug("tpope/vim-rsi")

Plug("ggandor/leap.nvim")
    :keys {
        { "s", "<Plug>(leap-forward)", { "n", "x", "o" } },
		{ "S", "<Plug>(leap-backward)", { "n", "x", "o" } },
		{ "gs", "<Plug>(leap-from-window)", { "n", "x", "o" } },
    }

Plug("justinmk/vim-sneak")
    :on(Event.VeryLazy)
    :keys {
		{ "f", "<Plug>Sneak_f" },
		{ "F", "<Plug>Sneak_F" },
		{ "t", "<Plug>Sneak_t" },
		{ "T", "<Plug>Sneak_T" },
	}
	:disabled()

Plug("nacro90/numb.nvim")
	:on(Event.CmdLineEnter)
	:opts()

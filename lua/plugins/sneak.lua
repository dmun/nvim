return {
	"justinmk/vim-sneak",
	event = "VeryLazy",
	keys = {
		{ "f", "<Plug>Sneak_f" },
		{ "F", "<Plug>Sneak_F" },
		{ "t", "<Plug>Sneak_t" },
		{ "T", "<Plug>Sneak_T" },
	},
	config = function()
		vim.cmd("hi! Sneak guifg=#ff00ff guibg=NONE")

		vim.api.nvim_create_autocmd("WinClosed", {
			callback = function()
				vim.cmd.call("sneak#cancel()")
			end,
		})
	end,
}

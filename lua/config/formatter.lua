map("n", "<leader>mf", ":Format<CR>", { silent = false })

require("formatter").setup {
	filetype = {
		haskell = {
			function()
				return { exe = "brittany", args = { "--indent=4" }, stdin = true }
			end,
		},
		lua = {
			function()
				return { exe = "stylua", stdin = false }
			end,
		},
	},
}

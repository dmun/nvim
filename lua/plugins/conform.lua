vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format { bufnr = args.buf }
	end,
})

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
	},
	-- config = function(_, opts)
	-- 	require("conform").setup(opts)
	-- end,
}

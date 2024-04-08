local conform = require("conform")

conform.setup {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },
		go = { "gofmt" },
	},
}

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format { bufnr = args.buf }
	end,
})

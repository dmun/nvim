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
			typescript = { "prettier" },
			cpp = { "clang-format" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")

		conform.formatters["clang-format"] = {
			command = "clang-format",
			args = { "--style", "{BasedOnStyle: LLVM, IndentWidth: 4}" },
		}

		conform.setup(opts)
	end,
}

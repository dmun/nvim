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
			c = { "clang-format" },
			tex = { "latexindent" },
		},
		formatters = {
			stylua = {
				condition = function(_, ctx)
					return vim.fs.basename(ctx.filename) ~= "premake5.lua"
				end,
			},
			["clang-format"] = {
				command = "clang-format",
				args = { "--style", "{BasedOnStyle: Webkit, IndentWidth: 4}" },
			},
		},
	},
}

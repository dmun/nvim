Plug("stevearc/conform.nvim")
	:keys {
		{ "<M-f>", function() require("conform").format() end }
	}
	:opts {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			typescript = { "prettier" },
			json = { "prettier" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			tex = { "latexindent" },
			typst = { "typstyle" },
			swift = { "swift-format" },
		},
		formatters = {
			stylua = {
				condition = function(_, ctx)
					return vim.fs.basename(ctx.filename) ~= "xmake.lua"
				end,
			},
			["swift-format"] = {
				command = "swift-format",
				args = { "--configuration", ".swift-format" },
			},
			typstyle = {
				command = "typstyle",
			},
			["clang-format"] = {
				command = "clang-format",
				args = { "--style", "{BasedOnStyle: Webkit, IndentWidth: 4}" },
			},
		},
	}

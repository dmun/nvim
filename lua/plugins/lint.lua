Plug("mfussenegger/nvim-lint")
	:on(Event.BufWritePost)
	:config(function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- lua = { "luacheck" },
			typescript = { "eslint" },
			swift = { "swiftlint" },
		}

		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				lint.try_lint()
			end,
		})
	end)

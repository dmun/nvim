Plug("chomosuke/typst-preview.nvim")
	:ft("typst")
	:keys {
		{
			"<leader>tt",
			function()
				vim.cmd.TypstPreview("slide")
				vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
					command = "typst-lsp.doPinMain",
					arguments = { vim.uri_from_fname(vim.fn.getcwd() .. "/main.typ") },
				}, 1000)
			end,
		},
		{ "<C-c>", "<cmd>TypstPreviewSyncCursor<cr>" },
	}
	:opts {
		debug = false,
		follow_cursor = false,
	}
	:build(function()
		require("typst-preview").update()
	end)

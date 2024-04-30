return {
	"ggandor/leap.nvim",
	config = function()
		require("leap").create_default_mappings()

		-- Hide the (real) cursor when leaping, and restore it afterwards.
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapEnter",
			callback = function()
				vim.cmd.hi("Cursor", "blend=100")
				vim.opt.guicursor:append { "a:Cursor/lCursor" }
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapLeave",
			callback = function()
				vim.cmd.hi("Cursor", "blend=0")
				vim.opt.guicursor:remove { "a:Cursor/lCursor" }
			end,
		})
	end,
}

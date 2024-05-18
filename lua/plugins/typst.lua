return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	keys = {
		{ "<leader>tt", "<cmd>TypstPreviewToggle<cr>" },
	},
	build = function()
		require("typst-preview").update()
	end,
}

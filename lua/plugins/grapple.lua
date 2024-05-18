return {
	"cbochs/grapple.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	keys = {
		{ "<leader>q", "<cmd>Grapple toggle_tags<cr>" },
		{ "<leader>m", "<cmd>Grapple tag<cr>" },
		{ "<leader>1", "<cmd>Grapple select index=1<cr>" },
		{ "<leader>2", "<cmd>Grapple select index=2<cr>" },
		{ "<leader>3", "<cmd>Grapple select index=3<cr>" },
		{ "<leader>4", "<cmd>Grapple select index=4<cr>" },
		{ "<leader>5", "<cmd>Grapple select index=5<cr>" },
	},
	opts = {
		scope = "cwd",
	},
}

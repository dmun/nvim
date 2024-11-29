return {
	dir = "~/Development/jupynium.nvim",
	build = "pip3 install --user .",
	-- build = "conda run --no-capture-output -n jupynium pip install .",
	-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	keys = {
		-- { "<CR>", "<cmd>JupyniumExecuteSelectedCells<CR>" },
	},
	opts = {
		-- use_default_keybindings = false,
	},
}

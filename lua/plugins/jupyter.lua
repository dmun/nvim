return {
	dir = "~/Development/jupynium.nvim",
	enabled = false,
	ft = 'python',
	build = "pip3 install --user .",
	-- build = "conda run --no-capture-output -n jupynium pip install .",
	-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
}

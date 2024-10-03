return {
	'kiyoon/jupynium.nvim',
	-- enabled = false,
	build = 'pip3 install --user .',
    opts = {
        python_host = 'python',
        default_notebook_URL = 'localhost:8888/nbclassic'
    }
	-- build = "conda run --no-capture-output -n jupynium pip install .",
	-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
}

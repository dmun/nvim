local callback = function(event)
	local set = vim.keymap.set
	set({ "n", "x" }, "<CR>", "<cmd>JupyniumExecuteSelectedCells<CR>", { buffer = event.buf })
	set({ "n", "x" }, "<space>c", "<cmd>JupyniumClearSelectedCellsOutputs<CR>", { buffer = event.buf })
	set({ "n" }, "<space>K", "<cmd>JupyniumKernelHover<cr>", { buffer = event.buf })
	set({ "n", "x" }, "<space>js", "<cmd>JupyniumScrollToCell<cr>", { buffer = event.buf })
	set({ "n", "x" }, "<space>jo", "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>", { buffer = event.buf })
	set("", "<PageUp>", "<cmd>JupyniumScrollUp<cr>", { buffer = event.buf })
	set("", "<PageDown>", "<cmd>JupyniumScrollDown<cr>", { buffer = event.buf })
set(
		{ "n", "x", "o" },
		"<Up>",
		"<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
		{ buffer = event.buf }
	)
	set(
		{ "n", "x", "o" },
		"<Down>",
		"<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
		{ buffer = event.buf }
	)
	set(
		{ "n", "x", "o" },
		"<space>jj",
		"<cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<cr>",
		{ buffer = event.buf }
	)
	set({ "x", "o" }, "aj", "<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>", { buffer = event.buf })
	set({ "x", "o" }, "ij", "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>", { buffer = event.buf })
	set({ "x", "o" }, "aJ", "<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>", { buffer = event.buf })
	set({ "x", "o" }, "iJ", "<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>", { buffer = event.buf })
end
return {
	"kiyoon/jupynium.nvim",
	cmd = "JupyniumStartAndAttachToServer",
	build = "pip3 install --user .",
	-- build = "conda run --no-capture-output -n jupynium pip install .",
	-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	config = function()
		require("jupynium").setup({ use_default_keybindings = false })

		vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
			group = "jupynium",
			pattern = "*.ju.py",
			callback = callback,
		})
	end,
}

-- highlight on yank
local hi_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = hi_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- auto-save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("silent update")
		end
	end,
})

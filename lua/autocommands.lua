-- filetypes
vim.cmd("au BufRead,BufEnter *.swiftinterface se ft=swift")
vim.cmd("au BufRead,BufEnter .swift-format se ft=json")

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

-- clear cmdline
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		vim.fn.timer_start(1000, function()
			print(" ")
		end)
	end,
})

-- dynamic linenumbers
if false then
	vim.cmd("au InsertEnter * se nornu")
	vim.cmd("au InsertLeave * se rnu")
end

-- dynamic CursorLineNr color
if false then
	vim.cmd("au InsertEnter * se winhl=CursorLineNr:iCursorLineNr")
	vim.cmd("au InsertLeave * se winhl=CursorLineNr:nCursorLineNr")
end

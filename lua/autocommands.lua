-- filetypes
vim.cmd('au BufRead,BufEnter *.swiftinterface se ft=swift')
vim.cmd('au BufRead,BufEnter .swift-format se ft=json')
vim.cmd('au BufRead,BufEnter *.dagitty se ft=luau')

-- highlight on yank
local hi_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = '*',
	group = hi_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- -- auto-save
-- vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
-- 	callback = function()
-- 		if vim.bo.buftype == '' then
-- 			vim.cmd('silent update')
-- 		end
-- 	end,
-- })

-- terminal
vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter', 'BufReadPre', 'BufReadPost' }, {
	callback = function()
		if vim.bo.buftype == 'terminal' then
			-- vim.opt_local.relativenumber = false
			-- vim.opt_local.number = false
			vim.cmd.normal('i')
		end
	end,
})

-- -- dynamic linenumbers
-- vim.cmd('au InsertEnter * se nornu')
-- vim.cmd('au InsertLeave * se rnu')

-- -- dynamic CursorLineNr color
-- vim.cmd('au InsertEnter * se winhl=CursorLineNr:iCursorLineNr')
-- vim.cmd('au InsertLeave * se winhl=CursorLineNr:nCursorLineNr')

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

-- auto-save
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
	callback = function()
		if vim.bo.buftype == '' then
			vim.cmd('silent update')
		end
	end,
})

-- statusline
vim.api.nvim_create_autocmd({ 'WinResized' }, {
	callback = function()
		vim.api.nvim_set_hl(0, 'Statusline', { link = 'Normal' })
		vim.api.nvim_set_hl(0, 'StatuslineNC', { link = 'Normal' })
		local str = string.rep('─', vim.api.nvim_win_get_width(0))
		vim.opt.statusline = str
		vim.opt.statusline = '%#WinSeparator#' .. str .. '%*'
	end,
})

-- terminal
vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter', 'BufReadPre', 'BufReadPost' }, {
	callback = function()
		if vim.bo.buftype == 'terminal' then
			vim.opt_local.relativenumber = false
			vim.opt_local.number = false
		end
	end,
})

-- -- dynamic linenumbers
-- vim.cmd('au InsertEnter * se nornu')
-- vim.cmd('au InsertLeave * se rnu')

-- -- dynamic CursorLineNr color
-- vim.cmd('au InsertEnter * se winhl=CursorLineNr:iCursorLineNr')
-- vim.cmd('au InsertLeave * se winhl=CursorLineNr:nCursorLineNr')

-- vim.api.nvim_create_autocmd('ColorScheme', {
-- 	callback = function()
-- 		local path = vim.fn.stdpath('cache') .. '/colorscheme'
-- 		local fd, err, _ = vim.uv.fs_open(path, 'w+', 438)
--
-- 		if not fd then
-- 			error(err)
-- 		end
--
-- 		local str = vim.api.nvim_exec2('color', { output = true }).output
-- 		vim.uv.fs_write(fd, str, 0)
--
-- 		vim.uv.fs_close(fd)
-- 	end,
-- })

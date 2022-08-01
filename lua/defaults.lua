-- Load .vimrc.
vim.cmd "source $HOME/.config/nvim/.vimrc"

-- Highlight on yank.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Choose colorscheme.
vim.cmd "color doom-one"

-- Add support for commandline color
vim.cmd "autocmd BufEnter * if &bt != 'nofile' | setlocal winhl=Normal:NormalBuffer"

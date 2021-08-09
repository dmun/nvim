vim.g.bufferline = {
	closable = false,
	icons = false,
	icon_separator_inactive = '▏',
	maximum_padding = 8,
}

map('n', '<M-n>', ':BufferNext<CR>', { silent = true })
map('n', '<M-p>', ':BufferPrevious<CR>', { silent = true })
map('n', '<M-w>', ':BufferClose<CR>', { silent = true })
map('n', '<M-N>', ':BufferMoveNext<CR>', { silent = true })
map('n', '<M-P>', ':BufferMovePrevious<CR>', { silent = true })

for i = 1, 10, 1 do
	map('n', '<M-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', { silent = true })
end

vim.g.bufferline = {
    auto_hide = true,
    icon_separator_inactive = ' ',
    animation = false,
}

map('n', '<M-n>', ':BufferNext<CR>', { silent = true })
map('n', '<M-p>', ':BufferPrevious<CR>', { silent = true })
map('n', '<M-w>', ':BufferClose<CR>', { silent = true })
map('n', '<M-N>', ':BufferMoveNext<CR>', { silent = true })
map('n', '<M-P>', ':BufferMovePrevious<CR>', { silent = true })

map('i', '<M-n>', '<ESC>:BufferNext<CR>', { silent = true })
map('i', '<M-p>', '<ESC>:BufferPrevious<CR>', { silent = true })
map('i', '<M-w>', '<ESC>:BufferClose<CR>', { silent = true })
map('i', '<M-N>', '<ESC>:BufferMoveNext<CR>', { silent = true })
map('i', '<M-P>', '<ESC>:BufferMovePrevious<CR>', { silent = true })

map('t', '<M-n>', '<C-\\><C-n>:BufferNext<CR>', { silent = true })
map('t', '<M-p>', '<C-\\><C-n>:BufferPrevious<CR>', { silent = true })
map('t', '<M-w>', '<C-\\><C-n>:BufferClose<CR>', { silent = true })
map('t', '<M-N>', '<C-\\><C-n>:BufferMoveNext<CR>', { silent = true })
map('t', '<M-P>', '<C-\\><C-n>:BufferMovePrevious<CR>', { silent = true })

for i = 1, 10, 1 do
	map('n', '<M-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', { silent = true })
	map('i', '<M-' .. i .. '>', '<ESC>:BufferGoto ' .. i .. '<CR>', { silent = true })
	map('t', '<M-' .. i .. '>', '<C-\\><C-n>:BufferGoto ' .. i .. '<CR>', { silent = true })
end

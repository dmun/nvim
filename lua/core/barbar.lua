vim.g.bufferline = {
	auto_hide = true,
	icon_separator_inactive = " ",
	animation = false,
}

vim.keymap.set("n", "<M-n>", ":BufferNext<CR>", { silent = true })
vim.keymap.set("n", "<M-p>", ":BufferPrevious<CR>", { silent = true })
vim.keymap.set("n", "<M-w>", ":BufferClose<CR>", { silent = true })
vim.keymap.set("n", "<M-N>", ":BufferMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<M-P>", ":BufferMovePrevious<CR>", { silent = true })

vim.keymap.set("i", "<M-n>", "<ESC>:BufferNext<CR>", { silent = true })
vim.keymap.set("i", "<M-p>", "<ESC>:BufferPrevious<CR>", { silent = true })
vim.keymap.set("i", "<M-w>", "<ESC>:BufferClose<CR>", { silent = true })
vim.keymap.set("i", "<M-N>", "<ESC>:BufferMoveNext<CR>", { silent = true })
vim.keymap.set("i", "<M-P>", "<ESC>:BufferMovePrevious<CR>", { silent = true })

vim.keymap.set("t", "<M-n>", "<C-\\><C-n>:BufferNext<CR>", { silent = true })
vim.keymap.set("t", "<M-p>", "<C-\\><C-n>:BufferPrevious<CR>", { silent = true })
vim.keymap.set("t", "<M-w>", "<C-\\><C-n>:BufferClose<CR>", { silent = true })
vim.keymap.set("t", "<M-N>", "<C-\\><C-n>:BufferMoveNext<CR>", { silent = true })
vim.keymap.set("t", "<M-P>", "<C-\\><C-n>:BufferMovePrevious<CR>", { silent = true })

for i = 1, 10, 1 do
	vim.keymap.set("n", "<M-" .. i .. ">", ":BufferGoto " .. i .. "<CR>", { silent = true })
	vim.keymap.set("i", "<M-" .. i .. ">", "<ESC>:BufferGoto " .. i .. "<CR>", { silent = true })
	vim.keymap.set("t", "<M-" .. i .. ">", "<C-\\><C-n>:BufferGoto " .. i .. "<CR>", { silent = true })
end

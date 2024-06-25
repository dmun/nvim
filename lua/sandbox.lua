local test = vim.uv.new_async(function()
	print("bruh")
end)

vim.keymap.set("n", "<C-g>", function()
    vim.api.nvim_buf_add_highlight(0, 1, '@error', 0, 0, 10)
end)

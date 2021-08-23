map('n', '<leader><leader>', [[:lua require('telescope.builtin').find_files()<CR>]], { silent = true })
map('n', '<leader>/', [[:lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
map('n', '<leader>,', [[:lua require('telescope.builtin').buffers()<CR>]], { silent = true })
map('n', '<leader>.', [[:lua require('telescope.builtin').file_browser()<CR>]], { silent = true })
map('n', '<leader>fh', [[:lua require('telescope.builtin').help_tags()<CR>]], { silent = true })

require'telescope'.setup {
	pickers = {
		find_files = {
			theme = 'dropdown',
			previewer = false,
		},
	}
}

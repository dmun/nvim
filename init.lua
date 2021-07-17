map = vim.api.nvim_set_keymap

-- Plugins
require('plugins')


-- Vim settings
vim.cmd('source $HOME/.config/nvim/.vimrc')

-- Plugin settings
require('settings')

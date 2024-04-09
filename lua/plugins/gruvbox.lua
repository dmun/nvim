local gruvbox = require("gruvbox")

gruvbox.setup {
	contrast = "hard",
}

vim.cmd.Rocks {
	"packadd",
	"gruvbox.nvim",
}

vim.cmd.colorscheme("gruvbox")

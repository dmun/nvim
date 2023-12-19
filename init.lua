-- Optimize startup time.
pcall(require, "impatient")

-- Load Neovim defaults.
require "defaults"

-- Load plugins.
require "plugins"

-- Load configs (temporary).
require "core.ufo"
require "core.cmp"
require "core.colorizer"
require "core.gitsigns"
require "core.lspconfig"
require "core.mason"
require "core.lspkind"
require "core.lualine"
require "core.catppuccin"
require "core.packer"
require "core.pairs"
require "core.tree"
require "core.treesitter"
require "core.neorg"
require "core.fzf"

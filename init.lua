-- Optimize startup time.
pcall(require, "impatient")

-- Load Neovim defaults.
require "defaults"

-- Load plugins.
require "plugins"

-- Load configs (temporary).
require "core.cmp"
require "core.colorizer"
require "core.gitsigns"
require "core.lspconfig"
require "core.lspinstall"
require "core.lspkind"
require "core.lualine"
require "core.null-ls"
require "core.packer"
require "core.pairs"
require "core.telescope"
require "core.tree"
require "core.treesitter"
require "core.scrollbar"

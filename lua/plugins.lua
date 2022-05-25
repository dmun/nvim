vim.cmd "packadd packer.nvim"

return require("packer").startup {
	function()
		use { "wbthomason/packer.nvim", config = require "core.packer" }
		use "lewis6991/impatient.nvim"

		--	Colors
		use {
			"norcalli/nvim-colorizer.lua",
			config = function()
				require "core.colorizer"
			end,
		}
		use { "dmun/doom-one.nvim", branch = "personal" }

		--	Git
		use { "lewis6991/gitsigns.nvim", config = require "core.gitsigns" }

		--	LSP
		use { "neovim/nvim-lspconfig", config = require "core.lspconfig" }
		use { "williamboman/nvim-lsp-installer", config = require "core.lspinstall" }
		use { "onsails/lspkind-nvim", config = require "core.lspkind" }
		use { "jose-elias-alvarez/null-ls.nvim", config = require "core.null-ls" }
		use {
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		}

		--  Autocomplete
		use { "hrsh7th/nvim-cmp", config = require "core.cmp" }
		use "hrsh7th/cmp-buffer"
		use "hrsh7th/cmp-nvim-lua"
		use "hrsh7th/cmp-nvim-lsp"
		use "L3MON4D3/LuaSnip"
		use "saadparwaiz1/cmp_luasnip"
		use { "rafamadriz/friendly-snippets", config = require("luasnip/loaders/from_vscode").lazy_load() }

		--	IDE like
		use { "nvim-treesitter/nvim-treesitter", config = require "core.treesitter" }
		use { "kyazdani42/nvim-tree.lua", config = require "core.tree" }
		use { "nvim-telescope/telescope.nvim", config = require "core.telescope" }
		use "ahmedkhalf/project.nvim"
		use {
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		}

		--	Appearance
		use "kyazdani42/nvim-web-devicons"
		use { "nvim-lualine/lualine.nvim", config = require "core.lualine" }
		use { "lukas-reineke/indent-blankline.nvim", config = require "core.indentline" }

		--	Misc
		use "airblade/vim-rooter"
		use "nvim-lua/popup.nvim"
		use "nvim-lua/plenary.nvim"
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	},
}

vim.cmd('packadd packer.nvim')

return require('packer').startup({
	function ()
		use 'wbthomason/packer.nvim'

	--	Colors
		use 'norcalli/nvim-colorizer.lua'
		use { 'dmun/doom-one.nvim', branch = 'personal' }
        use 'projekt0n/github-nvim-theme'
        use 'rmehri01/onenord.nvim'

	--	Git
		use 'lewis6991/gitsigns.nvim'
		use 'kdheepak/lazygit.nvim'
		use 'TimUntersberger/neogit'

	--	LSP
		use 'neovim/nvim-lspconfig'
		use 'williamboman/nvim-lsp-installer'
		use 'onsails/lspkind-nvim'
        use 'jose-elias-alvarez/null-ls.nvim'

    --  Autocomplete
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-nvim-lua'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use { 'rafamadriz/friendly-snippets', config = require("luasnip/loaders/from_vscode").lazy_load() }
    --use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

	--	IDE like
		use 'nvim-treesitter/nvim-treesitter'
		use 'tpope/vim-surround'
		use 'kyazdani42/nvim-tree.lua'
		use 'nvim-telescope/telescope.nvim'
		use 'windwp/nvim-autopairs'
		use 'lervag/vimtex'

	--	Appearance
		use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
		use 'romgrk/barbar.nvim'

	--	Misc
		use 'folke/zen-mode.nvim'
		use 'folke/which-key.nvim'
		use 'mhinz/vim-startify'
		use 'airblade/vim-rooter'
		use 'iamcco/markdown-preview.nvim' --, { 'do': 'cd app && yarn install'  }
		use 'nvim-lua/popup.nvim'
		use 'nvim-lua/plenary.nvim'
	end,
	config = {
		display = {
			open_fn = function ()
				return require('packer.util').float({ border = 'rounded' })
			end
		}
	}
})

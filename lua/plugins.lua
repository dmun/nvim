vim.cmd('packadd packer.nvim')

return require('packer').startup({
	function ()
		use 'wbthomason/packer.nvim'

	--	Colors
		use 'norcalli/nvim-colorizer.lua'
		use { 'dmun/doom-one.nvim', branch = 'personal' }

	--	Git
		use 'lewis6991/gitsigns.nvim'
		use 'kdheepak/lazygit.nvim'
		use 'TimUntersberger/neogit'

	--	LSP
		use 'neovim/nvim-lspconfig'
		use 'kabouzeid/nvim-lspinstall'
		use 'hrsh7th/nvim-compe'
		use 'onsails/lspkind-nvim'

	--	IDE like
		use 'nvim-treesitter/nvim-treesitter'
		use 'tpope/vim-surround'
		use 'kyazdani42/nvim-tree.lua'
		use 'nvim-telescope/telescope.nvim'
		use 'windwp/nvim-autopairs'
        use 'mhartington/formatter.nvim'
		use 'lervag/vimtex'

	--	Appearance
		use 'kyazdani42/nvim-web-devicons'
		use { 'NTBBloodbath/galaxyline.nvim', branch = 'main' }
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
				return require('packer.util').float({ border = 'none' })
			end
		}
	}
})

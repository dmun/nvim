vim.cmd "packadd packer.nvim"

return require("packer").startup {
    function()
        use "wbthomason/packer.nvim"
        use "lewis6991/impatient.nvim"

        --	Colors
        use "norcalli/nvim-colorizer.lua"
        use { "~/Development/nvim", as = "catppuccin" }
		use { "rktjmp/lush.nvim" }
		use { "metalelf0/jellybeans-nvim" }
        use "EdenEast/nightfox.nvim" -- Packer
        use "dotsilas/darcubox-nvim"
        -- use { "catppuccin/nvim", as = "catppuccin" }
        use "jacoborus/tender.vim"
        use "shaunsingh/nord.nvim"
        use "bluz71/vim-moonfly-colors"

        --	Git
        use "lewis6991/gitsigns.nvim"

        --	LSP
        use "neovim/nvim-lspconfig"
        use "williamboman/mason.nvim"
        use "williamboman/mason-lspconfig.nvim"
        use "onsails/lspkind-nvim"
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        }
        use { "jalvesaq/Nvim-R", branch = "stable" }
		-- use { "rhysd/vim-grammarous" }

        --  Autocomplete
        use { "hrsh7th/nvim-cmp", commit = "1cad30f"}
        -- use "hrsh7th/nvim-c p"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-nvim-lsp"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use { "rafamadriz/friendly-snippets", config = require("luasnip/loaders/from_vscode").lazy_load() }
		-- use "github/copilot.vim"

        --	IDE like
        use "nvim-treesitter/nvim-treesitter"
        use {
            "nvim-neo-tree/neo-tree.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
        }
        use "nvim-telescope/telescope.nvim"
        use "ahmedkhalf/project.nvim"
        use "windwp/nvim-autopairs"

        --	Appearance
        use "kyazdani42/nvim-web-devicons"
        use "nvim-lualine/lualine.nvim"
        use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

        --	Misc
        use "airblade/vim-rooter"
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use {
            "nvim-neorg/neorg",
            config = function()
                require('neorg').setup {
                    load = {
                        ["core.defaults"] = {}, -- Loads default behaviour
                        ["core.concealer"] = {}, -- Adds pretty icons to your documents
                        ["core.dirman"] = { -- Manages Neorg workspaces
                            config = {
                                workspaces = {
                                    notes = "~/notes",
                                },
                            },
                        },
                    },
                }
            end,
            run = ":Neorg sync-parsers",
            requires = "nvim-lua/plenary.nvim",
        }
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "none" }
            end,
        },
    },
}

vim.cmd "packadd packer.nvim"

return require("packer").startup {
    function()
        use "wbthomason/packer.nvim"
        use "lewis6991/impatient.nvim"

        --	Colors
        use "norcalli/nvim-colorizer.lua"
        use { "catppuccin/nvim", as = "catppuccin" }

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
        use { "ibhagwan/fzf-lua" }

        --  Autocomplete
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-nvim-lsp"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use { "rafamadriz/friendly-snippets", config = require("luasnip/loaders/from_vscode").lazy_load() }

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
        use "windwp/nvim-autopairs"

        --	Appearance
        use "kyazdani42/nvim-web-devicons"
        use "nvim-lualine/lualine.nvim"

        --	Misc
        use "airblade/vim-rooter"
        use "nvim-lua/plenary.nvim"
        use {
            "nvim-neorg/neorg",
            config = function()
                require('neorg').setup {
                    load = {
                        ["core.defaults"] = {},  -- Loads default behaviour
                        ["core.concealer"] = {}, -- Adds pretty icons to your documents
                        ["core.dirman"] = {      -- Manages Neorg workspaces
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

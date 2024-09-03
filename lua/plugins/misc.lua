Plug("eandrju/cellular-automaton.nvim")
    :cmd("CellularAutomaton")

Plug:dir("~/Development/ad.nvim")
    :disabled()
    :opts()

Plug("darfink/vim-plist")

Plug("stevearc/profile.nvim")

Plug("quarto-dev/quarto-nvim")
    :dependencies {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
    }
    -- :keys {
    --     { '<leader>up', '<cmd>QuartoPreview<cr>' },
    -- }
    -- :opts()

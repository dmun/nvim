return {
  { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
  {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000,
    lazy = false,
    config = function()
      require("snacks").setup({
        bigfile = {},
        quickfile = {},
        statuscolumn = { enabled = false },
        words = { enabled = false },
      })
    end,
  },
}

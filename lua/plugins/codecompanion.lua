return require "lazier" {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local cc = require("codecompanion")
    local map = vim.keymap.set

    cc.setup({
      display = {
        chat = {
          window = {
            layout = "horizontal",
            position = "bottom",
            height = 0.5,
            width = 1.0,
          },
        },
      },
    })

    map("n", "<leader>l", cc.chat)
  end,
}

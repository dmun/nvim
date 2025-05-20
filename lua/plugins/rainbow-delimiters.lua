return {
  "hiphish/rainbow-delimiters.nvim",
  lazy = false,
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("rainbow-delimiters.setup").setup({
      query = {
        [""] = "rainbow-parens",
      },
      priority = {
        [""] = 120,
      },
    })
  end,
}

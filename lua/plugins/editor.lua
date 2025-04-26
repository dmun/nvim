return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup()
    require("nvim-autopairs").remove_rule("`")
  end,
}

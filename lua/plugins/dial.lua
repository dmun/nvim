return require "lazier" {
  "monaqa/dial.nvim",
  config = function()
    local augend = require "dial.augend"
    local dial = require "dial.map"
    local map = vim.keymap.set

    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        augend.date.alias["%Y/%m/%d"],
      },
    }

    map("n", "<C-a>", function() dial.manipulate("increment", "normal") end)
    map("n", "<C-x>", function() dial.manipulate("decrement", "normal") end)
    map("n", "g<C-a>", function() dial.manipulate("increment", "gnormal") end)
    map("n", "g<C-x>", function() dial.manipulate("decrement", "gnormal") end)
    map("v", "<C-a>", function() dial.manipulate("increment", "visual") end)
    map("v", "<C-x>", function() dial.manipulate("decrement", "visual") end)
    map("v", "g<C-a>", function() dial.manipulate("increment", "gvisual") end)
    map("v", "g<C-x>", function() dial.manipulate("decrement", "gvisual") end)
  end,
}

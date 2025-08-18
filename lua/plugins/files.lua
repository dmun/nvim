add({
  source = "stevearc/oil.nvim",
  depends = { "echasnovski/mini.icons" },
})
local oil = require("oil")
oil.setup({
  preview_win = {},
  keymaps = {
    ["<Tab>"] = "actions.select",
  },
})

nmap("-", oil.open)
nmap("q", oil.close)

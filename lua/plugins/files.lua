add({
  source = "stevearc/oil.nvim",
  depends = { "echasnovski/mini.icons" },
})
local oil = require("oil")
oil.setup()

nmap("-", function()
  oil.open(nil, {
    horizontal = true,
  })
end)

add("mistweaverco/kulala.nvim")
local kulala = require("kulala")
kulala.setup({
  global_keymaps = false,
})

map("mr", kulala.run)

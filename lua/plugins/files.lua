local map = vim.keymap.set

return {
  "echasnovski/mini.files",
  config = function()
    local mini = require("mini.files")
    mini.setup({
      mappings = {
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
      },
    })
    map("n", "-", mini.open)
  end,
}

return {
  "cbochs/grapple.nvim",
  config = function()
    local grapple = require("grapple")
    local map = vim.keymap.set

    grapple.setup({
      win_opts = {
        width = 999,
        height = 12,
        row = 0,
        col = 0,

        relative = "editor",
        border = "single",
        focusable = false,
        style = "minimal",

        title = "",
        title_pos = "left",
        title_padding = " ",

        footer = "",
      },
    })

    map("n", "<leader>g", grapple.toggle_tags)
    map("n", "<leader>a", grapple.toggle)
    for i = 1, 5 do
      map("n", "<leader>" .. i, function() grapple.select({ index = i }) end)
    end
  end,
}

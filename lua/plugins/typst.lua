return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  keys = {
    { "<C-c>", "<cmd>TypstPreviewSyncCursor<cr>" },
  },
  opts = {
    debug = false,
    follow_cursor = false,
  },
  build = function()
    require("typst-preview").update()
  end,
}

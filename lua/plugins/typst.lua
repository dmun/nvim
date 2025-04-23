return {
  "chomosuke/typst-preview.nvim",
  config = function()
    require("typst-preview").setup({
      debug = false,
      follow_cursor = false,
    })
    vim.keymap.set("n", "<C-c>", vim.cmd.TypstPreviewSyncCursor)
  end,
  build = function() require("typst-preview").update() end,
}

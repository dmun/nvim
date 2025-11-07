-- add({
--   source = "dmun/llemper.nvim",
--   depends = { "nvim-lua/plenary.nvim" },
-- })
-- require("llemper").setup()

-- add("zbirenbaum/copilot.lua")
require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = { accept = "<Tab>" },
  },
  filetypes = {
    ["*"] = false,
    javascript = true,
    typescript = true,
    python = true,
  },
})

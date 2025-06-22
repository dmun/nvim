add("nvim-lua/plenary.nvim")

-- local stab = require("util.autocomplete")
-- stab.setup()
-- nmap("<S-Tab>", stab.complete)
-- imap("<Tab>",   stab.complete)

add("zbirenbaum/copilot.lua")
require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<S-Tab>",
    },
  },
})

add({
  source = "dmun/llemper.nvim",
  depends = { "nvim-lua/plenary.nvim" },
})
-- require("llemper").setup()

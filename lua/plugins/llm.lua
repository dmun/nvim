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

-- add("supermaven-inc/supermaven-nvim")
-- require("supermaven-nvim").setup({
--   keymaps = {
--     accept_suggestion = "<Tab>",
--   },
-- })

-- add("copilotlsp-nvim/copilot-lsp")
-- vim.g.copilot_nes_debounce = 500
-- vim.lsp.enable("copilot_ls")
-- vim.keymap.set({ "n", "i" }, "<S-Tab>", function()
--   local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
--     or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
-- end)

add({
  source = "dmun/llemper.nvim",
  depends = { "nvim-lua/plenary.nvim" },
})
-- require("llemper").setup()

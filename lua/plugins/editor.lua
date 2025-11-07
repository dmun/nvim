-- add("tpope/vim-sleuth")
-- add("stevearc/conform.nvim")
-- add("stevearc/quicker.nvim")

require("quicker").setup({
  opts = { signcolumn = "no" },
})

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    jsonc = { "prettier" },
    nix = { "nixfmt" },
    css = { "prettier" },
    fennel = { "fnlfmt" },
    svelte = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
  },
  formatters = {
    qmlformat = { command = "qmlformat" },
  },
})
vim.keymap.set("", "<LocalLeader>f", function()
  conform.format({ lsp_format = "fallback" })
end)

-- Pairs
-- add("windwp/nvim-autopairs")
-- add({
--   source = "saghen/blink.pairs",
--   checkout = "v0.3.0",
--   depends = { "saghen/blink.download" },
-- })

require("nvim-autopairs").setup({})
require("blink.pairs").setup({
  mappings = { enabled = false },
})
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if not vim.tbl_contains({ "tsx" }, vim.bo.filetype) then
      vim.opt_local.winhl = "BlinkPairsOrange:Delimiter,BlinkPairsPurple:Delimiter,BlinkPairsBlue:Delimiter"
    end
  end,
})

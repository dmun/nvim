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
require("nvim-autopairs").setup({})

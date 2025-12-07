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
require("blink.pairs").setup({
  mappings = { enabled = false },
})
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if not vim.tbl_contains({ "typescriptreact" }, vim.bo.filetype) then
      vim.opt_local.winhl = "BlinkPairsOrange:Delimiter,BlinkPairsPurple:Delimiter,BlinkPairsBlue:Delimiter"
    end
  end,
})

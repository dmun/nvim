add("tpope/vim-sleuth")
add("stevearc/conform.nvim")
add("stevearc/quicker.nvim")

require("conform").setup({
  formatters_by_ft = {
    svelte = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
  },
})

require("quicker").setup({
  opts = {
    signcolumn = "no",
  },
})

nmap("<M-f>", function()
  require("conform").format({ lsp_format = "fallback" })
end)

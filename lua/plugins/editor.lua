add("tpope/vim-sleuth")
add("stevearc/conform.nvim")
add("stevearc/quicker.nvim")
add("jpalardy/vim-slime")
vim.g.slime_target = "tmux"
vim.g.slime_bracketed_paste = 1

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

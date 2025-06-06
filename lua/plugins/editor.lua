add("tpope/vim-sleuth")
add("stevearc/conform.nvim")
add("stevearc/quicker.nvim")
add("jpalardy/vim-slime")
vim.g.slime_target = "tmux"
vim.g.slime_bracketed_paste = 1

nmap("ms", "<Plug>SlimeParagraphSend")
nmap("mR", "<Plug>SlimeLineSend")
map("mr", "<Plug>SlimeLineSend")

vim.g.nvim_ghost_autostart = 0
add("subnut/nvim-ghost.nvim")
nmap("mg", cmd.GhostTextStart)

vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = false })
au("User", "*kaggle*", function()
  vim.bo.ft = "python"
end, "nvim_ghost_user_autocommands")

au("User", "ghosttext.fregante.com", function()
  vim.bo.ft = "javascript"
end, "nvim_ghost_user_autocommands")

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

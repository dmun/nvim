return require "lazier" {
  "stevearc/oil.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = { { "-", "<cmd>Oil<cr>" } },
  opts = {
    default_file_explorer = true,
    view_options = {
      is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") or vim.endswith(name, ".pdf") end,
    },
  },
}

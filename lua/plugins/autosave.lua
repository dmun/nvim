return {
  "dmun/autosave.nvim",
  event = "VeryLazy",
  init = function() vim.g.autosave_enabled = true end,
}

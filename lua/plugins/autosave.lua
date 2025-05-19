return {
  "dmun/autosave.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.autosave_enabled = true
    vim.g.autosave_disable_fts = { "sql" }
  end,
}

add({
  source = "milanglacier/minuet-ai.nvim",
  depends = { "nvim-lua/plenary.nvim" },
})

require("minuet").setup({
  provider = "codestral",
  n_completions = 2,
  provider_options = {
    codestral = {
      optional = {
        max_tokens = 384,
        stop = { "\n\n" },
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = { "*" },
    keymap = {
      accept = "<M-i>",
      accept_line = "<M-l>",
      prev = "<M-[>",
      next = "<M-]>",
      dismiss = "<M-e>",
    },
  },
})

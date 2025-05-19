return require "lazier" {
  "milanglacier/minuet-ai.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  lazy = false,
  config = function()
    require("minuet").setup({
      provider = "codestral",
      n_completions = 1,
      provider_options = {
        codestral = {
          optional = {
            max_tokens = 256,
            stop = { "\n\n" },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<A-i>",
          accept_line = "<A-I>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
    })
  end,
}

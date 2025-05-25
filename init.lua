require("util").bootstrap()
require("mini.deps").setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local map = vim.keymap.set

now(function()
  add({
    source = "dmun/boomer.nvim",
    depends = { "rktjmp/lush.nvim" },
  })
  vim.cmd.color("boomer")
  add("echasnovski/mini.nvim")

  require("defaults")
  require("autocommands")
  require("plugins.ui")

  add("tpope/vim-sleuth")
end)

later(function()
  require("plugins.treesitter")
  require("plugins.mini")
  require("plugins.motion")
  require("plugins.blink")
  require("plugins.lsp")
  require("plugins.llm")

  add("stevearc/conform.nvim")
  require("conform").setup()
  map("n", "<M-f>", function()
    require("conform").format({ lsp_format = "fallback" })
  end)

  add("stevearc/quicker.nvim")
  require("quicker").setup({
    opts = {
      signcolumn = "no",
    },
  })
end)

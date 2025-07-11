require("util").bootstrap()
require("mini.deps").setup()
require("globals")

now(function()
  add({ source = "dmun/boomer.nvim", depends = { "rktjmp/lush.nvim" } })
  cmd("color boomer")
  require("options")
  require("keymaps")
  require("autocommands")
  require("plugins.ui")
  require("util.statusline").setup()
end)

later(function()
  require("plugins.motion")
  require("plugins.treesitter")
  require("plugins.mini")
  require("plugins.files")
  require("plugins.blink")
  require("plugins.lsp")
  require("plugins.llm")
  require("plugins.editor")
  require("plugins.sql")
end)

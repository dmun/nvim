local bootstrap = require("util").bootstrap

vim.cmd.color("custom")

bootstrap("jake-stewart", "lazier")
bootstrap("folke", "lazy")

require("lazier").setup("plugins", {
  lazier = {
    before = function()
      vim.loader.enable()
      require("options")
      require("autocommands")
    end,
    after = function() require("keymaps") end,
    start_lazily = function()
      local nonLazyLoadableExtensions = {
        zip = true,
        tar = true,
        gz = true,
      }
      local fname = vim.fn.expand("%")
      return fname == ""
        or vim.fn.isdirectory(fname) == 0 and not nonLazyLoadableExtensions[vim.fn.fnamemodify(fname, ":e")]
    end,
    bundle_plugins = false,
  },
  install = { colorscheme = { "boomer" } },
  defaults = { lazy = true },
  change_detection = { enabled = false },
  ui = { pills = false, backdrop = 100, border = "single" },
  dev = { path = "~/dev", fallback = true },
})

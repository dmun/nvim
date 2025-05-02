return require "lazier" {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    local map = vim.keymap.set

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        tex = { "latexindent" },
        typst = { "typstyle" },
        odin = { "odinfmt" },
      },
      formatters = {
        ["clang-format"] = {
          command = "clang-format",
          args = { "--style", "{BasedOnStyle: LLVM, IndentWidth: 4, BreakTemplateDeclarations: true}" },
        },
      },
    })

    map("n", "<M-f>", function() conform.format({ lsp_format = "fallback" }) end)
  end,
}

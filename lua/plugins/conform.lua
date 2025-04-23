local map = vim.keymap.set

return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        typescript = { "prettier" },
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

    map("n", "<M-f>", conform.format)
  end,
}

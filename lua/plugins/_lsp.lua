vim.keymap.set("n", "<leader>d", function()
    require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>D", function()
    require("trouble").toggle("lsp_type_definitions")
end)
vim.keymap.set("n", "gr", function()
    require("trouble").toggle("lsp_references")
end)

vim.fn.sign_define("DiagnosticSignError", { text = "•", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "•", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "•", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "•", texthl = "DiagnosticSignHint" })

return {
    -- {
    --     "nvimtools/none-ls.nvim",
    --     event = { "BufReadPre", "BufNewFile" },
    --     config = function()
    --         local null_ls = require("null-ls")
    --
    --         local formatting = null_ls.builtins.formatting
    --         local diagnostics = null_ls.builtins.diagnostics
    --
    --         null_ls.setup({
    --             sources = {
    --                 formatting.black,
    --                 formatting.prettier,
    --                 formatting.stylua,
    --                 formatting.fnlfmt,
    --                 diagnostics.eslint,
    --                 diagnostics.luacheck,
    --                 diagnostics.flake8,
    --             },
    --         })
    --     end,
    -- },
}

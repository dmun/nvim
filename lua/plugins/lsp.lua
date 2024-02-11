vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
-- vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- vim.keymap.set("n", "L", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- vim.keymap.set("n", "<M-CR>", ":Telescope lsp_code_actions theme=cursor<CR>")
-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- vim.keymap.set("n", "<space>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
-- vim.keymap.set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
vim.keymap.set("n", "<leader>bf", "<cmd>lua require('conform').format({ async = true })<CR>")

vim.keymap.set("n", "<leader>d", function()
    require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>D", function()
    require("trouble").toggle("lsp_type_definitions")
end)
vim.keymap.set("n", "gr", function()
    require("trouble").toggle("lsp_references")
end)

vim.fn.sign_define("DiagnosticSignError", { text = "❖", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "◆", texthl = "DiagnosticSignWarn" })
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

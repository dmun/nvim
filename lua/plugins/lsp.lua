vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- vim.keymap.set("n", "L", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<M-CR>", ":Telescope lsp_code_actions theme=cursor<CR>")
-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- vim.keymap.set("n", "<space>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
vim.keymap.set("n", "<leader>bf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")

vim.keymap.set("n", "<leader>d", function()
    require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>D", function()
    require("trouble").toggle("lsp_type_definitions")
end)
vim.keymap.set("n", "gr", function()
    require("trouble").toggle("lsp_references")
end)

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- event = { "BufReadPre", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "lua",
            },
        },
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-context",
    --     event = { "BufReadPre", "BufNewFile" },
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
            },
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = false,
                signs = false,
                float = {
                    border = "single",
                    format = function(diagnostic)
                        return string.format(
                            "%s (%s) [%s]",
                            diagnostic.message,
                            diagnostic.source,
                            diagnostic.code or diagnostic.user_data.lsp.code
                        )
                    end,
                },
            })

            require("mason-lspconfig").setup({
                handlers = {
                    function(ls)
                        require("lspconfig")[ls].setup({
                            autostart = ls ~= "ltex",
                            settings = {
                                ltex = {
                                    language = "nl",
                                    filetype = { "norg" },
                                    additionalRules = {
                                        enablePickyRules = true,
                                    },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        lazy = true,
        opts = {
            padding = false,
            indent_lines = false,
            use_diagnostic_signs = true,
        },
    },
    "onsails/lspkind-nvim",
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "lukas-reineke/cmp-under-comparator",
            {
                "saadparwaiz1/cmp_luasnip",
                dependenceies = { "L3MON4D3/LuaSnip" },
            },
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_snipmate").lazy_load()

            local icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    -- ["<CR>"] = cmp.mapping.confirm({
                    -- 	--behavior = cmp.ConfirmBehavior.Replace,
                    -- 	select = true,
                    -- }),
                    ["<TAB>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                },
                completion = {
                    completeopt = "menu,menuone",
                },
                preselect = cmp.PreselectMode.None,
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(_, vim_item)
                        vim_item.menu = vim_item.kind
                        vim_item.kind = icons[vim_item.kind]
                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = true,
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics

            null_ls.setup({
                sources = {
                    formatting.black,
                    formatting.prettier,
                    formatting.stylua,
                    diagnostics.eslint,
                    diagnostics.luacheck,
                    diagnostics.flake8,
                },
            })
        end,
    },
}

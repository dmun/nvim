local cmp = require("cmp")
local luasnip = require("luasnip")

vim.cmd("set completeopt=menu,menuone,noselect")

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
		["<TAB>"] = cmp.mapping.confirm({
			--behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	preselect = cmp.PreselectMode.Item,
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For vsnip users.
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = require("lspkind").cmp_format(),
	},
})

-- Setup lspconfig.
--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--require('lspconfig')[%YOUR_LSP_SERVER%].setup {
--  capabilities = capabilities
--}

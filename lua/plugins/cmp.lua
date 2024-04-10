return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = "L3MON4D3/LuaSnip",
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				["<C-e>"] = vim.NIL,
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-c>"] = cmp.mapping.abort(),
				["<TAB>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-f>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = cmp.config.sources {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
			},
			sorting = {
				comparators = {
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.score,
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			completion = {
				completeopt = "menu,menuone",
			},
			formatting = {
				format = function(_, vim_item)
					vim_item.abbr = vim_item.abbr:sub(1, 30)
					return vim_item
				end,
			},
			experimental = {
				ghost_text = true,
			},
		}
	end,
}

local function generate_whitespace(n)
	if n > 0 then
		return " " .. generate_whitespace(n - 1)
	else
		return ""
	end
end

local function format_menu(_, item)
	item.abbr = " " .. item.abbr:gsub("%s+", "")
	if item.menu then
		local len = item.abbr:len() + item.menu:len()
		item.abbr = item.abbr .. generate_whitespace(38 - len) .. "  " .. item.menu
	end
	item.menu = ""
	return item
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"onsails/lspkind.nvim",
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = "L3MON4D3/LuaSnip",
		},
	},
	config = function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		cmp.setup {
			preselect = cmp.PreselectMode.None,
			view = {
				entries = { name = "custom", selection_order = "near_cursor" },
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				["<C-e>"] = vim.NIL,
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
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
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
			},
			sorting = {
				comparators = {
					cmp.config.compare.score,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.scope,
					cmp.config.compare.offset,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			completion = {
				completeopt = "menu,menuone",
			},
			window = { completion = { col_offset = -3 } },
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format {
					mode = "symbol",
					maxwidth = 40,
					ellipsis_char = "…",
					show_labelDetails = true,
					before = format_menu,
				},
			},
			experimental = {
				ghost_text = true,
			},
		}
	end,
}

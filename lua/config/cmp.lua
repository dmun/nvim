local cmp = require("cmp")
local luasnip = require("luasnip")

local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "⌘",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "廓",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
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
        format = function (_, vim_item)
            vim_item.menu = ""
            vim_item.kind = icons[vim_item.kind]
            return vim_item
        end
	},
    experimental = {
        ghost_text = true,
    },
})

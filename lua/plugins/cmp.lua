local cmp = require("cmp")

cmp.register_source("buffer", require("cmp_buffer"))
cmp.register_source("path", require("cmp_path"))
require("cmp_nvim_lsp").setup()

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

cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-e>"] = vim.NIL,
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(),
		["<TAB>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
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

local kind_hl_map = {
	Text = "Comment",
	Method = "@function.method",
	Function = "@function",
	Constructor = "@constructor",
	Field = "@field",
	Variable = "@variable",
	Class = "@lsp.type.class",
	Interface = "@lsp.type.interface",
	Module = "@module",
	Property = "@property",
	Unit = "CmpItemKindUnit",
	Value = "CmpItemKindValue",
	Enum = "@lsp.type.enum",
	Keyword = "@keyword",
	Delimiter = "@tag.delimiter",
	Color = "CmpItemKindColor",
	File = "@module",
	Reference = "CmpItemKindReference",
	Folder = "CmpItemKindFolder",
	EnumMember = "@lsp.type.enumMember",
	Constant = "@constant",
	Struct = "@lsp.type.struct",
	Event = "CmpItemKindEvent",
	Operator = "@operator",
	TypeParameter = "@lsp.type.parameter",
	Snippet = "CmpItemKindSnippet",
}

--- @module 'blink.cmp'
--- @type blink.cmp.Draw
local draw = {
	padding = 1,
	gap = 0,
	-- treesitter = { "lsp" },
	columns = {
		{
			"label",
			-- "label_description",
			-- gap = 1,
		},
	},
	components = {
		label = {
			ellipsis = true,
			width = { fill = true, max = 40 },
			text = function(ctx)
				if vim.tbl_contains({ "Method", "Function" }, ctx.kind) then
					if not vim.endswith(ctx.label, ")") and ctx.label_detail == "" then
						ctx.label_detail = "()"
					end

					if vim.o.filetype == "rust" then
						if ctx.label_detail then
							local s = vim.split(ctx.label_description, " -> ")
							if s then
								ctx.label = ctx.label:gsub("%(.*", "")
								ctx.label_description = ctx.label_detail
								ctx.label_detail = s[1]:match("%(.*%)") or "()"
							end
						end
					end
				end

				return ctx.label .. ctx.label_detail
			end,
			highlight = function(ctx)
				local ts = require("blink.cmp.completion.windows.render.treesitter")
				local ts_filetypes = { "lua" }

				if
					vim.tbl_contains({ "Method", "Function" }, ctx.kind)
					and vim.tbl_contains(ts_filetypes, vim.o.filetype)
				then
					return ts.highlight(ctx)
				end

				local highlights = {
					{
						0,
						#ctx.label,
						group = ctx.deprecated and "BlinkCmpLabelDeprecated"
							or (kind_hl_map[ctx.kind] or "BlinkCmpKind"),
					},
				}

				if ctx.label_detail then
					table.insert(highlights, {
						#ctx.label,
						#ctx.label + #ctx.label_detail,
						group = "BlinkCmpLabelDetail",
					})
				end

				return highlights
			end,
		},
	},
}

return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	-- build = 'cargo build --release',
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_and_accept", "fallback" },
			["<C-f>"] = { "snippet_forward", "fallback" },
			["<C-b>"] = { "snippet_backward", "fallback" },
			["<C-e>"] = {},
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			menu = { draw = draw },
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}

local query = nil

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	callback = function()
		local success, result = pcall(vim.treesitter.query.get, vim.bo.filetype, "highlights")
		if success and result then
			query = result
		else
			_, result = pcall(vim.treesitter.query.get, "lua", "highlights")
			query = result
		end
	end,
})

local fields = {
	"Comment", -- 	    1 text
	nil, --     2 method
	nil, --     3 function
	"@constructor", --     4
	"@field", --     5
	"@variable", --     6 variable
	"@lsp.type.class", --     7
	"@lsp.type.interface", --     8
	"@module", --     9
	"@property", --     10
	"CmpItemKindUnit", --     11
	"CmpItemKindValue", --     12
	"@lsp.type.enum", --     13
	"@keyword", --     14 keyword
	"@tag.delimiter", --     15 snippet
	"CmpItemKindColor", --     16
	"CmpItemKindFile", --     17
	"CmpItemKindReference", --     18
	"CmpItemKindFolder", --     19
	"@lsp.type.enumMember", --     20
	"@constant", --     21 concstant
	"@lsp.type.struct", --     22
	"CmpItemKindEvent", --     23
	"@operator", --     24
	"@lsp.type.parameter", --     25
}

---@param entry cmp.Entry
local function set_abbr_menu(entry, vim_item)
	local cmp_item = entry:get_completion_item()
	local label_details = cmp_item.labelDetails or nil
	local entry_kind = entry:get_kind()
	local ft = vim.bo.filetype

	local abbr = vim_item.abbr
	local menu = vim_item.menu

	abbr = abbr:gsub("^%s", "")
	abbr = abbr:gsub("•", "")

	local tbl = {
		lua = {
			functions = function()
				local docs = cmp_item.documentation
				if docs then
					local type = docs.value:match("-> ([^%s]+)") or ""
					menu = type
				end
			end,
		},
		zig = {
			functions = function()
				abbr = abbr:gsub("~", "")
				if label_details then
					if label_details.description then
						menu = label_details.description
					end
					if label_details.detail then
						abbr = abbr .. label_details.detail
					end
				end
			end,
		},
		rust = {
			functions = function()
				if cmp_item.detail then
					local s = vim.split(cmp_item.detail, " -> ")
					if s then
						abbr = "" .. abbr:gsub("%(.*", "") .. (s[1]:match("%(.*%)") or "()")
						menu = s[2] or ""
					end
				end
			end,
		},
		go = {
			functions = function()
				if cmp_item.detail then
					abbr = abbr:gsub("~", "")
					local args = cmp_item.detail:match("func(%(.*%)) ") or ""
					abbr = abbr .. args
					menu = cmp_item.detail:match("func%(.*%) (.*)") or ""
				end
			end,
		},
		odin = {
			functions = function()
				if label_details then
					local p = label_details.detail
					if p then
						p = p:find("%(") and label_details.detail or "()"
					end
					abbr = abbr .. p
					menu = label_details.description or ""
				end
			end,
		},
		typst = {
			functions = function()
				abbr = abbr .. "()"
			end,
		},
		quarto = {
			functions = function()
				abbr = abbr .. "()"
			end,
		},
		python = {
			functions = function()
				abbr = abbr .. "()"
			end,
		},
		cpp = {
			functions = function()
				if label_details then
					abbr = abbr .. label_details.detail
					menu = label_details.description
				end
			end,
		},
		c = {
			functions = function()
				if label_details then
					abbr = abbr .. label_details.detail
					menu = label_details.description
				end
			end,
		},
	}

	if vim.tbl_contains({ 2, 3 }, entry_kind) then
		if tbl[ft] and tbl[ft].functions then
			tbl[ft].functions()
		end
	elseif vim.tbl_contains({ 4, 8, 9, 22 }, entry_kind) then
		menu = label_details and label_details.detail or ""
		menu = menu:gsub("use ", "")
	end

	vim_item.menu = menu
	vim_item.abbr = abbr

	return vim_item
end

---@param str string
local function get_highlights(str, width, kind)
	local highlights = {}
	local ft = vim.bo.filetype
	local is_function = vim.tbl_contains({ 2, 3 }, kind)

	local prefixes = {
		-- zig = 'fn ',
		rust = "",
		go = "func ",
		lua = "",
	}
	local prefix = prefixes[ft]

	if prefix == nil then
		local s = vim.split(str, "%(")
		table.insert(highlights, { "@function", range = { 0, #s[1] } })
		table.insert(highlights, { "Comment", range = { #s[1], #str } })
		return highlights
	end

	if is_function and prefix then
		str = prefix .. str
	end

	if not query then
		return nil
	end

	local success, parser = pcall(vim.treesitter.get_string_parser, str, ft)
	if success then
		local tree = parser:parse(true)[1]
		local root = tree:root()
		for id, node in query:iter_captures(root, str, 0, -1) do
			local name = "@" .. query.captures[id] .. "." .. ft
			local hl = vim.api.nvim_get_hl_id_by_name(name)
			local range = { node:range() }
			local _, nscol, _, necol = range[1], range[2], range[3], range[4]

			if is_function and prefix then
				nscol = nscol - #prefix
				necol = necol - #prefix
			end

			if nscol < 0 then
				goto continue
			end

			table.insert(highlights, { hl, range = { nscol, necol < width and necol or width } })
			::continue::
		end
	end

	return highlights
end

---@param entry cmp.Entry
---@param vim_item lsp.CompletionItem|table
---@return lsp.CompletionItem
local function format_menu(entry, vim_item)
	local cmp_item = entry:get_completion_item()
	local kind = entry:get_kind()

	vim_item = set_abbr_menu(entry, vim_item)

	if not vim_item.menu then
		if cmp_item.detail then
			vim_item.menu = cmp_item.detail
		elseif cmp_item.labelDetails then
			vim_item.menu = cmp_item.labelDetails.description or cmp_item.labelDetails.detail
		end
	end

	local abbr = vim_item.abbr
	local menu = vim_item.menu or ""

	local max_width = 50
	local whitespace = max_width - #abbr - #menu
	local ellipses = "…"

	-- if whitespace < 0 then
	-- 	if #abbr <= max_width / 2 then
	-- 		menu = menu:sub(0, max_width - #abbr - 1) .. ellipses
	-- 	elseif #menu <= max_width / 2 then
	-- 		abbr = abbr:sub(0, max_width - #menu - 1) .. ellipses
	-- 	else
	-- 		abbr = abbr:sub(0, max_width / 2 - 1) .. ellipses
	-- 		menu = menu:sub(0, max_width / 2 - 1) .. ellipses
	-- 	end
	-- 	whitespace = 0
	-- end

	vim_item.abbr_hl_group = fields[kind] and { { fields[kind], range = { 0, #abbr } } }
		or get_highlights(vim_item.abbr, #abbr, kind)
	-- vim_item.abbr = abbr .. string.rep(' ', whitespace + 1) .. (menu or '')
	if #abbr > 40 then
		vim_item.abbr = abbr:sub(0, 40) .. ellipses
	end

	-- if type(vim_item.abbr_hl_group) == 'table' then
	-- 	table.insert(
	-- 		vim_item.abbr_hl_group,
	-- 		{ 'CmpItemMenu', range = { #abbr + whitespace + 1, #abbr + whitespace + #menu + 1 } }
	-- 	)
	-- end
	vim_item.menu = ""

	return vim_item
end

return {
	{
		"L3MON4D3/LuaSnip",
		cmd = "LuaSnipUnlinkCurrent",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},
	{
		"dmun/nvim-cmp",
		-- enabled = false,
		branch = "fix-field-column-width",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"onsails/lspkind.nvim",
			"ryo33/nvim-cmp-rust",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = "L3MON4D3/LuaSnip",
			},
		},
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_rust = require("cmp-rust")
			local luasnip = require("luasnip")

			vim.cmd("hi! CmpItemAbbrMatch guifg=none gui=bold")
			vim.cmd("hi! CmpItemAbbrMatchDefault guifg=none gui=bold")
			vim.cmd("hi! CmpItemAbbrMatchFuzzy guifg=none gui=bold")
			vim.cmd("hi! CmpItemAbbrMatchFuzzyDefault guifg=none gui=bold")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				preselect = cmp.PreselectMode.None,
				view = {
					entries = {
						name = "custom",
						selection_order = "near_cursor",
					},
					docs = {
						auto_open = false,
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-e>"] = vim.NIL,
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping.open_docs(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-c>"] = cmp.mapping.abort(),
					["<TAB>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
				}),
				sources = cmp.config.sources({
					{ name = "jupynium", priority = 1000 },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "lazydev" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
				}),
				---@diagnostic disable-next-line: missing-fields
				sorting = {
					comparators = {
						-- cmp_rust.deprioritize_postfix,
						-- cmp_rust.deprioritize_borrow,
						-- cmp_rust.deprioritize_deref,
						-- cmp_rust.deprioritize_common_traits,
						cmp.config.compare.score,
						cmp.config.compare.kind,
						cmp.config.compare.locality,
						cmp.config.compare.length,
						cmp.config.compare.offset,
						cmp.config.compare.order,
					},
				},
				completion = {
					completeopt = "menu,menuone",
				},
				performance = {
					-- max_view_entries = 50,
				},
				formatting = {
					fields = { "abbr" },
					format = format_menu,
					expandable_indicator = false,
				},
				window = {
					completion = {
						scrolloff = 2,
					},
					documentation = {
						max_height = 15,
						max_width = 40,
					},
				},
				experimental = {
					ghost_text = false,
				},
			})
		end,
	},
}

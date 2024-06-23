local function generate_whitespace(n)
	if n > 0 then
		return " " .. generate_whitespace(n - 1)
	else
		return ""
	end
end

---@param entry cmp.Entry
---@param vim_item lsp.CompletionItem|table
---@return lsp.CompletionItem
local function format_menu(entry, vim_item)
	-- item.abbr = item.abbr:gsub("%s+", "")
	local cmp_item = entry:get_completion_item()
	local label_details = cmp_item.labelDetails or nil
	local entry_kind = entry:get_kind()
	-- local kind = require("lspkind")
	local ft = vim.bo.filetype
	local args = ''

	if vim.tbl_contains({ 2, 3 }, entry_kind) then
		if ft == "lua" then
			local s = vim.split(vim_item.abbr, "%(")
			if s then
				vim_item.abbr = s[1]
				args = "(" .. (s[2] or ")")
			end
			local docs = cmp_item.documentation
			if docs then
				local type = docs.value:match("-> (.*)\n") or ""
				vim_item.menu = type
			end
		elseif ft == "rust" then
			if cmp_item.detail then
				local s = vim.split(cmp_item.detail, " -> ")
				if s then
					vim_item.abbr = vim_item.abbr:gsub("%(.*", "")
					args = (s[1]:match("%(.*%)") or ""):gsub("&?m?u?t? ?self,? ?", "") or "()"
					vim_item.menu = s[2] or ""
				end
			end
		elseif ft == "go" then
			if cmp_item.detail then
				vim_item.abbr = vim_item.abbr:gsub("~", "")
				args = cmp_item.detail:match("func(%(.*%)) ") or ""
				vim_item.menu = cmp_item.detail:match("func%(.*%) (.*)") or ""
			end
		end
	elseif vim.tbl_contains({ 4, 8, 9, 22 }, entry_kind) then
		vim_item.menu = label_details and label_details.detail or ""
		vim_item.menu = vim_item.menu:gsub("use ", "")
	end

	if not vim_item.menu then
		if cmp_item.detail then
			vim_item.menu = cmp_item.detail
		elseif cmp_item.labelDetails then
			vim_item.menu = cmp_item.labelDetails.description or cmp_item.labelDetails.detail
		end
	end

	if vim_item.abbr then
		vim_item.abbr = vim_item.abbr .. args
	end

	return vim_item
end

Plug("L3MON4D3/LuaSnip")
	:cmd("LuaSnipUnlinkCurrent")
	:version("v2.*")
	:dependencies { "rafamadriz/friendly-snippets" }
	:build("make install_jsregexp")
	:config(function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end)

Plug("dmun/nvim-cmp")
	:on(Event.InsertEnter)
	:dependencies {
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
	}
	:config(function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp_rust = require("cmp-rust")
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

			---@diagnostic disable-next-line: missing-fields
			sorting = {
				comparators = {
					cmp_rust.deprioritize_postfix,
					cmp_rust.deprioritize_borrow,
					cmp_rust.deprioritize_deref,
					cmp_rust.deprioritize_common_traits,
					cmp.config.compare.score,
					cmp.config.compare.locality,
					cmp.config.compare.length,
					cmp.config.compare.kind,
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			completion = {
				completeopt = "menu,menuone",
			},
			window = { completion = { col_offset = -2 } },

			---@diagnostic disable-next-line: missing-fields
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format {
					mode = "symbol",
					maxwidth = 30,
					ellipsis_char = "…",
					show_labelDetails = true,
					before = format_menu,
				},
			},
			experimental = {
				ghost_text = true,
			},
		}
	end)

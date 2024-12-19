 -- stylua: ignore
local kind_hl_map = {
	Method        = "@function.method",
	Variable      = "@variable",
	Class         = "@lsp.type.class",
	Interface     = "@lsp.type.interface",
	Field         = "@variable.member",
	Function      = "@function.call",
	Constructor   = "@constructor",
	Module        = "@module",
	Property      = "@property",
	Enum          = "@lsp.type.enum",
	Keyword       = "@keyword",
	Delimiter     = "@tag.delimiter",
	File          = "@module",
	Constant      = "@constant",
	EnumMember    = "@lsp.type.enumMember",
	Struct        = "@lsp.type.struct",
	Operator      = "@operator",
	TypeParameter = "@lsp.type.parameter",

	Text          = "Comment",
	Unit          = "CmpItemKindUnit",
	Value         = "CmpItemKindValue",
	Color         = "CmpItemKindColor",
	Reference     = "CmpItemKindReference",
	Folder        = "CmpItemKindFolder",
	Event         = "CmpItemKindEvent",
	Snippet       = "CmpItemKindSnippet",
}

--- @module 'blink.cmp'
--- @type blink.cmp.Draw
local draw = {
  padding = 1,
  gap = 0,
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
      width = { fill = true, max = 50 },
      text = function(ctx)
        local ft = vim.o.filetype

        if vim.tbl_contains({ "Method", "Function" }, ctx.kind) then
          local ft_ctx = require("plugins.completion.ft_ctx")
          if ft_ctx[ft] and ft_ctx[ft].fix_label then
            ft_ctx[ft].fix_label(ctx)
          end

          if not vim.endswith(ctx.label, ")") and not vim.endswith(ctx.label_detail, ")") then
            ctx.label_detail = "()"
          end
        end

        return ctx.label .. ctx.label_detail
      end,
      highlight = function(ctx)
        local ts = require("blink.cmp.completion.windows.render.treesitter")
        local ts_filetypes = { "rust" }

        local highlights = {}

        if vim.tbl_contains({ "Method", "Function" }, ctx.kind) and vim.tbl_contains(ts_filetypes, vim.o.filetype) then
          highlights = ts.highlight(ctx)
        else
          table.insert(highlights, {
            0,
            #ctx.label,
            group = ctx.deprecated and "BlinkCmpLabelDeprecated" or (kind_hl_map[ctx.kind] or "BlinkCmpKind"),
          })
        end

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
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  version = "v0.*",
  -- build = "cargo build --release",
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<C-f>"] = { "snippet_forward", "fallback" },
      ["<C-b>"] = { "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-e>"] = {},
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "lazydev",
      },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        -- lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        max_height = 8,
        draw = draw,
        scrollbar = false,
      },
      ghost_text = { enabled = true },
    },
    signature = {
      enabled = true,
      trigger = {
        show_on_insert_on_trigger_character = true,
      },
      -- window = {
      -- 	show_documentation = false,
      -- },
    },
  },
  opts_extend = { "sources.default" },
}

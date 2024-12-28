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
      -- "kind",
      -- gap = 1,
    },
  },
  components = {
    label = {
      ellipsis = true,
      width = { fill = true, max = 50 },
      text = function(ctx)
        local ft = vim.o.filetype
        local ft_filter = { "tex" }

        if vim.tbl_contains({ "Method", "Function" }, ctx.kind) then
          local ft_ctx = require("plugins.completion.ft_ctx")
          if ft_ctx[ft] and ft_ctx[ft].fix_label then
            ft_ctx[ft].fix_label(ctx)
          end

          if
            not vim.endswith(ctx.label, ")")
            and not vim.endswith(ctx.label_detail, ")")
            and not vim.tbl_contains(ft_filter, ft)
          then
            ctx.label_detail = "()"
          end
        end

        return ctx.label .. ctx.label_detail
      end,
      highlight = function(ctx)
        local ts_filetypes = {}
        local highlights = {}

        if vim.tbl_contains({ "Method", "Function" }, ctx.kind) and vim.tbl_contains(ts_filetypes, vim.o.filetype) then
          local ts = require("blink.cmp.completion.windows.render.treesitter")
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
      ["<C-e>"] = {},

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-y>"] = { "accept" },

      ["<C-p>"] = { "select_prev" },
      ["<C-n>"] = { "select_next" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        -- "buffer",
      },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
          override_brackets_for_filetypes = {
            tex = { "{", "}" },
          },
          kind_resolution = {
            enabled = true,
            blocked_filetypes = {
              "typescriptreact",
              "javascriptreact",
              "vue",
              "tex",
            },
          },
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {
              "java",
              -- "tex",
            },
          },
        },
      },
      menu = {
        max_height = 8,
        draw = draw,
        scrollbar = false,
      },
      ghost_text = { enabled = false },
    },
    signature = {
      enabled = true,
      trigger = {
        show_on_insert_on_trigger_character = true,
      },
    },
  },
  opts_extend = { "sources.default" },
}

local kind_hl_map = {
  Method = "@function.method",
  Variable = "@variable",
  Class = "@lsp.type.class",
  Interface = "@lsp.type.interface",
  Field = "@variable.member",
  Function = "@function.call",
  Constructor = "@constructor",
  Module = "@module",
  Property = "@property",
  Enum = "@lsp.type.enum",
  Keyword = "@keyword",
  Delimiter = "@tag.delimiter",
  File = "@module",
  Constant = "@constant",
  EnumMember = "@lsp.type.enumMember",
  Struct = "@lsp.type.struct",
  Operator = "@operator",
  TypeParameter = "@lsp.type.parameter",

  Text = "Comment",
  Unit = "CmpItemKindUnit",
  Value = "CmpItemKindValue",
  Color = "CmpItemKindColor",
  Reference = "CmpItemKindReference",
  Folder = "CmpItemKindFolder",
  Event = "CmpItemKindEvent",
  Snippet = "@character",
}

---@module 'blink.cmp'
---@type blink.cmp.DrawComponent
local label = {
  ellipsis = true,
  width = { fill = true, max = 50 },
  text = function(ctx)
    local ft = vim.o.filetype
    local ft_filter = { "tex", "codecompanion" }

    if vim.tbl_contains({ "Method", "Function" }, ctx.kind) then
      local ft_ctx = require("plugins.completion.ft_ctx")
      if ft_ctx[ft] and ft_ctx[ft].fix_label then ft_ctx[ft].fix_label(ctx) end

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
        group = "DiagnosticUnnecessary",
      })
    end

    return highlights
  end,
}

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
    version = "v0.*",
    -- build = "cargo build --release",
    opts = {
      keymap = {
        preset = "default",
        ["<C-e>"] = {},

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-y>"] = { "accept" },
        ["<Tab>"] = { "accept", "fallback" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "show", "select_next", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "dadbod",
        },
        providers = {
          snippets = { min_keyword_length = 3 },
          buffer = { min_keyword_length = 3 },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            score_offset = 200,
          },
        },
      },
      completion = {
        list = { selection = { preselect = true } },
        menu = {
          draw = {
            padding = 1,
            gap = 0,
            columns = { { "label" } },
            components = { label = label },
          },
          max_height = vim.o.pumheight,
        },
        ghost_text = { enabled = false },
      },
      fuzzy = { implementation = "prefer_rust" },
      signature = {
        enabled = true,
        trigger = {
          show_on_insert_on_trigger_character = true,
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}

add({
  source = "saghen/blink.cmp",
  depends = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
  },
  checkout = "v1.3.1",
})

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-y>"] = { "accept" },

    ["<C-e>"] = { "hide", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },

    ["<C-f>"] = { "snippet_forward", "fallback" },
    ["<C-b>"] = { "snippet_backward", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = false },
    list = { max_items = 50 },
    menu = {
      auto_show = true,
      border = "none",
      max_height = vim.o.ph,
      scrollbar = false,
      draw = {
        treesitter = { "lsp" },
        columns = { { "label" } },
        components = {
          label = {
            text = function(ctx)
              local paren = ctx.label:find("%(")
              if vim.tbl_contains({ "Method", "Function" }, ctx.kind) then
                if not paren and not vim.endswith(ctx.label_detail, ")") then
                  ctx.label_detail = "()"
                elseif paren then
                  ctx.label_detail = ctx.label:sub(paren, #ctx.label)
                  ctx.label = ctx.label:sub(1, paren - 1)
                end
              end
              return ctx.label .. ctx.label_detail
            end,
            highlight = function(ctx)
              local ts_filetypes = {}
              local highlights = {}
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

              if
                  vim.tbl_contains({ "Method", "Function" }, ctx.kind)
                  and vim.tbl_contains(ts_filetypes, vim.o.filetype)
              then
                local ts =
                    require("blink.cmp.completion.windows.render.treesitter")
                highlights = ts.highlight(ctx)
              else
                table.insert(highlights, {
                  0,
                  #ctx.label,
                  group = ctx.deprecated and "BlinkCmpLabelDeprecated"
                      or (kind_hl_map[ctx.kind] or "BlinkCmpKind"),
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
          },
        },
      },
    },
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      sql = { "snippets", "dadbod", "buffer" },
    },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

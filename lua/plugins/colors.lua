local black = "#080808"
local white = "#c6c6c6"

local grey0 = "#323437"
local grey1 = "#373c4d"
local grey89 = "#e4e4e4"
local grey70 = "#b2b2b2"
local grey62 = "#9e9e9e"
local grey58 = "#949494"
local grey50 = "#808080"
local grey39 = "#626262"
local grey30 = "#4e4e4e"
local grey27 = "#444444"
local grey23 = "#3a3a3a"
local grey18 = "#2e2e2e"
local grey15 = "#262626"
local grey11 = "#1c1c1c"
local grey7 = "#121212"

local khaki = "#c6c684"
local yellow = "#e3c78a"
local orange = "#de935f"
local coral = "#f09479"
local orchid = "#e196a2"
local lime = "#85dc85"
local green = "#8cc85f"
local emerald = "#36c692"
local turquoise = "#79dac8"
local blue = "#80a0ff"
local sky = "#74b2ff"
local lavender = "#adadf3"
local purple = "#ae81ff"
local violet = "#cf87e8"
local cranberry = "#e65e72"
local crimson = "#ff5189"
local red = "#ff5454"

local mineral = "#314940"
local bay = "#4d5d8d"

return {
  "bluz71/vim-moonfly-colors",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        no_italic = true,
        integrations = {
          cmp = false,
        },
        highlight_overrides = {
          all = function(colors)
            return {
              iCursor = { bg = colors.green },
              BlinkCmpLabelDetail = { fg = colors.overlay2 },
              Pmenu = { bg = colors.mantle },
              PmenuSel = { style = {} },
              BlinkCmpMenuSelection = { bold = false },
              TreesitterContext = { bg = colors.mantle },
              TreesitterContextLineNumber = { bg = colors.mantle },
              TreesitterContextBottom = { bg = colors.mantle, style = {} },
              TreesitterContextLineNumberBottom = { bg = colors.mantle, style = {} },
              CursorLineNr = { fg = colors.text },
              NoiceCmdline = { bg = colors.mantle },
              NoiceCmdlineIcon = { fg = colors.mantle, bg = colors.peach, style = { "bold" } },
              NoiceCmdlineIconSearch = { fg = colors.mantle, bg = colors.yellow, style = { "bold" } },
              NormalFloat = { bg = grey7 },
              NormalTerm = { bg = grey7 },
              CopilotChatHeader = { fg = colors.maroon, style = { "bold" } },
              FloatTitle = { style = { "bold" } },
              FzfLuaTitle = { style = { "bold" } },

              Comment = { fg = colors.overlay2, italic = true },
              Function = { fg = colors.sky },
              String = { fg = colors.rosewater },
              Boolean = { fg = colors.maroon },
              Identifier = { fg = colors.teal },
              Title = { fg = colors.peach },
              StorageClass = { fg = colors.mauve },
              Type = { fg = colors.sapphire },
              Constant = { fg = colors.peach },
              Character = { fg = colors.mauve },
              Exception = { fg = colors.maroon },
              PreProc = { fg = colors.maroon },
              Label = { fg = colors.teal },
              NonText = { fg = colors.overlay0 },
              Operator = { fg = colors.maroon },
              Repeat = { fg = colors.mauve },
              Search = { bg = colors.surface1, fg = colors.text },
              CurSearch = { bg = colors.pink, fg = colors.base },
              IncSearch = { bg = colors.yellow, fg = colors.base },
              Special = { fg = colors.maroon },
              Statement = { fg = colors.lavender },
              Structure = { fg = colors.sapphire },

              ["@attribute"] = { fg = colors.sky },
              ["@constant"] = { fg = colors.teal },
              ["@constant.builtin"] = { fg = colors.green },
              ["@constant.macro"] = { fg = colors.mauve },
              ["@constructor"] = { fg = colors.sapphire },
              ["@function.macro"] = { fg = colors.sapphire },
              ["@function.builtin"] = { fg = colors.sky },
              ["@keyword.import"] = { fg = colors.red },
              ["@keyword.exception"] = { fg = colors.mauve },
              ["@keyword.operator"] = { fg = colors.mauve },
              ["@markup.environment"] = { fg = colors.mauve },
              ["@markup.environment.name"] = { fg = colors.teal },
              ["@markup.heading"] = { fg = colors.mauve },
              ["@markup.italic"] = { fg = colors.mauve, italic = true },
              ["@markup.link"] = { fg = colors.green },
              ["@markup.link.label"] = { fg = colors.green },
              ["@markup.link.url"] = { fg = colors.lavender, underline = true, sp = colors.overlay1 },
              ["@markup.list"] = { fg = colors.red },
              ["@markup.list.checked"] = { fg = colors.teal },
              ["@markup.list.unchecked"] = { fg = colors.blue },
              ["@markup.math"] = { fg = colors.sky },
              ["@markup.quote"] = { fg = colors.overlay2 },
              ["@markup.strong"] = { fg = colors.mauve },
              ["@module"] = { fg = colors.teal },
              ["@module.builtin"] = { fg = colors.green },
              ["@parameter.builtin"] = { fg = colors.mauve },
              ["@property"] = { fg = colors.lavender },
              ["@punctuation.delimiter"] = { fg = colors.text },
              ["@punctuation.bracket"] = { fg = colors.text },
              ["@string.documentation"] = { fg = colors.teal },
              ["@string.regexp"] = { fg = colors.teal },
              ["@string.special.path"] = { fg = colors.mauve },
              ["@string.special.symbol"] = { fg = colors.lavender },
              ["@string.special.url"] = { fg = colors.lavender },
              ["@tag"] = { fg = colors.blue },
              ["@tag.attribute"] = { fg = colors.teal },
              ["@tag.builtin"] = { fg = colors.blue },
              ["@tag.delimiter"] = { fg = colors.green },
              ["@type.builtin"] = { fg = colors.teal },
              ["@type.qualifier"] = { fg = colors.mauve },
              ["@variable"] = { fg = colors.text },
              ["@variable.builtin"] = { fg = colors.green },
              ["@variable.member"] = { fg = colors.lavender },
              ["@variable.parameter"] = { fg = colors.mauve },
            }
          end,
        },
        color_overrides = {
          all = {
            rosewater = khaki,
            flamingo = yellow,
            pink = coral,
            mauve = violet,
            red = cranberry,
            maroon = crimson,
            peach = orange,
            yellow = yellow,
            green = green,
            teal = turquoise,
            sky = sky,
            sapphire = emerald,
            blue = blue,
            lavender = lavender,
            text = white,
            subtext1 = grey70,
            subtext0 = grey62,
            overlay2 = grey58,
            overlay1 = grey50,
            overlay0 = grey39,
            surface2 = grey30,
            surface1 = grey27,
            surface0 = grey23,
            base = black,
            mantle = grey15,
            crust = grey11,
          },
        },
      })
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        variant = "tinted",
        styles = {
          -- variables = { link = "lispSymbol" },
        },
        ---@param colors ColorScheme
        on_colors = function(colors)
          colors.bg_tab_bar = "#141528"
        end,
        ---@param hl Highlights
        ---@param c ColorScheme
        on_highlights = function(hl, c)
          hl["@variable"] = { link = "lispSymbol" }
          hl["@constant"] = { fg = c.magenta_cooler }
          hl["@lsp.typemod.variable.global"] = { link = "@variable.member" }
          hl.PmenuSel = { bg = c.bg_inactive }
          hl.Pmenu = { bg = c.bg_dim }
          hl.PmenuThumb = { bg = c.border }

          hl.LspSignatureActiveParameter = { bg = c.bg_active, bold = true }
          hl.BlinkCmpSignatureHelp = { bg = c.bg_dim }
          hl.BlinkCmpSignatureHelpBorder = { bg = c.bg_dim }

          hl.BlinkCmpDoc = { bg = c.bg_active }
          hl.BlinkCmpDocSeparator = { fg = c.fg_dim }
          -- hl.BlinkCmpDocBorder = { bg = c.bg_active }

          -- hl.PmenuSbar = { bg = c.bg_inactive }
          hl.CursorLine = { bg = c.bg_tab_bar }
          hl.CursorLineSign = { bg = c.bg_tab_bar }
          -- hl.CursorLineNr = { bg = c.bg_tab_bar }
          hl.CursorLineNr = { fg = c.fg_alt }
          hl.LineNr = { fg = c.bg_inactive }

          hl.NoiceCmdline = { bg = c.bg_inactive }

          hl.GitSignsAdd = { fg = c.bg_added }
          hl.GitSignsChange = { fg = c.bg_changed }
          hl.GitSignsDelete = { fg = c.bg_removed }

          hl.Visual = { bg = c.bg_inactive }
          hl.Search = { bg = c.bg_inactive }
          hl.NormalTerm = { bg = "#101121" }
          hl.DapUINormal = { bg = "#0F1121" }
          hl.DapUINormalNC = { link = "DapUINormal" }
          hl.TroubleNormal = { bg = c.bg_tab_bar }
          hl.TroubleNormalNC = { bg = c.bg_tab_bar }
          hl.TreesitterContext = { bg = c.bg_tab_bar }
          hl.TreesitterContextLineNumber = { fg = c.bg_active, bg = c.bg_tab_bar }

          hl.nCursor = { bg = c.yellow_warmer }
          hl.iCursor = { bg = c.green_warmer }
          hl.NormalFloat = {}

          hl.LineNrAbove = { link = "LineNr" }
          hl.LineNrBelow = { link = "LineNr" }
          hl.WinSeparator = { fg = "#101121", bg = "#101121" }
          hl.StatusLine = { link = "WinSeparator" }
          hl.StatusLineNC = { link = "WinSeparator" }

          hl.LeapBackdrop = {}
          hl.LeapLabel = { fg = c.magenta_intense }
          hl.CleverFChar = { fg = c.magenta_intense }

          hl.FzfLuaBorder = { fg = c.border_highlight }
          -- hl.FzfLuaBorder = { link = "NoiceCmdlinePopupBorderSearch" }
          hl.FzfLuaTitle = { fg = c.border_highlight, bold = true }
          hl.FzfLuaBackdrop = { link = "Normal" }
        end,
      })
    end,
  },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    -- cmd = "ColorizerAttachToBuffer",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = {
        "*",
        "!noice",
      },
      user_default_options = {
        names = false,
      },
    },
  },
}

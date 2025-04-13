return {
  "aktersnurra/no-clown-fiesta.nvim",
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>c",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      highlight = {
        style = "virtual_left",
        virtual_text = "  ",
        emphasis = false,
      },
    },
  },
  {
    "oxfist/night-owl.nvim",
    priority = 1000,
    config = function()
      require("night-owl").setup({
        italics = false,
        transparent_background = false,
      })
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      dim_inactive = { enabled = false },
      no_italic = true,
      custom_highlights = function(colors)
        return {
          Normal = { bg = "black" },
          NormalNC = { bg = "black" },
          -- MsgArea = { bg = colors.base },
          CursorN = { bg = colors.peach },
          CursorI = { bg = colors.green },
        }
      end,
    },
  },
  {
    "dmun/jellybeans.nvim",
    dev = true,
    branch = "dmun",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("jellybeans").setup({
        flat_ui = false,
        italics = false,
        on_highlights = function(hl, c)
          hl.NonText = { fg = c.grey_three }

          hl.FloatTitle = { fg = c.tundora, bold = true }
          hl.FloatBorder = { fg = c.tundora }
          hl.FzfLuaTitle = { fg = c.green_smoke, bold = true }
          hl.FzfLuaBorder = { fg = c.green_smoke }
          hl.NormalFloat = { bg = c.background }
          hl.FzfLuaBackdrop = { bg = c.background }
          hl.FoldColumn = { bg = c.background }
          hl.Cursor = { bg = c.goldenrod, fg = c.background, bold = true }
          hl.CursorLineNr = { bg = c.background, fg = c.goldenrod, bold = true }

          hl.NoiceCmdline = { bg = "#30302C" }
          hl.NoicePopup = { bg = c.grey_one }
        end,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      styles = {
        italic = false,
      },
    },
  },
  {
    "dmun/alabaster.nvim",
    enabled = false,
    dev = true,
    init = function()
      vim.g.alabaster_floatborder = true
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    enabled = false,
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
          -- hl["@constant"] = { fg = c.magenta_cooler }
          -- hl["@lsp.typemod.variable.global"] = { link = "@variable.member" }
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
    enabled = false,
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

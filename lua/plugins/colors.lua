return {
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
          colors.bg_active = "#141528"
        end,
        ---@param hl Highlights
        ---@param c ColorScheme
        on_highlights = function(hl, c)
          hl["@variable"] = { link = "lispSymbol" }
          hl["@lsp.typemod.variable.global"] = { link = "@variable.member" }
          hl.PmenuSel = { bg = c.bg_inactive }
          hl.Pmenu = { bg = c.bg_dim }
          hl.PmenuThumb = { bg = c.border }
          hl.BlinkCmpDoc = { bg = c.bg_active }
          hl.BlinkCmpDocSeparator = { fg = c.fg_dim }
          hl.BlinkCmpDocBorder = { bg = c.bg_active }

          -- hl.PmenuSbar = { bg = c.bg_inactive }
          hl.CursorLine = { bg = c.bg_dim }
          hl.CursorLineSign = { bg = c.bg_dim }
          hl.CursorLineNr = { bg = c.bg_dim }
          hl.LineNr = { fg = c.bg_inactive }

          hl.NoiceCmdline = { bg = c.bg_inactive }

          hl.GitSignsAdd = { fg = c.bg_added }
          hl.GitSignsChange = { fg = c.bg_changed }
          hl.GitSignsDelete = { fg = c.bg_removed }

          hl.Visual = { bg = c.bg_inactive }
          hl.Search = { bg = c.bg_inactive }
          hl.NormalTerm = { bg = c.bg_active }

          hl.nCursor = { bg = c.red_cooler }
          hl.iCursor = { bg = c.magenta_intense }
          hl.NormalFloat = { bg = c.bg_dim }

          hl.CursorLineNr = { fg = c.fg_alt }
          hl.LineNrAbove = { link = "LineNr" }
          hl.LineNrBelow = { link = "LineNr" }

          hl.LeapBackdrop = {}
          hl.LeapLabel = { fg = c.magenta_intense }

          -- hl.FzfLuaNormal = { bg = c.bg_active }
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

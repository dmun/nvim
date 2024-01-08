require("catppuccin").setup({
    flavour = "mocha",
    custom_highlights = function(colors)
        return {
            -- Comment = { fg = colors.flamingo },
            -- ["@constant.builtin"] = { fg = colors.peach, style = {} },
            -- ["@comment"] = { fg = colors.surface2, style = { "italic" } },
            -- CursorLine = { bg = colors.base },
            -- NeoTreeCursorLine = { bg = colors.surface0 },
            EndOfBuffer = { fg = colors.surface0 },
            NeoTreeEndOfBuffer = { fg = colors.base },
            FzfLuaBorder = { fg = colors.blue },
            TroubleText = {},
            TroubleCount = { fg = colors.green },
        }
    end
})

vim.cmd "color catppuccin"


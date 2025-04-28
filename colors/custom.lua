local colors = {
	-- PATCH_OPEN
Normal = {fg = "#C9B69A", bg = "#0A2624"},
Comment = {fg = "#217BAF"},
Constant = {fg = "#DEB400"},
PreProc = {link = "Constant"},
CopilotSuggestion = {fg = "#6C908D"},
Cursor = {bg = "#ECE1D2"},
CursorLine = {bg = "#132E2C"},
TreesitterContext = {link = "CursorLine"},
CursorLineNr = {fg = "#C8A200"},
Delimiter = {fg = "#C3B7A7"},
DiagnosticInfo = {fg = "#90C0ED"},
DiagnosticUnnecessary = {fg = "#716A5F"},
Directory = {fg = "#4DB4F7"},
FloatBorder = {fg = "#877D70"},
WinSeparator = {link = "FloatBorder"},
FloatTitle = {fg = "#AEA190", bold = true},
Function = {fg = "#C9B69A"},
["@function"] = {link = "Function"},
Identifier = {fg = "#C9B69A"},
IlluminatedWordRead = {bg = "#1A3735"},
IlluminatedWordText = {bg = "#1A3735"},
IlluminatedWordWrite = {bg = "#1A3735"},
Keyword = {fg = "#ECE1D2"},
Statement = {link = "Keyword"},
["@type.builtin"] = {link = "Keyword"},
LineNr = {fg = "#234341"},
NormalFloat = {},
Number = {fg = "#DEB400"},
Operator = {fg = "#C9B69A"},
Pmenu = {bg = "#334B49"},
BlinkCmpSignatureHelp = {link = "Pmenu"},
BlinkCmpSignatureHelpBorder = {link = "Pmenu"},
PmenuSbar = {bg = "#243E3C"},
PmenuSel = {bg = "#574500"},
QuickFixLine = {link = "PmenuSel"},
PmenuThumb = {bg = "#536D6B"},
Punctuation = {fg = "#C9B69A"},
Special = {fg = "#C9B69A"},
StatusLine = {fg = "#0A2624", bg = "#8A7D69"},
StatusLineNC = {fg = "#0A2624", bg = "#6D6251"},
String = {fg = "#82BC00"},
Tabline = {fg = "#0A2624", bg = "#6D6251"},
TablineSel = {fg = "#C9B69A", bg = "#0A2624", bold = true},
Title = {fg = "#F75782", bold = true},
Type = {fg = "#C9B69A"},
["@type"] = {link = "Type"},
Visual = {bg = "#294D4A"},
diffAdded = {bg = "#485737"},
diffRemoved = {bg = "#6F3442"},
["@keyword.modifier"] = {fg = "#F75782"},
["@lsp.type.modifier"] = {fg = "#F75782"},
["@variable"] = {fg = "#C9B69A"},
	-- PATCH_CLOSE
}

-- colorschemes generally want to do this
vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.cmd("let g:colors_name='my_theme'")

-- apply highlight groups
for group, attrs in pairs(colors) do
	vim.api.nvim_set_hl(0, group, attrs)
end

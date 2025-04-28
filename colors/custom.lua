local colors = {
  -- PATCH_OPEN
Normal = {fg = "#C9B69A", bg = "#092322"},
Added = {fg = "#82BC00"},
Changed = {fg = "#DEB400"},
Comment = {fg = "#2A8EC8"},
Constant = {fg = "#DEB400"},
PreProc = {link = "Constant"},
CopilotSuggestion = {fg = "#6A8D8A"},
Cursor = {bg = "#ECE1D2"},
CursorLine = {bg = "#122C2A"},
TreesitterContext = {link = "CursorLine"},
CursorLineNr = {fg = "#C8A200"},
Delimiter = {fg = "#C3B7A7"},
DiagnosticInfo = {fg = "#90C0ED"},
DiagnosticUnnecessary = {fg = "#716A5F"},
Directory = {fg = "#4DB4F7"},
FloatBorder = {fg = "#877D70", bg = "#071817"},
WinSeparator = {link = "FloatBorder"},
FloatTitle = {fg = "#AEA190", bg = "#071817", bold = true},
Function = {fg = "#C9B69A"},
["@function"] = {link = "Function"},
Identifier = {fg = "#C9B69A"},
IlluminatedWordRead = {bg = "#193533"},
IlluminatedWordText = {bg = "#193533"},
IlluminatedWordWrite = {bg = "#193533"},
Keyword = {fg = "#ECE1D2"},
Statement = {link = "Keyword"},
["@type.builtin"] = {link = "Keyword"},
LineNr = {fg = "#22413E"},
NormalFloat = {bg = "#071817"},
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
Removed = {fg = "#F75A64"},
Special = {fg = "#C9B69A"},
StatusLine = {fg = "#C9B69A", bg = "#071817"},
StatusLineNC = {fg = "#9B8F7D", bg = "#071F1E"},
String = {fg = "#82BC00"},
Tabline = {fg = "#092322", bg = "#071F1E"},
TablineSel = {fg = "#C9B69A", bg = "#092322", bold = true},
Title = {fg = "#F75A64", bold = true},
Type = {fg = "#C9B69A"},
["@type"] = {link = "Type"},
Visual = {bg = "#294D4A"},
diffAdded = {bg = "#485737"},
diffRemoved = {bg = "#733336"},
["@keyword.modifier"] = {fg = "#F75A64"},
["@lsp.type.modifier"] = {fg = "#F75A64"},
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

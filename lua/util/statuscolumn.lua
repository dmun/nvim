local M = {}

M.init = function()
  local wo = vim.wo[vim.g.statusline_winid]

  if not wo.nu or vim.v.virtnum > 0 or vim.v.virtnum < 0 then
    return ""
  end

  local text = (wo.signcolumn ~= "no" and "%s" or "") .. "%="

  if vim.v.relnum == 0 then
    text = "%#CursorLineNr#" .. text .. vim.v.lnum
  elseif wo.rnu then
    text = text .. vim.v.relnum
  else
    text = text .. vim.v.lnum
  end

  return text .. " "
end

return M

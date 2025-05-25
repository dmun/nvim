local M = {}

M.init = function()
  local win = vim.g.statusline_winid
  local wo = vim.wo[win]

  local text = (wo.signcolumn ~= "no" and "%s" or "") .. "%="

  if not wo.nu or vim.v.virtnum > 0 or vim.v.virtnum < 0 then
    return text
  end

  if vim.v.relnum == 0 or not wo.rnu then
    text = "%#CursorLineNr#" .. text .. vim.v.lnum
  else
    text = text .. vim.v.relnum
  end

  return text .. " "
end

return M

local M = {}

M.init = function()
  local text = "%="

  local win = vim.g.statusline_winid
  local wo = vim.wo[win]

  if not wo.nu then
    return ""
  end

  if vim.v.virtnum > 0 or vim.v.virtnum < 0 then
    return ""
  end

  if vim.v.relnum == 0 then
    text = text .. vim.v.lnum
  else
    text = text .. vim.v.relnum
  end

  text = (wo.signcolumn ~= "no" and "%s" or "") .. text

  return text .. " "
end

return M

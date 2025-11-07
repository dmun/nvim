return function()
  local wo = vim.wo[vim.g.statusline_winid]
  local text = (wo.signcolumn ~= "no" and "%s" or "") .. "%="
  if not wo.nu or vim.v.virtnum > 0 or vim.v.virtnum < 0 then
    return ""
  else
    return (
      vim.v.relnum == 0 and ("%#CursorLineNr#" .. text .. vim.v.lnum)
      or wo.rnu and (text .. vim.v.relnum)
      or (text .. vim.v.lnum)
    ) .. " "
  end
end

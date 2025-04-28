local M = {}

local function hl(group) return "%#" .. group .. "#" end

local function pad(text, length)
  local padding = length - vim.fn.strdisplaywidth(text)
  return string.rep(" ", padding) .. text
end

local function file()
  local text = vim.fn.expand("%:.")
  if vim.o.buftype ~= "" then text = vim.o.buftype end
  if text == "" then text = "[No Name]" end
  return hl("Comment") .. text
end

local function location()
  local line = vim.fn.line(".")
  local lines = vim.fn.line("$")
  local col = pad(vim.fn.col("."), 3)
  local ch = vim.api.nvim_get_current_line():sub(col, col)

  return table.concat({
    hl("String"),
    line,
    hl("Constant"),
    "/" .. lines,
    hl("String"),
    " " .. col,
    hl("Constant"),
    " " .. string.format("0x%04X", vim.fn.char2nr(ch)),
  })
end

local function diff()
  local status = vim.b.gitsigns_status_dict or {}
  local tbl = {}

  if status.added and status.added > 0 then
    table.insert(tbl, hl("Added"))
    table.insert(tbl, " +" .. status.added)
  end

  if status.changed and status.changed > 0 then
    table.insert(tbl, hl("Changed"))
    table.insert(tbl, " ~" .. status.changed)
  end

  if status.removed and status.removed > 0 then
    table.insert(tbl, hl("Removed"))
    table.insert(tbl, " -" .. status.removed)
  end

  return table.concat(tbl)
end

function M.render()
  local left = {
    " ",
    file(),
    " ",
    diff(),
  }

  local right = {
    " ",
    location(),
    " ",
  }

  return table.concat(left) .. "%=" .. table.concat(right)
end

return M

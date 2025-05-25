local M = {}

local function hl(group) return "%#" .. group .. "#" end

local function mode()
  local h = hl("GreenFg")
  local m = vim.fn.mode()

  if m == "n" then
    h = hl("GreenFg")
  elseif m == "i" then
    h = hl("YellowFg")
  elseif m == "c" then
    h = hl("RedFg")
  elseif m == "R" then
    h = hl("OrangeFg")
  end

  return h .. "λ"
end

local function pad(text, length)
  local padding = length - vim.fn.strdisplaywidth(text)
  return string.rep(" ", padding) .. text
end

local function file(opts)
  opts = opts or {}
  local F = vim.fn
  local text = F.expand("%:.")
  if vim.o.buftype ~= "" or #text >= 40 then text = vim.o.filetype:upper() end
  if text == "" then text = F.getcwd() end
  return hl(opts.hl or "StatusLine")
    .. F.substitute(text, F.expand("$HOME"), "~", "")
end

local function location(opts)
  local line = vim.fn.line(".")
  local lines = vim.fn.line("$")
  local col = pad(vim.fn.col("."), 3)
  opts = opts or {}

  if vim.o.buftype ~= "" then
    return ""
  end

  if opts.hl == false then
    return table.concat({ line, "/" .. lines, " " .. col })
  end

  return table.concat({
    hl("GreenFg"),
    line,
    hl("YellowFg"),
    "/" .. lines,
    hl("GreenFg"),
    " " .. col,
    -- hl("YellowFg"),
    -- " " .. string.format("0x%04X", vim.fn.char2nr(ch)),
  })
end

local function diff(opts)
  local status = vim.b.minidiff_summary or {}
  local tbl = {}
  opts = opts or {}

  if status.add and status.add > 0 then
    if opts.hl ~= false then table.insert(tbl, hl("Added")) end
    table.insert(tbl, " +" .. status.add)
  end

  if status.change and status.change > 0 then
    if opts.hl ~= false then table.insert(tbl, hl("Changed")) end
    table.insert(tbl, " ~" .. status.change)
  end

  if status.delete and status.delete > 0 then
    if opts.hl ~= false then table.insert(tbl, hl("Removed")) end
    table.insert(tbl, " -" .. status.delete)
  end

  return table.concat(tbl)
end

function M.active()
  local left = {
    " %<",
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

function M.inactive()
  local left = {
    " %<",
    file({ hl = "Comment" }),
    " ",
    diff({ hl = false }),
  }

  local right = {
    " ",
    location({ hl = false }),
    " ",
  }

  return table.concat(left) .. "%=" .. table.concat(right)
end

return M

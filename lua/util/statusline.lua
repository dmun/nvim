local F = vim.fn
local au = require("util").au
local methods = {}
local statusline = {}
local component_cache = {}
local component_dirty = {}
local component_id = 0

methods.hl = function(self, hl)
  table.insert(self.segments, "%#")
  table.insert(self.segments, hl)
  table.insert(self.segments, "#")
  return self
end

methods.pad = function(self, pad)
  if not pad then
    table.insert(self.segments, " ")
    return self
  end
  table.insert(self.segments, string.rep(" ", pad))
  return self
end

methods.text = function(self, segment)
  table.insert(self.segments, segment)
  return self
end

methods.right = function(self)
  table.insert(self.segments, "%=")
  return self
end

methods.draw = function(self, event)
  if event and component_cache[component_id] == nil then
    local id = component_id
    au(event, "*", function()
      component_dirty[id] = true
    end)
  end

  if component_dirty[component_id] then
    local segments = {}
    local args
    if self.args then
      args = self.args()
    end
    for _, segment in ipairs(self.segments) do
      if type(segment) == "function" then
        segment = segment(args)
      end
      table.insert(segments, segment)
    end
    component_cache[component_id] = table.concat(segments)
    component_dirty[component_id] = false
  end

  table.insert(statusline, component_cache[component_id])

  return self
end

local mt = { __index = methods }

local component = function(...)
  component_id = component_id + 1
  local obj = { segments = {}, args = ... }
  if component_dirty[component_id] == nil then
    component_dirty[component_id] = true
  end
  return setmetatable(obj, mt)
end

local grapple_fn = function()
  local ok, grapple = pcall(require, "grapple")
  if not ok then return "?" end
  return grapple.name_or_index() or "?"
end

local mode_hl = function()
  local m = vim.fn.mode()

  if m == "n" then
    return "GreenBg"
  elseif m == "i" then
    return "YellowBg"
  elseif m == "c" then
    return "RedBg"
  elseif m == "R" then
    return "OrangeBg"
  else
    return "BlueBg"
  end
end

local file_fn = function()
  local text = F.expand("%:.")
  if vim.o.buftype ~= "" or #text >= 40 then text = vim.o.filetype end
  if text == "" then text = F.getcwd() end
  return F.substitute(text, F.expand("$HOME"), "~", "")
end

local diff_fn = function() return vim.b.minidiff_summary or {} end

local diff_add_fn = function(diff)
  if not diff.add or diff.add == 0 then return "" end
  return " +" .. diff.add
end

local diff_change_fn = function(diff)
  if not diff.change or diff.change == 0 then return "" end
  return " ~" .. diff.change
end

local diff_delete_fn = function(diff)
  if not diff.delete or diff.delete == 0 then return "" end
  return " -" .. diff.delete
end

local diagnostics_fn = function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then return {} end
  local counts = vim.iter(diagnostics):fold({}, function(acc, diagnostic)
    acc[diagnostic.severity] = (acc[diagnostic.severity] or 0) + 1
    return acc
  end)
  local error = counts[vim.diagnostic.severity.ERROR] or 0
  local warn = counts[vim.diagnostic.severity.WARN] or 0
  local info = counts[vim.diagnostic.severity.INFO] or 0
  local hint = counts[vim.diagnostic.severity.HINT] or 0
  return { error = error, warn = warn, info = info, hint = hint }
end

local build = function(active)
  statusline = {}
  component_id = 0

  local normal_hl = active and "StatusLine" or "StatusLineNC"

  component()
      :hl(mode_hl)
      :pad()
      :text(function() return vim.fn.mode():upper() end)
      :pad()
      :draw("ModeChanged")

  component()
      :hl(normal_hl)
      :pad()
      :text("(")
      :hl("Title"):text(grapple_fn)
      :hl(normal_hl):text(")")
      :draw({ "BufEnter", "BufLeave" })

  component()
      :hl(normal_hl)
      :pad()
      :text(file_fn)
      :pad()
      :draw({ "BufEnter", "BufLeave" })

  component(diff_fn)
      :hl("GreenFg")
      :text(diff_add_fn)
      :hl("OrangeFg")
      :text(diff_change_fn)
      :hl("RedFg")
      :text(diff_delete_fn)
      :draw({ "BufWinEnter", "BufWritePost", "TextChanged" })

  component(diagnostics_fn)
      :right()
      :hl("RedFg")
      :text(function(diagnostics)
        if not diagnostics.error or diagnostics.error == 0 then return "" end
        return " " .. diagnostics.error
      end)
      :hl("YellowFg")
      :text(function(diagnostics)
        if not diagnostics.warn or diagnostics.warn == 0 then return "" end
        return "  " .. diagnostics.warn
      end)
      :pad()
      :draw("DiagnosticChanged")


  return table.concat(statusline)
end

local active = function()
  return build(true)
end

local inactive = function()
  return build(false)
end

local setup = function()
  au({ "WinEnter", "BufEnter", "BufWinEnter" }, "*", function()
    vim.wo.statusline = [[%!v:lua.require'util.statusline'.active()]]
  end)

  au({ "WinLeave" }, "*", function()
    vim.wo.statusline = [[%!v:lua.require'util.statusline'.inactive()]]
  end)
end

return { setup = setup, active = active, inactive = inactive }

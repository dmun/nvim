local F = vim.fn
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
  if segment then
    table.insert(self.segments, segment)
  end
  return self
end

methods.right = function(self)
  table.insert(self.segments, "%=")
  return self
end

methods.cutoff = function(self)
  table.insert(self.segments, "%<")
  return self
end

methods.draw = function(self, event, pattern)
  event = event or {}
  if type(event) == "string" then
    event = { event }
  end
  event = vim.tbl_extend("force", {
    "BufEnter",
    "BufLeave",
    "WinLeave",
    "WinEnter",
    "BufWinEnter",
  }, event)
  if component_cache[component_id] == nil then
    local id = component_id
    au(event, pattern or "*", function()
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

local file_fn = function()
  local head = F.expand("%:~:.:h")
  local tail = "%t %m"
  return {
    F.empty(head) == 1 and "" or ("(" .. head .. ")"),
    tail,
  }
end

local diff_fn = function()
  return vim.b.minidiff_summary or {}
end

local diff_add_fn = function(diff)
  if not diff.add or diff.add == 0 then
    return ""
  end
  return " +" .. diff.add
end

local diff_change_fn = function(diff)
  if not diff.change or diff.change == 0 then
    return ""
  end
  return " ~" .. diff.change
end

local diff_delete_fn = function(diff)
  if not diff.delete or diff.delete == 0 then
    return ""
  end
  return " -" .. diff.delete
end

local diagnostics_fn = function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    return {}
  end
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

local stab_fn = function()
  return vim.b.stabbing or false
end

local build = function(active)
  statusline = {}
  component_id = 0

  local normal_hl = active and "StatusLine" or "StatusLineNC"

  component(file_fn)
    :pad(2)
    :hl("StatusLineBold")
    :text(function(file)
      return file[2]
    end)
    :hl("StatusLine")
    :pad()
    :text(function(file)
      return file[1]
    end)
    :cutoff()
    :draw({ "BufWritePost", "DirChanged", "BufEnter", "BufLeave" })

  component(diff_fn)
    :pad()
    :text(diff_add_fn)
    :text(diff_change_fn)
    :text(diff_delete_fn)
    :draw({ "BufWinEnter", "BufWritePost", "TextChanged" })

  component():hl("StatusLineHidden"):text(""):hl("StatusLine"):draw()

  component(diagnostics_fn)
    :right()
    :hl("RedFg")
    :text(function(diagnostics)
      if not diagnostics.error or diagnostics.error == 0 then
        return ""
      end
      return " " .. diagnostics.error
    end)
    :hl("YellowFg")
    :text(function(diagnostics)
      if not diagnostics.warn or diagnostics.warn == 0 then
        return ""
      end
      return "  " .. diagnostics.warn
    end)
    :pad()
    :hl("StatusLine")
    :draw("DiagnosticChanged")

  component():text(" %l/%L  %c "):draw({ "CursorMoved", "CursorMovedI" })

  return table.concat(statusline)
end

local active = function()
  return build(true)
end

local inactive = function()
  return build(false)
end

local setup = function()
  au({ "WinEnter", "BufEnter", "BufWinEnter", "User" }, "*", function()
    vim.wo.statusline = [[%!v:lua.require'util.statusline'.active()]]
  end)

  au({ "WinLeave" }, "*", function()
    vim.wo.statusline = [[%!v:lua.require'util.statusline'.inactive()]]
  end)
end

return { setup = setup, active = active, inactive = inactive }

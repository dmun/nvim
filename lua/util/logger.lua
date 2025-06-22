local M = {}

local log_file = vim.fn.stdpath("state") .. "/stab.log"

local function write_log(level, ...)
  local args = { ... }
  for i, arg in ipairs(args) do
    if type(arg) ~= "string" then
      args[i] = vim.inspect(arg)
    end
  end

  local msg = table.concat(args, " ")
  local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")

  local log_entry = {
    time = timestamp,
    level = level,
    message = msg,
  }

  vim.schedule(function()
    local json = vim.fn.json_encode(log_entry) .. "\n"
    local file = io.open(log_file, "a")
    if file then
      file:write(json)
      file:close()
    end
  end)
end

M.debug = function(...)
  write_log("DEBUG", ...)
end

M.info = function(...)
  write_log("INFO", ...)
end

M.warn = function(...)
  write_log("WARN", ...)
end

M.error = function(...)
  write_log("ERROR", ...)
end

M.trace = function(...)
  write_log("TRACE", ...)
end

return M

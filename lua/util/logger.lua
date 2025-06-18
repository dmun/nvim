local M = {}

local log_file = vim.fn.stdpath("data") .. "/stab.log"

local function write_log(level, ...)
  local args = { ... }
  for i, arg in ipairs(args) do
    if type(arg) ~= "string" then
      args[i] = vim.inspect(arg)
    end
  end

  local msg = table.concat(args, " ")
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local log_entry = string.format(
    "[%s] [%s]: %s\n",
    timestamp,
    level,
    msg
  )

  local file = io.open(log_file, "a")
  if file then
    file:write(log_entry)
    file:close()
  end
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

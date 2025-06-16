local M = {}
M.__index = M

---@param size number
---@return table
function M:new(size)
  local instance = {
    buffer = {},
    size = size,
    start = 1,
    count = 0
  }
  setmetatable(instance, M)
  return instance
end

function M:add(value)
  local index = (self.start + self.count - 1) % self.size + 1
  self.buffer[index] = value
  if self.count == self.size then
    self.start = self.start % self.size + 1
  else
    self.count = self.count + 1
  end
end

function M:get_all()
  local result = {}
  for i = 0, self.count - 1 do
    local index = (self.start + i - 1) % self.size + 1
    table.insert(result, self.buffer[index])
  end
  return result
end

return M

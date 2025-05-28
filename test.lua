local test = 1
local n = 10000000

local tbl = {}

if test == 1 then
  print("Testing traditional metatable with table reuse...")
  for i = 1, n do
    tbl[i] = "bruh" .. "bruh2"
  end
elseif test == 2 then
  print("Testing __index table with table reuse...")
  for i = 1, n do
    tbl[i] = table.concat({ "bruh", "bruh2" })
  end
end

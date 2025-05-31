local F = vim.fn
local last_query
local last_direction
local last_au

local jump_fn = function(direction, n)
  local flags = { "W" }
  last_direction = last_direction or direction
  if last_direction * direction == -1 then
    flags[#flags + 1] = "b"
  end
  n = n or 2

  if last_au and last_query then
    vim.o.eventignore = "CursorMoved"
    F.search(last_query, table.concat(flags))
    vim.schedule(function() vim.o.eventignore = "" end)
  else
    local match_id
    local chars = {}

    for i = 1, n do
      local char = F.getcharstr()
      if char == "\27" then
        return
      end

      chars[i] = char
      if match_id then F.matchdelete(match_id) end
      match_id = F.matchadd("Hermes", table.concat(chars))
      cmd.redraw()
    end

    last_query = table.concat(chars)
    F.search(last_query)

    vim.schedule(function()
      last_au = au("CursorMoved", "*", function()
        if not last_query then return end
        pcall(vim.api.nvim_del_autocmd, last_au)
        for _, m in ipairs(F.getmatches()) do
          if m.group == "Hermes" then
            pcall(F.matchdelete, m.id)
          end
        end
        last_au = nil
        last_query = nil
        last_direction = nil
      end)
    end)
  end
end

local jump = function(direction, n)
  for _ = 1, vim.v.count1 do
    jump_fn(direction, n)
  end
end

return { jump = jump }

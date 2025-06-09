local M = {}
local timer = nil
local frame = 1
local frames = { "|", "/", "-", "\\" }

M.current_frame = frames[1]

function M.start()
  if timer then return end

  timer = vim.uv.new_timer()
  assert(timer, "Failed to create timer")

  timer:start(0, 100, function()
    vim.schedule(function()
      vim.cmd.doautocmd("User", "StabStateChanged")
      M.current_frame = frames[frame]
      frame = frame % #frames + 1
    end)
  end)
end

function M.stop()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

return M

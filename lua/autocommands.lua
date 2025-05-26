local map = vim.keymap.set
local au = require("util").au

au("LspAttach", "*", function()
  map("n", "<CR>", vim.lsp.buf.code_action, { buffer = true })
  map("n", "<C-w><C-d>", function()
    local p = vim.o.winborder == "" and 0 or 2
    vim.diagnostic.open_float({
      max_width = math.floor(vim.o.columns * 0.8) - p,
      max_height = math.floor(vim.o.lines / 2) - p - 1,
      close_events = { "CursorMoved" },
    })
  end, { buffer = true })
  map("n", "K", function()
    local p = vim.o.winborder == "" and 0 or 2
    vim.lsp.buf.hover({
      max_width = math.floor(vim.o.columns * 0.8) - p,
      max_height = math.floor(vim.o.lines / 2) - p - 1,
      close_events = { "CursorMoved" },
    })
  end, { buffer = true })
end)

au("TextYankPost", "*", function()
  vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
end)

-- au("InsertLeave", "*", function()
--   if vim.o.nu then vim.o.rnu = true end
-- end)
-- au("InsertEnter", "*", function()
--   if vim.o.nu then vim.o.rnu = false end
-- end)

_G.AUTOSAVE_TIMER = vim.uv.new_timer()
au({ "InsertLeave", "TextChanged" }, "*", function()
  if vim.bo.buftype == "" then
    if _G.AUTOSAVE_TIMER then
      vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
    else
      _G.AUTOSAVE_TIMER = vim.uv.new_timer()
    end

    vim.uv.timer_start(_G.AUTOSAVE_TIMER, 200, 0, function()
      vim.schedule(function()
        vim.cmd("silent! update")
      end)
      vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
      _G.AUTOSAVE_TIMER = nil
    end)
  end
end)

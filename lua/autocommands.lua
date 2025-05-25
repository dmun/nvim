local map = vim.keymap.set
local au = function(event, pattern, callback, buffer)
  vim.api.nvim_create_autocmd(
    event,
    { pattern = pattern, callback = callback, buffer = buffer }
  )
end

au("LspAttach", "*", function()
  map("n", "<CR>", vim.lsp.buf.code_action, { buffer = true })
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

au({ "WinEnter", "BufEnter", "BufWinEnter" }, "*", function()
  vim.wo.statusline = [[%{%v:lua.require'util.statusline'.active()%}]]
end)

au({ "WinLeave" }, "*", function()
  vim.wo.statusline = [[%{%v:lua.require'util.statusline'.inactive()%}]]
end)

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

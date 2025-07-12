au("LspAttach", "*", function()
  nmap("<CR>", vim.lsp.buf.code_action, { buffer = true })
  nmap("<C-w><C-d>", function()
    local p = vim.o.winborder == "" and 0 or 2
    vim.diagnostic.open_float({
      max_width = math.floor(vim.o.columns * 0.8) - p,
      max_height = math.floor(vim.o.lines / 2) - p - 1,
      close_events = { "CursorMoved" },
    })
  end, { buffer = true })
  nmap("K", function()
    local p = vim.o.winborder == "" and 0 or 2
    vim.lsp.buf.hover({
      max_width = math.floor(vim.o.columns * 0.8) - p,
      max_height = math.floor(vim.o.lines / 2) - p - 1,
      close_events = { "CursorMoved" },
    })
  end, { buffer = true })
end)

-- au("ModeChanged", "i:n", function(ev)
--   if vim.fn.col(".") ~= 1 then
--     vim.fn.feedkeys("l")
--   end
-- end)

au("TextYankPost", "*", function()
  vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
end)

-- au("InsertLeave", "*", function()
--   if vim.o.nu then vim.o.rnu = true end
-- end)
-- au("InsertEnter", "*", function()
--   if vim.o.nu then vim.o.rnu = false end
-- end)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "gtk.css",
  callback = function()
    local theme = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.fn.system("gsettings set org.gnome.desktop.interface gtk-theme ''")
    vim.fn.system("gsettings set org.gnome.desktop.interface gtk-theme '" .. theme .. "'")
    vim.notify("reloaded gtk-theme: " .. theme)
  end,
})

local autosave_filter = { "sql", "hyprlang" }
_G.AUTOSAVE_TIMER = vim.uv.new_timer()
au({ "InsertLeave", "TextChanged" }, "*", function()
  if vim.bo.buftype == "" and not vim.tbl_contains(autosave_filter, vim.bo.filetype) then
    if _G.AUTOSAVE_TIMER then
      vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
    else
      _G.AUTOSAVE_TIMER = vim.uv.new_timer()
    end

    vim.uv.timer_start(_G.AUTOSAVE_TIMER, 200, 0, function()
      vim.schedule(function()
        cmd("silent! update")
      end)
      vim.uv.timer_stop(_G.AUTOSAVE_TIMER)
      _G.AUTOSAVE_TIMER = nil
    end)
  end
end)

au("LspAttach", "*", function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client then
    client.server_capabilities.semanticTokensProvider = nil
  end
end)

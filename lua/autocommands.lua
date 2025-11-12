local au = vim.api.nvim_create_autocmd

-- General

-- Highlight yank
au("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "Search", timeout = 200 })
  end,
})

-- Open help in new tab
au("Filetype", {
  pattern = "help",
  callback = function()
    vim.cmd("wincmd T")
  end,
})

-- Autosave with filter
local ft_filter = { "sql", "gdscript", "hyprlang" }
au({ "TextChanged", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and not vim.tbl_contains(ft_filter, vim.bo.filetype) then
      if AutosaveTimer then
        AutosaveTimer:stop()
      else
        _G.AutosaveTimer = vim.uv.new_timer()
      end
      AutosaveTimer:start(150, 0, function()
        vim.schedule(function()
          vim.cmd("silent! update")
        end)
        AutosaveTimer:stop()
        AutosaveTimer:close()
        _G.AutosaveTimer = nil
      end)
    end
  end,
})

-- Lsp

-- Disable lsp semantic tokens
au("LspAttach", {
  pattern = "*",
  callback = function(args)
    if args.data and args.data.client_id then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end
  end,
})

-- Change lsp winopts
au("LspAttach", {
  pattern = "*",
  callback = function()
    local max_width = math.floor(vim.o.columns * 0.8)
    local max_height = math.floor((vim.o.lines / 2) - 2)
    local close_events = { "CursorMoved" }
    local winopts = {
      max_width = max_width,
      max_height = max_height,
      close_events = close_events,
    }
    nmap("<Leader>a", vim.lsp.buf.code_action)
    nmap("<C-w><C-d>", function()
      vim.diagnostic.open_float(winopts)
    end)
    nmap("K", function()
      vim.lsp.buf.hover(winopts)
    end)
  end,
})

-- Special buffers

-- Add q quit keymap
au("BufReadPost", {
  pattern = "*",
  callback = function()
    if not vim.tbl_contains({ "", "acwrite" }, vim.bo.buftype) then
      nmap("q", "<C-w>q", { buffer = true })
    end
  end,
})

-- Change background color
local function gui_fn()
  vim.opt_local.winhl = "Normal:MsgArea"
end

au("FileType", {
  pattern = { "orgagenda", "oil", "vim" },
  callback = gui_fn,
})

au("BufReadPost", {
  pattern = "*",
  callback = function()
    if not vim.tbl_contains({ "", "acwrite" }, vim.bo.buftype) then
      gui_fn()
    end
  end,
})

-- -- Hide line numbers
-- au("FileType", {
--   pattern = { "org", "orgagenda", "fugitive" },
--   callback = function()
--     vim.opt_local.number = false
--     vim.opt_local.conceallevel = 3
--     vim.opt_local.relativenumber = false
--   end,
-- })

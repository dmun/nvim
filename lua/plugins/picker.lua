local M = {}

M.state = {}
local picker_height = 8

local ns_id = vim.api.nvim_create_namespace("custom_select")

function math.clamp(x, min, max)
  return math.min(math.max(x, min), max)
end

function M.render()
  vim.o.cmdheight = picker_height
  local lines = {}
  local widest = 20

  if M.state.loading then
    vim.api.nvim_buf_set_lines(M.state.items_buf, 0, -1, false, { "  Loading…" })
    if vim.api.nvim_win_is_valid(M.state.items_win) then
      vim.api.nvim_win_set_config(M.state.items_win, { hide = false })
      vim.wo[M.state.items_win].cursorline = false
    end
    return
  end

  for _, item in ipairs(M.state.filtered) do
    table.insert(lines, " " .. item.text .. " ")
    widest = math.max(widest, #item.text)
  end

  vim.api.nvim_buf_set_lines(M.state.items_buf, 0, -1, false, lines)

  vim.api.nvim_buf_clear_namespace(M.state.items_buf, ns_id, 0, -1)
  if #M.state.filtered > 0 then
    vim.api.nvim_win_set_cursor(M.state.items_win, { M.state.selected, 0 })
  end

  if vim.api.nvim_win_is_valid(M.state.items_win) then
    vim.api.nvim_win_set_config(M.state.items_win, {
      hide = not lines,
    })
    vim.wo[M.state.items_win].cursorline = not vim.tbl_isempty(lines)
  end
end

function M.select_next()
  M.state.selected = math.min(M.state.selected + 1, #M.state.filtered)
  M.render()
end

function M.select_prev()
  M.state.selected = math.max(M.state.selected - 1, 1)
  M.render()
end

function M.select_first()
  M.state.selected = 1
  M.render()
end

function M.select_last()
  M.state.selected = #M.state.filtered
  M.render()
end

local function cleanup()
  if M.state.is_closing then
    return
  end
  M.state.is_closing = true
  if M.state.fzf_job then
    M.state.fzf_job:kill(9)
  end
  if vim.api.nvim_win_is_valid(M.state.prompt_win) then
    vim.api.nvim_win_close(M.state.prompt_win, true)
  end
  if vim.api.nvim_win_is_valid(M.state.items_win) then
    vim.api.nvim_win_close(M.state.items_win, true)
  end
  vim.cmd("stopinsert")
  vim.o.cmdheight = 1
end

function M.ui_select(items, opts, on_choice)
  local current_win = vim.api.nvim_get_current_win()
  opts = opts or {}
  local formatted = {}

  M.state = {
    filtered = {},
    selected = 1,
    is_closing = false,
    query = "",
    loading = type(items) == "function",
    fzf_job = nil,
  }

  M.state.prompt_buf = vim.api.nvim_create_buf(false, true)
  vim.b[M.state.prompt_buf].completion = false
  M.state.prompt_win = vim.api.nvim_open_win(M.state.prompt_buf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = 1,
    row = vim.o.lines - picker_height,
    col = 0,
    style = "minimal",
    border = { "", "", "", " ", "", "", "", " " },
    zindex = 250,
  })
  vim.wo[M.state.prompt_win].winhl = "NormalFloat:Normal,FloatBorder:Normal"
  vim.b[M.state.prompt_buf].buftype = "nofile"
  vim.api.nvim_buf_set_extmark(M.state.prompt_buf, ns_id, 0, 0, {
    virt_text_pos = "inline",
    virt_text = { { opts.prompt .. "> ", "Function" } },
    right_gravity = false,
  })

  M.state.items_buf = vim.api.nvim_create_buf(false, true)
  M.state.items_win = vim.api.nvim_open_win(M.state.items_buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = picker_height - 1,
    row = vim.o.lines - picker_height + 1,
    col = 0,
    anchor = "NW",
    style = "minimal",
    border = "none",
    zindex = 250,
  })
  vim.wo[M.state.items_win].winhl = "NormalFloat:Normal"
  vim.wo[M.state.items_win].scrolloff = 2
  vim.wo[M.state.items_win].cursorline = true
  vim.wo[M.state.items_win].cursorlineopt = "both"

  local function refilter()
    if M.state.query == "" then
      M.state.filtered = formatted
      M.state.selected = math.clamp(M.state.selected, 1, math.max(1, #M.state.filtered))
      M.render()
      return
    end

    if M.state.fzf_job then
      M.state.fzf_job:kill(9)
      M.state.fzf_job = nil
    end

    local input = table.concat(vim.tbl_map(function(item) return item.text end, formatted), "\n")
    local by_text = {}
    for _, item in ipairs(formatted) do by_text[item.text] = item end

    M.state.fzf_job = vim.system(
      { "fzf", "--filter", M.state.query },
      { text = true, stdin = input },
      function(result)
        vim.schedule(function()
          if M.state.is_closing then return end
          M.state.filtered = {}
          for _, t in ipairs(vim.split(result.stdout or "", "\n", { trimempty = true })) do
            if by_text[t] then table.insert(M.state.filtered, by_text[t]) end
          end
          M.state.selected = math.clamp(M.state.selected, 1, math.max(1, #M.state.filtered))
          M.render()
        end)
      end
    )
  end

  local function load_items(raw_items)
    formatted = {}
    for i, item in ipairs(raw_items) do
      table.insert(formatted, { text = (opts.format_item or tostring)(item), raw = item, idx = i })
    end
    M.state.loading = false
    refilter()
  end

  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = M.state.prompt_buf,
    callback = function()
      M.state.selected = 1
      local line = vim.api.nvim_buf_get_lines(M.state.prompt_buf, 0, 1, false)[1] or ""
      M.state.query = line
      if not M.state.loading then
        refilter()
      end
    end,
  })

  local map = function(key, action)
    vim.keymap.set("i", key, action, { buffer = M.state.prompt_buf, nowait = true })
  end

  map("<CR>", function()
    local chosen = M.state.filtered[M.state.selected]
    cleanup()
    on_choice(chosen and chosen.raw, chosen and chosen.idx)
  end)
  map("<Esc>", function() cleanup() end)
  map("<C-c>", function() cleanup() end)
  map("<Tab>",   function() M.select_next() end)
  map("<S-Tab>", function() M.select_prev() end)
  map("<C-n>",   function() M.select_next() end)
  map("<C-p>",   function() M.select_prev() end)

  M.render()
  vim.cmd("startinsert")

  if type(items) == "function" then
    items(function(raw_items)
      vim.schedule(function()
        if not M.state.is_closing then load_items(raw_items) end
      end)
    end)
  else
    load_items(items)
  end
end

return M

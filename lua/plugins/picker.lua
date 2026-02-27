local M = {}

M.state = {}

local ns_id = vim.api.nvim_create_namespace("custom_select")

function M.render()
  local lines = {}
  local widest = 20
  for _, item in ipairs(M.state.filtered) do
    table.insert(lines, " " .. item.text .. " ")
  end
  if #lines == 0 then
    lines = { " No match found " }
    widest = #lines[1]
  else
    local visible_count = math.min(#lines, 8)
    for i = 1, visible_count do
      widest = math.min(math.max(widest, #lines[i]), 50)
    end
  end

  vim.api.nvim_buf_set_lines(M.state.items_buf, 0, -1, false, lines)

  vim.api.nvim_buf_clear_namespace(M.state.items_buf, ns_id, 0, -1)
  if #M.state.filtered > 0 then
    vim.api.nvim_buf_set_extmark(M.state.items_buf, ns_id, M.state.selected - 1, 0, {
      line_hl_group = "PmenuSel",
    })
    vim.api.nvim_win_set_cursor(M.state.items_win, { M.state.selected, 0 })
  end

  if vim.api.nvim_win_is_valid(M.state.items_win) then
    vim.api.nvim_win_set_config(M.state.items_win, {
      height = math.min(math.max(#lines, 1), 8),
      width = widest,
    })
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

local function cleanup(choice_raw, choice_idx)
  if M.state.is_closing then
    return
  end
  M.state.is_closing = true
  if vim.api.nvim_win_is_valid(M.state.prompt_win) then
    vim.api.nvim_win_close(M.state.prompt_win, true)
  end
  if vim.api.nvim_win_is_valid(M.state.items_win) then
    vim.api.nvim_win_close(M.state.items_win, true)
  end
  vim.cmd("stopinsert")
end

function M.ui_select(items, opts, on_choice)
  opts = opts or {}
  -- local prompt_str = " "
  local formatted = {}
  for i, item in ipairs(items) do
    table.insert(formatted, { text = (opts.format_item or tostring)(item), raw = item, idx = i })
  end

  local width = math.floor(vim.o.columns * 0.4)

  M.state = {
    filtered = formatted,
    selected = 1,
    is_closing = false,
  }

  M.state.prompt_buf = vim.api.nvim_create_buf(false, true)
  vim.b[M.state.prompt_buf].completion = false
  M.state.prompt_win = vim.api.nvim_open_win(M.state.prompt_buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 2 / 3),
    height = 1,
    row = vim.o.lines - 1,
    col = 0,
    style = "minimal",
    border = { "", "", "", " ", "", "", "", " " },
  })
  -- vim.api.nvim_win_set_cursor(M.state.prompt_win, { 1, #prompt_str })
  vim.wo[M.state.prompt_win].winhl = "NormalFloat:StatusLine,FloatBorder:StatusLine"

  M.state.items_buf = vim.api.nvim_create_buf(false, true)
  M.state.items_win = vim.api.nvim_open_win(M.state.items_buf, false, {
    relative = "editor",
    width = width,
    height = 1,
    row = vim.o.lines - 2,
    col = 0,
    anchor = "SW",
    style = "minimal",
    border = "none",
  })
  vim.wo[M.state.items_win].winhl = "NormalFloat:Pmenu"
  vim.wo[M.state.items_win].scrolloff = 2

  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = M.state.prompt_buf,
    callback = function()
      M.state.selected = 1
      local line = vim.api.nvim_buf_get_lines(M.state.prompt_buf, 0, 1, false)[1] or ""
      local query = line

      if query == "" then
        M.state.filtered = formatted
      else
        local texts = vim.tbl_map(function(item)
          return item.text
        end, formatted)
        local matched = vim.fn.matchfuzzy(texts, query)
        M.state.filtered = {}
        for _, m_text in ipairs(matched) do
          for _, item in ipairs(formatted) do
            if item.text == m_text then
              table.insert(M.state.filtered, item)
              break
            end
          end
        end
      end
      M.state.selected = math.min(M.state.selected, math.max(1, #M.state.filtered))
      M.render()
    end,
  })

  local map = function(key, action, expr)
    vim.keymap.set("i", key, action, { buffer = M.state.prompt_buf, nowait = true, expr = expr })
  end

  map("<CR>", function()
    local chosen = M.state.filtered[M.state.selected]
    cleanup()
    on_choice(chosen and chosen.raw, chosen and chosen.idx)
  end)
  map("<Esc>", function()
    cleanup()
  end)
  map("<C-c>", function()
    cleanup()
  end)

  map("<Tab>", function()
    M.select_next()
  end)
  map("<S-Tab>", function()
    M.select_prev()
  end)

  map("<C-n>", function()
    M.select_next()
  end)
  map("<C-p>", function()
    M.select_prev()
  end)

  M.render()
  vim.cmd("startinsert")
end

return M

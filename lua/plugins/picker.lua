local M = {}

local NS_ID = vim.api.nvim_create_namespace("custom_select")
local WINHL = "NormalFloat:MsgArea,FloatBorder:MsgArea"
local HEIGHT = 8

M.state = {}

function math.clamp(x, min, max)
  return math.min(math.max(x, min), max)
end

local fg = vim.api.nvim_get_hl(0, { name = "Comment" })
local bg = vim.api.nvim_get_hl(0, { name = "MsgArea" })
vim.api.nvim_set_hl(0, "PickerItemsLoading", { fg = fg.fg, bg = bg.bg })

local function kill_job()
  if M.state.job then
    M.state.job:kill(9)
    M.state.job = nil
  end
end

local function cleanup()
  kill_job()
  if vim.api.nvim_win_is_valid(M.state.prompt_win) then
    vim.api.nvim_win_close(M.state.prompt_win, true)
  end
  if vim.api.nvim_win_is_valid(M.state.items_win) then
    vim.api.nvim_win_close(M.state.items_win, true)
  end
  vim.cmd("stopinsert")
  vim.o.cmdheight = 1
end

local function setup_keymaps(buf, on_choice)
  local map = function(key, action)
    vim.keymap.set("i", key, action, { buffer = buf, nowait = true })
  end

  map("<CR>", function()
    local chosen = M.state.results[M.state.selected]
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
end

local function create_prompt_buf_win(prompt_text, on_choice)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.b[buf].completion = false
  vim.b[buf].buftype = "nofile"

  vim.cmd.startinsert()

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = 1,
    row = vim.o.lines - HEIGHT,
    col = 0,
    style = "minimal",
    border = { "", "", "", " ", "", "", "", " " },
    zindex = 250,
  })
  vim.wo[win].winhl = WINHL

  -- add prompt text
  vim.api.nvim_buf_set_extmark(buf, NS_ID, 0, 0, {
    virt_text_pos = "inline",
    virt_text = { { prompt_text .. " ", "PickerPrompt" } },
    right_gravity = false,
  })

  setup_keymaps(buf, on_choice)

  return buf, win
end

local function create_items_buf_win()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = HEIGHT - 1,
    row = vim.o.lines - HEIGHT + 1,
    col = 0,
    anchor = "NW",
    style = "minimal",
    border = "none",
    zindex = 250,
  })
  vim.wo[win].winhl = WINHL
  vim.wo[win].scrolloff = 2
  vim.wo[win].cursorline = true
  vim.wo[win].cursorlineopt = "both"

  return buf, win
end

local function update()
  vim.o.cmdheight = HEIGHT
  local lines = {}

  if M.state.loading then
    vim.api.nvim_win_set_config(M.state.items_win, { hide = false })
    vim.wo[M.state.items_win].cursorline = false
    vim.wo[M.state.items_win].winhl = WINHL .. ",NormalFloat:PickerItemsLoading"
    vim.wo[M.state.prompt_win].winhl = WINHL .. ",PickerPrompt:WarningMsg"
    return
  else
    vim.wo[M.state.items_win].winhl = WINHL
    vim.wo[M.state.prompt_win].winhl = WINHL .. ",PickerPrompt:Function"
  end

  for _, item in ipairs(M.state.results) do
    table.insert(lines, " " .. item.text .. " ")
  end

  vim.api.nvim_buf_set_lines(M.state.items_buf, 0, -1, false, lines)

  if #M.state.results > 0 then
    vim.api.nvim_win_set_cursor(M.state.items_win, { M.state.selected, 0 })
  end

  vim.api.nvim_win_set_config(M.state.items_win, { hide = not lines })
  vim.wo[M.state.items_win].cursorline = not vim.tbl_isempty(lines)

  vim.fn.clearmatches(M.state.items_win)
  vim.fn.matchadd("PmenuMatch", M.state.query, nil, -1, {
    window = M.state.items_win,
  })
end

function M.select_next()
  M.state.selected = math.min(M.state.selected + 1, #M.state.results)
  update()
end

function M.select_prev()
  M.state.selected = math.max(M.state.selected - 1, 1)
  update()
end

function M.select_first()
  M.state.selected = 1
  update()
end

function M.select_last()
  M.state.selected = #M.state.results
  update()
end

local function filter()
  M.state.results = {}
  local pattern = string.gsub(M.state.query, " ", ".*")
  for _, item in ipairs(M.state.formatted) do
    if M.state.query == "" or vim.fn.match(item.text, pattern) >= 0 then
      table.insert(M.state.results, item)
    end
  end
  M.state.selected = math.clamp(M.state.selected, 1, math.max(1, #M.state.results))
  update()
end

local function load_items(items, opts)
  M.state.formatted = {}
  for i, item in ipairs(items) do
    table.insert(M.state.formatted, { text = (opts.format_item or tostring)(item), raw = item, idx = i })
  end
  M.state.loading = false
  filter()
end

function M.ui_select(items, opts, on_choice)
  opts = opts or {}

  M.state = {
    formatted = {},
    results = {},
    selected = 1,
    query = "",
    loading = false,
  }

  M.state.prompt_buf, M.state.prompt_win = create_prompt_buf_win(opts.prompt or "", on_choice)
  M.state.items_buf, M.state.items_win = create_items_buf_win()

  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = M.state.prompt_buf,
    callback = function()
      M.state.selected = 1
      local line = vim.api.nvim_buf_get_lines(M.state.prompt_buf, 0, 1, false)[1] or ""
      M.state.query = line
      filter()
    end,
  })

  update()

  load_items(items, opts)
end

function M.pick(search, opts, on_choice)
  opts = opts or {}

  M.state = {
    formatted = {},
    results = {},
    selected = 1,
    query = "",
    loading = not opts.live,
    job = nil,
  }

  M.state.prompt_buf, M.state.prompt_win = create_prompt_buf_win(opts.prompt or "", on_choice)
  M.state.items_buf, M.state.items_win = create_items_buf_win()

  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = M.state.prompt_buf,
    callback = function()
      M.state.selected = 1
      local line = vim.api.nvim_buf_get_lines(M.state.prompt_buf, 0, 1, false)[1] or ""
      M.state.query = line

      if opts.live then
        M.state.loading = true
        update()
        kill_job()
        M.state.results = {}
        update()
        search(M.state.query, function(items)
          vim.schedule(function()
            M.state.loading = false
            M.state.results = items
            M.state.selected = math.clamp(M.state.selected, 1, math.max(1, #M.state.results))
            update()
          end)
        end)
      elseif not M.state.loading then
        filter()
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    buffer = M.state.prompt_buf,
    callback = function()
      vim.api.nvim_win_set_width(M.state.prompt_win, vim.o.columns)
      vim.api.nvim_win_set_config(M.state.prompt_win, {
        relative = "editor",
        row = vim.o.lines - HEIGHT,
        col = 0,
      })

      vim.api.nvim_win_set_width(M.state.items_win, vim.o.columns)
      vim.api.nvim_win_set_config(M.state.items_win, {
        relative = "editor",
        row = vim.o.lines - HEIGHT + 1,
        col = 0,
      })
    end,
  })

  if opts.live then
    update()
  else
    search(function(items)
      vim.schedule(function()
        load_items(items, opts)
      end)
    end)
    update()
  end
end

function M.live_grep(cwd)
  M.pick(function(query, on_results)
    if query == "" then
      on_results({})
      return
    end
    M.state.job = vim.system(
      { "rg", "--no-heading", "--line-number", "--column", "--color=never", "--", query },
      { text = true, cwd = cwd or vim.fn.getcwd() },
      function(result)
        vim.schedule(function()
          local items = {}
          for _, line in ipairs(vim.split(result.stdout or "", "\n", { trimempty = true })) do
            local file, lnum, col, text = line:match("^(.+):(%d+):(%d+):(.*)$")
            if file then
              table.insert(items, {
                text = vim.fn.fnamemodify(file, ":.") .. ":" .. lnum .. ": " .. text,
                raw = { file = file, lnum = tonumber(lnum), col = tonumber(col) },
              })
            end
          end
          on_results(items)
        end)
      end
    )
  end, {
    prompt = "grep>",
    live = true,
  }, function(item)
    if item then
      vim.cmd("edit " .. vim.fn.fnameescape(item.file))
      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col })
    end
  end)
end

return M

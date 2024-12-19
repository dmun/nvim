local M = {}

---@param highlights table
function M.set_highlights(highlights)
  for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, v)
  end
end

function M.handle_keymaps(modes)
  for mode, maps in pairs(modes) do
    for _, map in pairs(maps) do
      vim.keymap.set(mode, map[1], map[2], { silent = true, remap = true })
    end
  end
end

function M.deepcopy(o, seen)
  seen = seen or {}
  if o == nil then
    return nil
  end
  if seen[o] then
    return seen[o]
  end

  local no
  if type(o) == "table" then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[M.deepcopy(k, seen)] = M.deepcopy(v, seen)
    end
    setmetatable(no, M.deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

---@param reset boolean?
function M.run_command(reset)
  local project_path = vim.fn.getcwd()
  local data_path = vim.fn.stdpath("data")

  local dir = data_path .. "/localleader-r" .. vim.fs.dirname(project_path)
  local basename = vim.fs.basename(project_path)
  local file = dir .. "/" .. basename .. ".json"

  if vim.loop.fs_stat(dir) == nil then
    vim.fn.mkdir(dir, "p")
  end

  if vim.loop.fs_stat(file) == nil then
    vim.cmd.write(file)
  end

  local fd, err, _ = vim.loop.fs_open(file, "r", 438)
  if err then
    print(err)
    return
  end

  ---@diagnostic disable-next-line: redefined-local
  local fstat, err, _ = vim.loop.fs_fstat(fd)
  if err then
    print(err)
    return
  end

  ---@diagnostic disable-next-line: redefined-local
  local data, err, _ = vim.loop.fs_read(fd, fstat.size, 0)
  if err then
    print(err)
    return
  end

  local command = nil

  if data then
    local ok, decoded = pcall(vim.json.decode, data)
    if not ok then
      print(decoded)
    end
    command = decoded.run
  end

  if command == nil or reset == true then
    vim.ui.input({
      prompt = "choose a run command for '" .. project_path .. "': ",
    }, function(input)
      local encoded = vim.json.encode({
        run = input,
      })

      ---@diagnostic disable-next-line: redefined-local
      local fd, err, _ = vim.loop.fs_open(file, "w", 438)
      if not data then
        print(err)
        return
      end

      vim.loop.fs_write(fd, encoded, 0)

      command = input
    end)
  end

  if not command then
    print("No command specified")
    return
  end

  vim.cmd("split term://" .. command)
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = true })
  vim.cmd.norm("G")
end

function M.run_command_reset()
  M.run_command(true)
end

function M.set_colorscheme()
  local path = vim.fn.stdpath("cache") .. "/colorscheme"
  local fd, err, _ = vim.uv.fs_open(path, "r", 438)

  if not fd then
    error(err)
  end

  local fstat, err, _ = vim.uv.fs_fstat(fd)

  if not fstat then
    error(err)
  end

  local data, err, _ = vim.uv.fs_read(fd, fstat.size, 0)

  if not data then
    error(err)
  end
  vim.cmd.color(data)

  vim.uv.fs_close(fd)
end

return M

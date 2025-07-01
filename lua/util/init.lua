local M = {}

function M.bootstrap()
  local path_package = vim.fn.stdpath("data") .. "/site/"
  local mini_path = path_package .. "pack/deps/start/mini.nvim"
  if not vim.uv.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/echasnovski/mini.nvim",
      mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
  end
end

function M.pcommands()
  local state_dir = vim.fn.stdpath("state")
  local project_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
  local shell = vim.fn.fnamemodify(vim.o.shell, ":t")

  local file = table.concat({
    state_dir,
    "/pcommands/",
    project_dir:sub(2):gsub("[/%.]", "_"),
    ".",
    shell,
  }, "")

  vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
  -- vim.cmd("belowright 5split " .. file)

  local function run_command(insert_output)
    local line = vim.api.nvim_get_current_line()
    if insert_output then
      vim.cmd("read !" .. line)
    else
      vim.cmd("!" .. line)
    end
  end

  local bufnr = vim.api.nvim_create_buf(false, false)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd.edit(file)
  end)

  local height = 12
  local width = 48
  local winnr = vim.api.nvim_open_win(bufnr, true, {
    title = "Commands",
    height = height,
    width = width,
    relative = "editor",
    row = math.floor((vim.o.lines - height) / 3),
    col = math.floor((vim.o.columns - width) / 2),
  })
  local function close()
    vim.api.nvim_win_close(winnr, true)
    vim.api.nvim_buf_delete(bufnr, {})
  end

  vim.keymap.set("n", "q", close, { buffer = bufnr })
  vim.keymap.set("n", "<Esc>", close, { buffer = bufnr })
  vim.keymap.set("n", "<CR>", function()
    run_command(false)
    close()
  end, { buffer = bufnr })
end

return M

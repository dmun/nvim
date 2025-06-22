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
  vim.cmd("belowright 5split " .. file)

  local bufnr = vim.api.nvim_get_current_buf()
  local function run_command(insert_output)
    local line = vim.api.nvim_get_current_line()
    if insert_output then
      vim.cmd("read !" .. line)
    else
      vim.cmd("!" .. line)
    end
  end

  vim.keymap.set("n", "<CR>", function() run_command(false) end, {
    buffer = bufnr,
    desc = "Run current line as shell command"
  })
end

return M

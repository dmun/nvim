local bootstrap = function()
  local path_package = vim.fn.stdpath("data") .. "/site/"
  local mini_path = path_package .. "pack/deps/start/mini.nvim"
  if not vim.uv.fs_stat(mini_path) then
    cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/echasnovski/mini.nvim",
      mini_path,
    }
    vim.fn.system(clone_cmd)
    cmd("packadd mini.nvim | helptags ALL")
    cmd('echo "Installed `mini.nvim`" | redraw')
  end
end

return { bootstrap = bootstrap }

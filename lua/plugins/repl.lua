return {
  "Vigemus/iron.nvim",
  cmd = "IronRepl",
  config = function()
    local iron = require("iron.core")
    local python_format = require("iron.fts.common").bracketed_paste
    local map = vim.keymap.set

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          r = { command = { "R" } },
          sh = { command = { "zsh" } },
          python = {
            command = { "jupyter-console" }, --existing" },
            format = python_format,
          },
        },
        repl_open_cmd = require("iron.view").split(10, {
          winfixwidth = true,
          winfixheight = true,
          number = false,
          relativenumber = false,
        }),
      },
      keymaps = {
        send_motion = "<space>s",
        visual_send = "<cr>",
        send_file = "<space>sr",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      highlight = {
        bold = false,
        italic = false,
      },
      ignore_blank_lines = true,
    })

    map("n", "<CR>", " sic", { remap = true, buffer = true })
    map("n", "<M-b>", "O# %%0j", { remap = true, buffer = true })
    map("n", "<space>rs", vim.cmd.IronRepl)
    map("n", "<space>rr", vim.cmd.IronRestart)
    map("n", "<space>rf", vim.cmd.IronFocus)
    map("n", "<space>rh", vim.cmd.IronHide)
  end,
}

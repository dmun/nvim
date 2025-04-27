return require "lazier" {
  "ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    local map = vim.keymap.set
    local default_winopts = {
      title = false,
      title_pos = "left",
      title_flags = false,
      row = 0,
      col = 0.3,
      height = 0.5,
      width = 1.0,
      backdrop = 100,
      -- split = "botright 10 new",
      border = "single",
      preview = {
        hidden = "hidden",
        vertical = "down:50%",
        title = false,
        title_pos = "left",
        scrollbar = false,
        scrollchars = { "┃", "" },
        border = "single",
      },
    }

    fzf.setup({
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
      "max-perf",
      file_icons = false,
      prompt = "> ",
      defaults = {
        winopts = default_winopts,
        file_icons = false,
        prompt = "> ",
        no_header_i = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
          treesitter = { context = false },
        },
      },
      files = {
        cwd_prompt = false,
        cmd = "rg --files --hidden",
        git_icons = false,
      },
      fzf_opts = {
        ["--info"] = "hidden",
        ["--no-scrollbar"] = true,
      },
      hls = {
        normal = "NormalFloat",
        border = "FloatBorder",
        title = "FloatTitle",
      },
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["hl"] = { "fg", "Normal" },
        ["fg+"] = { "fg", "PmenuSel" },
        ["bg+"] = { "bg", "PmenuSel" },
        ["hl+"] = { "fg", "PmenuSel" },
        ["pointer"] = { "bg", "PmenuSel" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Label" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = "-1",
      },
    })

    map("n", "<leader><leader>", fzf.builtin)
    map("n", "<leader>f", fzf.files)
    -- map("n", "<leader>g", fzf.git_status)
    map("n", "<leader>o", fzf.oldfiles)
    map("n", "<leader>/", fzf.live_grep)
    map("n", "<leader>?", fzf.live_grep_resume)
    map("n", "<leader>,", fzf.buffers)
    map("n", "<C-c>", fzf.lsp_code_actions)
  end,
}

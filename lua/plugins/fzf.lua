local function get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

local default_winopts = {
  title = "Fzf",
  -- title_pos = "center",
  border = "single",
  row = 0.4,
  col = 0.5,
  height = 0.6,
  width = 0.75,
  backdrop = 70,
  preview = {
    border = "single",
    hidden = "nohidden",
    vertical = "down:60%",
    title = false,
    title_pos = "left",
    scrollbar = false,
    scrollchars = { "┃", "" },
  },
}

return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  cmd = "FzfLua",
  keys = {
    { "<leader>f", "<cmd>FzfLua files<cr>" },
    { "<leader>l", "<cmd>FzfLua oldfiles<cr>" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
    { "<leader>?", "<cmd>FzfLua live_grep_resume<cr>" },
    { "<leader>,", "<cmd>FzfLua buffers<cr>" },
    { "<leader>w", "<cmd>FzfLua lsp_document_symbols<cr>" },
    { "<leader><leader>", "<cmd>FzfLua builtin<cr>" },
  },
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "fzf-lua" } })
      require("fzf-lua").register_ui_select(function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " > ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            title = "",
            -- border = "none",
            relative = "cursor",
            row = 1,
            col = 0,
            width = 50,
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = #items + 1,
            -- height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 1) + 0.5),
            preview = not vim.tbl_isempty(get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            },
            on_create = function()
              vim.o.winhl = "Normal:Normal"
            end,
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end)
      return vim.ui.select(...)
    end
  end,
  opts = {
    file_icons = false,
    prompt = "> ",
    winopts = default_winopts,
    defaults = {
      file_icons = false,
      prompt = "> ",
      winopts = default_winopts,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
      },
    },
    files = {
      winopts = { title = "Files" },
      cwd_prompt = false,
      cmd = "rg --files --hidden",
      no_header_i = true,
      git_icons = false,
    },
    oldfiles = {
      include_current_session = true,
      winopts = { title = "Oldfiles" },
    },
    code_actions = {
      winopts = { title = "Code Actions" },
    },
    grep = {
      no_header_i = true,
      winopts = { title = "Grep" },
    },
    buffers = {
      no_header_i = true,
      winopts = { title = "Buffers" },
    },
    fzf_opts = {
      ["--info"] = "hidden",
      ["--no-scrollbar"] = true,
    },
    -- fzf_colors = true,
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      -- ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", "Comment" },
      ["fg+"] = { "fg", "Normal" },
      ["bg+"] = { "bg", "CursorLine" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Label" },
      ["pointer"] = { "bg", "CursorLine" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = "-1",
    },
  },
}

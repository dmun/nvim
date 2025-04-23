local function get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client) return client.supports_method(opts.method, { bufnr = opts.bufnr }) end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

local _single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
local _rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local _border = false and _rounded or _single

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

return {
  "ibhagwan/fzf-lua",
  enabled = true,
  cmd = "FzfLua",
  keys = {
    { "<leader>f", "<cmd>FzfLua files<cr>" },
    { "<leader>g", "<cmd>FzfLua git_status<cr>" },
    { "<leader>o", "<cmd>FzfLua oldfiles<cr>" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
    { "<leader>?", "<cmd>FzfLua live_grep_resume<cr>" },
    { "<leader>,", "<cmd>FzfLua buffers<cr>" },
    -- { "<leader>w", "<cmd>FzfLua lsp_document_symbols<cr>" },
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
            title_pos = "left",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
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
              -- vim.o.winhl = "Normal:Normal"
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
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    "max-perf",
    file_icons = false,
    prompt = "> ",
    winopts = default_winopts,
    defaults = {
      file_icons = false,
      prompt = "> ",
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
        treesitter = { context = false },
      },
    },
    files = {
      winopts = {},
      cwd_prompt = false,
      cmd = "rg --files --hidden",
      no_header_i = true,
      git_icons = false,
    },
    oldfiles = {
      winopts = {},
      include_current_session = true,
    },
    code_actions = {
      winopts = {},
    },
    grep = {
      winopts = {},
      no_header_i = true,
    },
    buffers = {
      winopts = {},
      no_header_i = true,
    },
    builtin = {
      winopts = default_winopts,
      no_header_i = true,
    },
    highlights = {
      winopts = {},
      no_header_i = true,
    },
    fzf_opts = {
      ["--info"] = "hidden",
      ["--no-scrollbar"] = true,
    },
    -- fzf_colors = true,
    hls = {
      normal = "NormalFloat",
      border = "FloatBorder",
      title = "FloatTitle",
    },
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      -- ["bg"] = { "bg", "Normal" },
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
  },
}

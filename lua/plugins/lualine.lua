local colors = require("modus-themes.colors").modus_vivendi
local c = {
  fg = colors.tinted_border,
  fg_bright = colors.tinted_border,
  fg_dim = colors.tinted_bg_inactive,
  bg = colors.tinted_bg_dim,
  bg_dim = "#0A0C17",
}

local theme = {
  normal = {
    a = { bg = c.bg, fg = c.fg, gui = "bold" },
    b = { bg = c.bg, fg = c.fg },
    c = { bg = c.bg, fg = c.fg },
  },
  insert = {
    a = { bg = c.bg, fg = c.fg, gui = "bold" },
    b = { bg = c.bg, fg = c.fg },
    c = { bg = c.bg, fg = c.fg },
  },
  visual = {
    a = { bg = c.bg, fg = c.fg, gui = "bold" },
    b = { bg = c.bg, fg = c.fg },
    c = { bg = c.bg, fg = c.fg },
  },
  replace = {
    a = { bg = c.bg, fg = c.fg, gui = "bold" },
    b = { bg = c.bg, fg = c.fg },
    c = { bg = c.bg, fg = c.fg },
  },
  command = {
    a = { bg = c.bg, fg = c.fg, gui = "bold" },
    b = { bg = c.bg, fg = c.fg },
    c = { bg = c.bg, fg = c.fg },
  },
  inactive = {
    a = { bg = c.bg, fg = c.fg_dim, gui = "bold" },
    b = { bg = c.bg, fg = c.fg_dim },
    c = { bg = c.bg, fg = c.fg_dim },
  },
}

---@param active boolean
---@return table
local function section(active)
  return {
    function()
      return "<<"
    end,
    padding = 0,
    color = { fg = colors.fg_alt },
  }
end

local spacer = function(n)
  return {
    function()
      return string.rep(" ", n)
    end,
    padding = 0,
  }
end

local macro = {
  function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return "Recording @" .. recording_register
    end
  end,
  color = { gui = "bold" },
}

local multicursor = {
  icon = { "󰬸", color = { fg = "#80A4C2" } },
  function()
    local n = require("multicursor-nvim").numCursors()
    return n > 1 and n or ""
  end,
  color = { gui = "bold" },
}

local mode = {
  function()
    local map = {
      n = "NOR",
      i = "INS",
      v = "SEL",
      V = "LIN",
      [""] = "BLK",
      c = "CMD",
      R = "REP",
      s = "SEL",
      S = "LIN",
      [""] = "BLK",
      t = "TER",
    }
    return map[vim.fn.mode()]
  end,
  _color = { fg = c.fg_bright },
}

---@param active boolean
---@return table
local function project(active)
  return {
    function()
      local path = vim.fn.getcwd()
      local text = "" .. vim.fs.basename(path) .. ""

      if not active then
        return string.rep(" ", #text)
      else
        return text
      end
    end,
    color = {
      fg = c.fg_dim,
      bg = active and theme.normal.c.bg or theme.inactive.c.bg,
      gui = "bold",
    },
  }
end

---@param active boolean
---@return table
local function filename(active)
  local fts = {
    help = "Neovim Documentation",
    trouble = "Trouble",
    fzf = "Fzf",
    oil = "Oil",
    terminal = "Terminal",
  }
  local ft_keys = vim.tbl_keys(fts)

  return {
    function()
      local ft = vim.bo.filetype
      local bt = vim.bo.buftype
      local path = vim.fn.expand("%:.")
      if #path > 50 then
        path = vim.fn.pathshorten(path)
      end

      if vim.tbl_contains(ft_keys, ft) then
        return fts[ft]
      elseif vim.tbl_contains(ft_keys, bt) then
        return fts[bt]
      end

      return path .. " "
    end,
    color = function()
      local gui = ""

      if vim.bo.modified then
        gui = "italic"
      end

      return {
        -- fg = active and c.fg or c.dim,
        gui = gui,
      }
    end,
  }
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "powerline",
      component_separators = { left = nil, right = nil },
      section_separators = { left = nil, right = nil },
      always_divide_middle = false,
      disabled_filetypes = {
        statusline = {
          -- "fzf",
          -- "noice",
          "fugitive",
          "copilot-chat",
          "copilot-diff",
          "copilot-overlay",
        },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = { filename(true) },
      lualine_x = {
        "diagnostics",
        multicursor,
        macro,
        -- "location",
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = { spacer(8) },
      lualine_b = {},
      lualine_c = { filename(false) },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}

local colors = require("modus-themes.colors").modus_vivendi

local theme = {
  normal = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.blue },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
  },
  insert = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.green },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
  },
  visual = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.red },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
  },
  replace = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.tinted_bg_dim },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
  },
  command = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.red },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
  },
  inactive = {
    a = { bg = colors.tinted_bg_dim, fg = colors.fg_dim, gui = "bold" },
    b = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
    c = { bg = colors.tinted_bg_dim, fg = colors.fg_dim },
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
    return "▍"
  end,
  padding = 0,
  -- color = { gui = "reverse" },
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
    color = { fg = colors.fg_main, bg = colors.tinted_bg_dim, gui = "bold" },
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

      return path
    end,
    color = function()
      -- local ft = vim.bo.filetype
      -- local bt = vim.bo.buftype

      local fg = colors.fg2
      local gui = ""

      -- if vim.bo.modifiable == false then
      -- 	fg = "#777777"
      -- end

      -- if vim.tbl_contains(ft_keys, ft) or vim.tbl_contains(ft_keys, bt) then
      -- 	fg = colors.purple
      -- 	gui = "bold"
      -- end

      if vim.bo.modified then
        gui = "italic"
      end

      return {
        -- fg = active and fg or colors.fg_alt,
        -- bg = active and colors.bg or colors.bg_alt,
        gui = gui,
      }
    end,
  }
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = theme,
      component_separators = { left = nil, right = nil },
      section_separators = { left = nil, right = nil },
      always_divide_middle = false,
      disabled_filetypes = {
        statusline = {
          -- "fzf",
          -- "noice",
          "fugitive",
          -- "terminal",
        },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = { mode },
      lualine_c = { project(true), filename(true) },
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
      lualine_a = {},
      lualine_b = { mode },
      lualine_c = { project(false), filename(false) },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}

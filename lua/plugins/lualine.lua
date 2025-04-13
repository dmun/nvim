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
      return "@" .. recording_register
    end
  end,
  color = { gui = "bold" },
}

local multicursor = {
  icon = { "", color = { fg = "#80A4C2" } },
  function()
    local n = require("multicursor-nvim").numCursors()
    return n > 1 and n or ""
  end,
  color = { gui = "bold" },
}

---@param active boolean
---@return table
local function filename(active)
  local fts = {
    help = "Neovim Documentation",
    -- trouble = "Trouble",
    fzf = "Fzf",
    oil = "Oil",
    terminal = "Terminal",
    sql = "SQL",
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
        path = fts[ft]
      elseif vim.tbl_contains(ft_keys, bt) then
        path = fts[bt]
      elseif path == "" then
        path = "*scratch*"
      end

      return path
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
      theme = "jellybeans",
      component_separators = { left = nil, right = nil },
      section_separators = { left = nil, right = nil },
      always_divide_middle = false,
      disabled_filetypes = {
        statusline = {
          -- "fzf",
          -- "trouble",
          -- "fugitive",
          -- "copilot-chat",
          -- "copilot-diff",
          -- "copilot-overlay",
        },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        filename(true),
        "diff",
      },
      lualine_x = {
        -- "diagnostics",
        -- macro,
        -- multicursor,
        -- "location",
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename(false) },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}

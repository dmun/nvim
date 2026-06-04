local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local g = augroup("user/keep_yank_position", { clear = true })

autocmd("ModeChanged", {
  pattern = { "n:no", "no:n" },
  group = g,
  callback = function(ev)
    if vim.v.operator == "y" then
      if ev.match == "n:no" then
        vim.b.user_yank_last_pos = vim.fn.getpos(".")
      else
        if vim.b.user_yank_last_pos then
          vim.fn.setpos(".", vim.b.user_yank_last_pos)
          vim.b.user_yank_last_pos = nil
        end
      end
    end
  end,
})

autocmd("ModeChanged", {
  pattern = {
    "V:n",
    "n:V",
    "v:n",
    "n:v",
  },
  group = g,
  callback = function(ev)
    local match = ev.match
    if vim.tbl_contains({ "n:V", "n:v" }, match) then
      -- vim.b.user_yank_last_pos = vim.fn.getpos(".")
      vim.b.user_yank_last_pos = vim.api.nvim_win_get_cursor(0)
    else
      -- if vim.tbl_contains({ "V:n", "v:n" }, match) then
      if vim.v.operator == "y" then
        local last_pos = vim.b.user_yank_last_pos
        if last_pos then
          -- vim.fn.setpos(".", last_pos)
          vim.api.nvim_win_set_cursor(0, last_pos)
        end
      end
      vim.b.user_yank_last_pos = nil
      -- end
    end
  end,
})

-- vim.keymap.set('n', 'p', 'mzp`zj')
-- vim.keymap.set('n', 'P', 'mzP`zk')
-- vim.cmd([[nnoremap <expr> p 'p' . virtcol('.') . '|']])

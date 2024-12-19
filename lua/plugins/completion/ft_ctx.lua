local M = {}

M.lua = {
  ---@param ctx blink.cmp.DrawItemContext
  fix_label = function(ctx)
    local s = vim.split(ctx.label, "%(")
    if not vim.tbl_isempty(s) then
      ctx.label = s[1]
      ctx.label_detail = "(" .. s[2]
    end
  end,
}

M.rust = {
  ---@param ctx blink.cmp.DrawItemContext
  _fix_label = function(ctx)
    if ctx.label_detail then
      local s = vim.split(ctx.label_description, " -> ")
      if s then
        ctx.label = ctx.label:gsub("%(.*", "")
        ctx.label_description = ctx.label_detail
        ctx.label_detail = s[1]:match("%(.*%)") or "()"
      end
    end
  end,
}

M.go = {
  ---@param ctx blink.cmp.DrawItemContext
  fix_label = function(ctx)
    if ctx.item and ctx.item.detail then
      ctx.label_detail = ctx.item.detail:sub(5)
    end
  end,
}

return M

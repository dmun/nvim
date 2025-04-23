--- @class AuGroup
--- @field private _group string
local AuGroupMetatable = {}

AuGroupMetatable.__index = AuGroupMetatable

--- @class CallbackOpts
--- @field id number
--- @field event string
--- @field group number|nil
--- @field file string
--- @field match string
--- @field buf number
--- @field data any

--- @class AutoCommandOpts
--- @field event string | string[]
--- @field callback fun(ev: CallbackOpts)
--- @field pattern? string

--- @param opts AutoCommandOpts
--- @return self
function AuGroupMetatable:au(opts)
  vim.api.nvim_create_autocmd(opts.event, {
    group = self._group,
    pattern = opts.pattern or "*",
    callback = opts.callback,
  })
  return self
end

--- @param name string
--- @return AuGroup
function AuGroup(name)
  vim.api.nvim_create_augroup(name, { clear = true })
  return setmetatable({
    _group = name,
  }, AuGroupMetatable)
end

return AuGroup

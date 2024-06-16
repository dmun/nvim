---@class Plug
_G.Plug = {specs = {}}

local eventMt = {
	__add = function (lhs, rhs)
		return { lhs[1], rhs[1] }
	end
}

---@enum Event
Event = {
	VeryLazy = setmetatable({ 1 }, eventMt),
	BufReadPre = setmetatable({ 2 }, eventMt),
	BufNewFile = setmetatable({ 3 }, eventMt),
	InsertEnter = setmetatable({ 4 }, eventMt),
	CmdLineEnter = setmetatable({ 5 }, eventMt),
	[1] = "VeryLazy",
	[2] = "BufReadPre",
	[3] = "BufNewFile",
	[4] = "InsertEnter",
	[5] = "CmdLineEnter",
}

setmetatable(Plug, {
	__call = function(_, uri)
		local index = #Plug.specs+1
		Plug.specs[index] = { uri }
		return setmetatable(Plug.specs[index], {
			__index = Plug,
			__call = function(self, opts)
				self:opts(opts)
				return self
			end
		})
	end
})

---@param event Event|table
function Plug:on(event)
	local events = {}
	if type(event) == "number" then
		self.event = Event[event]
	elseif type(event) == "table" then
		for _, x in pairs(event) do
			table.insert(events, Event[x])
		end
		self.event = events
	end
	return self
end

---@param name string
function Plug:name(name)
	self.name = name
	return self
end

---@param opts table
function Plug:opts(opts)
	self.opts = opts or {}
	return self
end

---@param keys table
function Plug:keys(keys)
	self.keys = keys
	return self
end

---@param cmd string
function Plug:cmd(cmd)
	self.cmd = cmd
	return self
end

---@param config function
function Plug:config(config)
	self.config = config
	return self
end

---@param setup function
function Plug:setup(setup)
	self:config(function (_, opts)
		setup(opts)
	end)
	return self
end

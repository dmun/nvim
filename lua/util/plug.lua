---@class Plug
---@operator call(table): Plug
local M = {specs={}}

local eventMt = {
	__add = function (lhs, rhs)
		return { lhs[1], rhs[1] }
	end
}

---@enum Event
Event = {
	VeryLazy = 1,
	BufReadPre = 2,
	BufNewFile = 3,
	InsertEnter = 4,
	CmdLineEnter = 5,
	BufWritePost = 6,
	BufRead = 7,
	BufWritePre = 8,
	[1] = "VeryLazy",
	[2] = "BufReadPre",
	[3] = "BufNewFile",
	[4] = "InsertEnter",
	[5] = "CmdLineEnter",
	[6] = "BufWritePost",
	[7] = "BufRead",
	[8] = "BufWritePre",
}

---@vararg Event|string
function M:on(...)
	self.events = self.events or {}
	for _, event in pairs(arg) do
		if type(event) == "number" then
			table.insert(self.events, Event[event])
		else
			table.insert(self.events, event)
		end
	end
	return self
end

---@param name string
function M:name(name)
	self.name = name
	return self
end

---@param opts? table
function M:opts(opts)
	self.opts = opts or {}
	return self
end

---@param keys table
function M:keys(keys)
	self.keys = keys
	return self
end

---@param cmd string
function M:cmd(cmd)
	self.cmd = cmd
	return self
end

---@param config function
function M:config(config)
	self.config = config
	return self
end

---@param name string
function M:setup(name)
	self.config = function (_, opts)
		require(name).setup(opts)
	end
	return self
end

---@param dir string
function M.dir(_, dir)
	local index = #M.specs+1
	M.specs[index] = { dir = dir }
	return setmetatable(M.specs[index], {
		__index = M,
		__call = function(self, opts)
			return self:opts(opts)
		end
	})
end

---@param build string|function
function M:build(build)
	self.build = build
	return self
end

---@param version string
function M:version(version)
	self.version = version
	return self
end

---@param dependencies string|table
function M:dependencies(dependencies)
	self.dependencies = dependencies
	return self
end

---@param enabled? boolean
function M:enabled(enabled)
	self.enabled = enabled ~= false
	return self
end

function M:disabled()
	return self:enabled(false)
end

---@param ft string
function M:ft(ft)
	self.ft = ft
	return self
end


return setmetatable(M, {
	__call = function(_, uri)
		local index = #M.specs+1
		M.specs[index] = { uri }
		return setmetatable(M.specs[index], {
			__index = M,
			__call = function(self, opts)
				return self:opts(opts)
			end
		})
	end
})

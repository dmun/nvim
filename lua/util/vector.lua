---@class Vector
local Vector = {}

---@param lhs Vector
---@param rhs Vector
---@return Vector
Vector.__add = function(lhs, rhs)
	return Vector:new(lhs[1] + rhs[1], lhs[2] + rhs[2])
end

---@param lhs Vector
---@param rhs Vector
---@return Vector
Vector.__sub = function(lhs, rhs)
	return Vector:new(lhs[1] - rhs[1], lhs[2] - rhs[2])
end

---@param lhs Vector|number
---@param rhs Vector|number
---@return Vector
Vector.__mul = function(lhs, rhs)
	local l = type(lhs) == "number" and lhs or nil
	local r = type(rhs) == "number" and rhs or nil
	return Vector:new((l or lhs[1]) * (r or rhs[1]), (l or lhs[2]) * (r or rhs[2]))
end

---@param ... number
---@return Vector
function Vector:new(...)
	local obj = { ... }
	setmetatable(obj, self)
	self.__index = self
	return obj
end

---@param p1 Vector
---@param p2 Vector
---@param t number
---@return Vector
function Vector.lerp(p1, p2, t)
	return (1 - t) * p1 + t * p2
end

---@param p1 Vector
---@param p2 Vector
---@param p3 Vector
---@param t number
---@return Vector
function Vector.quadratic_bezier(p1, p2, p3, t)
	local l1 = Vector.lerp(p1, p2, t)
	local l2 = Vector.lerp(p2, p3, t)
	return Vector.lerp(l1, l2, t)
end

---@param p1 Vector
---@param p2 Vector
---@param p3 Vector
---@param p4 Vector
---@param t number
---@return Vector
function Vector.cubic_bezier(p1, p2, p3, p4, t)
	local q1 = Vector.quadratic_bezier(p1, p2, p3, t)
	local q2 = Vector.quadratic_bezier(p2, p3, p4, t)
	return Vector.lerp(q1, q2, t)
end

return setmetatable(Vector, {
	---@param self Vector
	---@param ... number
	---@return Vector
	__call = function (self, ...)
		return self:new(...)
	end
})

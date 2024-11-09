local calc_module = {}
---@param x number
---@param y number
---@return number
calc_module.add = function(x, y)
    return x + y
end

---@param x number
---@param y number
---@return number
calc_module.sub = function(x, y)
    return x - y
end

---@param x number
---@param y number
---@return number
calc_module.mul = function(x, y)
    return x * y
end

---@param x number
---@param y number
---@return number
calc_module.div = function(x, y)
    return x / y
end
return calc_module

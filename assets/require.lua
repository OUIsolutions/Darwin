---@class PrivateDarwinModule
---@field item string
---@field callback_import fun():any

---@type PrivateDarwinModule[]
Private_darwin_modules = Private_darwin_modules
Private_darwin_old_require = require

---@param item string
---@return any
function require(item)
    for i = 1, #Private_darwin_modules do
        local current = Private_darwin_modules[i]
        if current.item == item then
            return current.callback_import()
        end
    end
    return Private_darwin_old_require(item)
end

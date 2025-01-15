---@class PrivateDarwinModule
---@field item string
---@field callback_import fun():any


Private_darwin_old_require = require


---@param item string
---@return any
function require(item)

    for i =1,#REQUIRE_SO do
        local current = REQUIRE_SO[i]
        if current.item == item then
            return 
        end
    end

    for i = 1, #REQUIRE_FUNCS do
        local current = REQUIRE_FUNCS[i]
        
        if current.comptime_include == item then
            if current.loaded_obj then
                return current.loaded_obj
            end
            current.loaded_obj = current.content()            
            return current.loaded_obj
        end
    end
    return Private_darwin_old_require(item)
end

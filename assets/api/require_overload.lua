

Private_darwin_old_require = require
if not Private_darwin_old_package then
    Private_darwin_old_package = package.loadlib
end



function require(item)
    for i =1,#REQUIRE_SO do
        
        local current = REQUIRE_SO[i]
        if current.comptime_included == item then
            if current.loaded_obj then
                return current.loaded_obj
            end
            local dest = PRIVATE_DARWIN_SO_DEST.."/"..i..".so"
            current.loaded_obj =  Private_darwin_old_package(dest,"luaopen_"..current.comptime_included)
            if not current.loaded_obj then
                error("impossible to load "..dest)
            end
            current.loaded_obj = current.loaded_obj()
            return current.loaded_obj
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


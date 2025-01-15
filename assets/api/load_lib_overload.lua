

Private_darwin_old_package = package.loadlib

package.loadlib = function (item, funcname)
  
    for i =1,#REQUIRE_SO do
        local current = REQUIRE_SO[i]
        if current.comptime_included == item then
            if current.loaded_obj then
                return current.loaded_obj
            end
            local dest = PRIVATE_DARWIN_SO_DEST.."/"..i..".so"
            current.loaded_obj =  Private_darwin_old_package(dest,funcname)
            if not current.loaded_obj then
                error("impossible to load "..dest)
            end
            current.loaded_obj = current.loaded_obj()
            return current.loaded_obj
        end
    end
    return Private_darwin_old_package(item, funcname)
end



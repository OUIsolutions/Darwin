---@type string
Private_darwin_shared_dir = Private_darwin_shared_dir


---@type PrivateDarwinSHaredLib[]
Private_darwin_shared_libs = Private_darwin_shared_libs
os.execute("mkdir -p " .. Private_darwin_shared_dir)
for i = 1, #Private_darwin_shared_libs do
    local current = Private_darwin_shared_libs[i]
    local file = io.open(Private_darwin_shared_dir .. "/" .. current.sha_item .. ".so", "wb")
    file:write(current.content)
    file:close()
end


local PrivateDarwin_old_load_lib = package.loadlib

package.loadlib = function(filename, function_name)
    for i = 1, #Private_darwin_shared_libs do
        local current = Private_darwin_shared_libs[i]
        if current.filename == filename then
            return PrivateDarwin_old_load_lib(
                Private_darwin_shared_dir .. "/" .. current.sha_item .. '.so',
                function_name
            )
        end
    end
    return PrivateDarwin_old_load_lib(filename, function_name)
end

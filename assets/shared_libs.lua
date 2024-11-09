---@type string
Private_darwin_shared_dir = Private_darwin_shared_dir
---@type PrivateDarwinSHaredLib[]
Private_darwin_shared_libs = Private_darwin_shared_libs
os.execute("mkdir -p " .. Private_darwin_shared_dir)
for i = 1, #Private_darwin_shared_libs do
    local current = Private_darwin_shared_libs[i]
    local file = io.open(Private_darwin_shared_dir .. "/" .. current.item, "wb")
    file:write(current.content)
    file:close()
end
function PrivateDarwin_get_shared_lib_path(item)
    return Private_darwin_shared_dir .. "/" .. item
end

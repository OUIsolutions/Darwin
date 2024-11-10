---@type string
Private_darwin_shared_dir = Private_darwin_shared_dir

---@type string
Private_darwin_comptime_dir = Private_darwin_comptime_dir

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
---@param filename string
---@return string
function Private_darwin_extract_file(filename)
    local reversed = filename:reverse()
    local division = reversed:find("/")
    if not division then
        return reversed:reverse()
    end
    reversed = reversed:sub(1, division - 1)
    return reversed:reverse()
end

package.loadlib = function(filename, function_name)
    ---these trys to guess the if the file beeing imported
    ---its the same at the moment that were imported
    local possible_import_at_moment = Private_darwin_comptime_dir .. Private_darwin_extract_file(filename)
    for i = 1, #Private_darwin_shared_libs do
        local current = Private_darwin_shared_libs[i]

        if current.filename == filename or current.filename == possible_import_at_moment then
            return PrivateDarwin_old_load_lib(
                Private_darwin_shared_dir .. "/" .. current.sha_item .. '.so',
                function_name
            )
        end
    end
    return PrivateDarwin_old_load_lib(filename, function_name)
end

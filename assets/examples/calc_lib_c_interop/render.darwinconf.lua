darwin.add_lua_file("types.lua")
darwin.add_lua_code("private_{private_darwin.project_name} =  {private_darwin.OPEN}{private_darwin.CLOSE}")
darwin.add_lua_code("{private_darwin.project_name} = {private_darwin.OPEN}{private_darwin.CLOSE}")

local concat_path = true
local src_files = dtw.list_files_recursively("src", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end


darwin.c_include("cinterop/main_lib.c")
darwin.load_lualib_from_c(
    "luaopen_private_{private_darwin.project_name}_cinterop",
    "private_{private_darwin.project_name}_cinterop"
)
local include_lua_cembed = false
darwin.generate_c_lib_output(
    "{private_darwin.project_name}",
    "{private_darwin.project_name}",
    "{private_darwin.project_name}.c",
    include_lua_cembed
)
os.execute(" gcc -Wall -shared -fpic -o {private_darwin.project_name}.so  {private_darwin.project_name}.c")

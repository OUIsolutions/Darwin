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
darwin.add_lua_code("return {private_darwin.project_name}")

darwin.generate_lua_output({private_darwin.OPEN}
    output_name = "{private_darwin.project_name}.lua"
{private_darwin.CLOSE})

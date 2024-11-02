local concat_path = true
local src_files = dtw.list_files_recursively("src", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end
darwin.generate_c_executable_output("calc.c")
darwin.generate_lua_output("debug.lua")
os.execute("gcc calc.c -o calc.o")

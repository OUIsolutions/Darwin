darwin.embed_global("help", dtw.load_file("help.txt"))
local concat_path = true
local src_files = dtw.list_files_recursively("src", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end
darwin.add_lua_code("main()") -- these its required to start main

darwin.c_include("cinterop/main_lib.c")
darwin.load_lualib_from_c("luaopen_cinterop", "cinterop")
darwin.generate_c_executable_output({
    output_name = "{private_darwin.project_name}.c",
    include_lua_cembed = false
})

darwin.generate_lua_output({
    output_name = "{private_darwin.project_name}.lua"
})
os.execute("gcc {private_darwin.project_name}.c -o {private_darwin.project_name}.o")

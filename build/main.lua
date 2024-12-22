require("build/algo")
require("build/types")
require("build/assets")
require("build/embed_c")

local function main()
    Embed_c_code()
    Create_api_assets()
    darwin.add_lua_code("darwin = {dtw=private_dtw,candango=private_darwin_candango}")
    darwin.add_lua_code("private_darwin = {}")
    darwin.add_lua_code("private_darwin_project = {}")
    local src_files = dtw.list_files_recursively("src", true)
    for i = 1, #src_files do
        local current = src_files[i]
        darwin.add_lua_code("-- file " .. current)
        darwin.add_lua_file(current)
    end


    darwin.add_lua_code("private_darwin.main()")
    darwin.generate_lua_output({ output_name = "debug.lua" })
    darwin.generate_c_executable_output({ output_name = "release/darwin.c" })


    if is_arg_present("build_windows") then
        os.execute("i686-w64-mingw32-gcc  --static release/darwin.c -o  release/darwin.exe")
    end

    if is_arg_present("build_linux") then
        os.execute("gcc --static  release/darwin.c -o  release/darwin.out")
    end
    if is_arg_present("debug") then
        os.execute("gcc release/darwin.c -o  release/debug.out")
    end
end
main()

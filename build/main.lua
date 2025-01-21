require("build/algo")
require("build/types")
require("build/assets")
require("build/embed_c")
require("dependencies")

local function main()
    if is_arg_present("install_dependencies") then
        Install_all_dependencies()
    end

    if is_arg_present("create_images") then
        os.execute("docker build -t darwin_windows_build -f windows.Dockerfile .")
        os.execute("docker build -t darwin_linux_build -f linux.Dockerfile .")
    end

    if is_arg_present("build_code") then
        Embed_c_code()
        Create_api_assets()
        Embed_types()

        darwin.add_lua_code("darwin = {}")
        darwin.add_lua_code("darwin.dtw=private_darwin_dtw")
        darwin.add_lua_code("darwin.candango=private_darwin_candango")
        darwin.add_lua_code("darwin.candango=private_darwin_candango")
        darwin.add_lua_code("darwin.camalgamator=private_darwin_camalgamator")
        darwin.add_lua_code("darwin.silverchain = private_darwin_silverchain")

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
    end


    if is_arg_present("build_windows_from_docer") then
        os.execute("docker run  --volume $(pwd)/:/project:z  darwin_windows_build ")
    end
    if is_arg_present("build_windows") then
        os.execute("i686-w64-mingw32-gcc  --static release/darwin.c -o  release/darwin.exe")
    end

    if is_arg_present("build_linux_from_docker") then
        os.execute("docker run  --volume $(pwd)/:/project:z  darwin_linux_build")
    end


    if is_arg_present("build_linux") then
        os.execute("gcc --static  release/darwin.c -o  release/darwin.out")
    end
    if is_arg_present("debug") then
        os.execute("gcc release/darwin.c -o  release/debug.out")
    end
end
main()

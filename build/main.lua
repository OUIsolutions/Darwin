require("build/algo")
require("build/types")
require("build/assets")
require("build/embed_c")
require("build/dependencies")

local function main()

    if  darwin.argv.one_of_args_exist("install_dependencies") then
        Install_all_dependencies()
    end

    if  darwin.argv.one_of_args_exist("create_images") then
        os.execute("docker build -t darwin_windows_build -f  images/windows.Dockerfile .")
        os.execute("docker build -t darwin_linux_build -f images/linux.Dockerfile .")
    end

    if  darwin.argv.one_of_args_exist("build_linux") or is_arg_present("build_windows") then
        local project = darwin.create_project("darwin")
        Embed_c_code(project)
        Create_api_assets(project)
        Embed_types(project)


        project.add_lua_code("darwin = {}")
        if is_arg_present("build_linux") then
            project.add_lua_code("darwin.os = 'linux'")
        end
        if is_arg_present("build_windows") then
            project.add_lua_code("darwin.os = 'windows'")
        end
        project.add_lua_code("darwin.dtw=private_darwin_dtw")
        project.add_lua_code("darwin.json=private_darwin_json")
        project.add_lua_code("darwin.candango=private_darwin_candango")
        project.add_lua_code("darwin.camalgamator=private_darwin_camalgamator")
        project.add_lua_code("darwin.silverchain = private_darwin_silverchain")
        local lua_argv_content = darwin.dtw.load_file("dependencies/luargv.lua")
        project.add_lua_code(string.format(
            "darwin.argv = function()\n %s\n end \n",
            lua_argv_content
        ))
        project.add_lua_code("darwin.argv = darwin.argv()")


        project.add_lua_code("private_darwin = {}")

        project.add_lua_code("private_darwin_project = {}")
        local src_files = darwin.dtw.list_files_recursively("src", true)
        for i = 1, #src_files do
            local current = src_files[i]
            project.add_lua_code("-- file " .. current)
            project.add_lua_file(current)
        end


        project.add_lua_code("private_darwin.main()")
        project.generate_lua_output({ output_name = "debug.lua" })
        project.generate_c_executable_output({ output_name = "release/darwin.c", include_lua_cembed = false })
    end


    if  darwin.argv.one_of_args_exist("build_windows_from_docker") then
        os.execute("docker run  --volume $(pwd)/:/project:z  darwin_windows_build ")
    end
    if  darwin.argv.one_of_args_exist("build_windows") then
        os.execute("i686-w64-mingw32-gcc  --static release/darwin.c -o  release/darwin.exe")
    end

    if  darwin.argv.one_of_args_exist("build_linux_from_docker") then
        os.execute("docker run  --volume $(pwd)/:/project:z  darwin_linux_build")
    end


    if  darwin.argv.one_of_args_exist("build_linux") then
        os.execute("gcc --static  release/darwin.c -o  release/darwin.out")
    end
    if  darwin.argv.one_of_args_exist("debug") then
        os.execute("gcc release/darwin.c -o  release/debug.out")
    end
end
main()

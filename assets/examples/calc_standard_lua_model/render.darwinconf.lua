darwin.embed_global("help", dtw.load_file("help.txt"))
darwin.unsafe_add_lua_code_following_require("src/main.lua")
darwin.add_lua_code("main()")
darwin.generate_c_executable_output({private_darwin.OPEN}
    output_name = "{private_darwin.project_name}.c"
{private_darwin.CLOSE})

darwin.generate_lua_output({private_darwin.OPEN}
    output_name = "{private_darwin.project_name}.lua"
{private_darwin.CLOSE})
os.execute("gcc {private_darwin.project_name}.c -o {private_darwin.project_name}.o")

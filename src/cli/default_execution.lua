
local function get_default_output_mode(output)
    local extension = darwin.dtw.newPath(output).get_extension()
    
    if extension == "lua" then
        return "lua"
    end

    if extension == "c" then
        return "c"
    end
    if extension == "o" or extension == "out"then
        return "linux_bin"
    end 
    if extension == "exe" then
        return "windows_bin"
    end
    if extension == "so" then
        return "linux_so"
    end
    if extension == "dll" then
        return "windows_dll"
    end


end 

function Default_execution()
    local output = darwin.argv.get_flag_arg_by_index({"o", "output"}, 1)
    local output_mode = darwin.argv.get_flag_arg_by_index(
        {"mode", "output_mode"},
         1, 
         get_default_output_mode(output)
    )
    local main_file = darwin.argv.get_next_unused()
    if not main_file then
        private_darwin.print_red("file not passed")
        return
    end

    if not darwin.dtw.isfile(main_file) then
        private_darwin.print_red("file not found")
        return
    end
    if output_mode == "lua" then
        create_lua_project(main_file, output, output_mode)
        return 
    end 

    


end

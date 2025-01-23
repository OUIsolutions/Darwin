
local valid_out_modes = {
    lua= {"lua"},
    executable_source= {"c"},
    lib_source={},
    linux_bin={"o", "out"},
    windows_bin={"exe"},
    linux_so={"so"},
    windows_dll={"dll"}
}

local function get_default_output_mode(output)
    local extension = darwin.dtw.newPath(output).get_extension()
    for key,val in pairs(valid_out_modes) do
   
        for i=1,#val do
            if val[i] == extension then
                return key
            end
        end
    end
    return nil

end 

function output_mode_its_valid(output_mode)
    for key,_ in pairs(valid_out_modes) do
        if key == output_mode then
            return true
        end
    end
    return false
end

function Default_execution()
    local output = darwin.argv.get_flag_arg_by_index({"o", "output"}, 1)
    local output_mode = darwin.argv.get_flag_arg_by_index(
        {"mode", "output_mode"},
         1, 
         get_default_output_mode(output)
    )
    if not output_mode then
        private_darwin.print_red("output impossible to determine")
        return
    end
    if not output_mode_its_valid(output_mode) then
        private_darwin.print_red("output mode not valid")
        return
    end
    

    local main_file = darwin.argv.get_next_unused()
    if not main_file then
        private_darwin.print_red("file not passed")
        return
    end

    if not darwin.dtw.isfile(main_file) then
        private_darwin.print_red("file not found")
        return
    end

    local default_name = darwin.dtw.newPath(output).get_only_name()
    local project_name = darwin.argv.get_flag_arg_by_index({"name"}, 1, default_name)

    local project = darwin.create_project(project_name)
    local relative_path = darwin.argv.get_flag_arg_by_index({"relative_path"}, 1)
    project.add_lua_file_following_require(main_file,relative_path)

    get_embed_vars(project)

    if output_mode == "lua" then
        create_lua_project(project,output, output_mode)
        return 
    end 
    if output_mode == "linux_bin" or output_mode == "windows_bin" then
        create_executable_bin_project( project,output, output_mode)
        return
    end
    if output_mode == "executable_source" then
        create_executable_c_project(project,output, output_mode)
        return
    end
    if output_mode == "lib_source" then
        create_lib_source_project(project,output, output_mode)
        return
    end
    if output_mode == "linux_so" or output_mode == "windows_dll" then
        create_dynamic_link_lib_project( project,output, output_mode)
        return
    end


    


end

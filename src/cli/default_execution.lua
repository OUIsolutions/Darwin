
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
    if not output_mode then
        return false
    end
    for key,_ in pairs(valid_out_modes) do
        if key == output_mode then
            return true
        end
    end
    return false
end

function Default_execution()
    
    local output = darwin.argv.get_flag_arg_by_index_consider_only_first({"o", "output"},1)
    
    if not output then
        private_darwin.print_red("output not found")
        return
    end
    local output_mode = darwin.argv.get_flag_arg_by_index_consider_only_first(
        {"mode", "output_mode"},
         1, 
         get_default_output_mode(output)
    )
    

    if not output_mode_its_valid(output_mode) then
        private_darwin.print_red("output mode not valid")
        return
    end

    local default_name = darwin.dtw.newPath(output).get_only_name()
    local project_name = darwin.argv.get_flag_arg_by_index_consider_only_first({"name"}, 1,default_name)

    local project = darwin.create_project(project_name)

    local ok =get_embed_vars(project)
    if not ok then
        return
    end
    local cinclude_size  = darwin.argv.get_flag_size_consider_only_first({"cinclude"}, 1)
    
    for i=1,cinclude_size do
        local cinclude = darwin.argv.get_flag_arg_by_index_consider_only_first({"cinclude"}, i)
        project:add_cinclude(cinclude)
    end
    
    local c_call_size  = darwin.argv.get_flag_size_consider_only_first({"c_call"}, 1)
    for i=1,c_call_size do
        local c_call = darwin.argv.get_flag_arg_by_index_consider_only_first({"c_call"}, i)
        project:add_c_call(c_call)
    end
    
    local c_amalgamate_size = darwin.argv.get_flag_size_consider_only_first({"c_amalgamate"}, 1)
    for i=1,c_amalgamate_size do
        local c_amalgamate = darwin.argv.get_flag_arg_by_index_consider_only_first({"c_amalgamate"}, i)
        project:add_c_file(c_amalgamate, true)
    end

    local lib_objects_size = darwin.argv.get_flag_arg_by_index_consider_only_first({"lib_objects"}, 1)
    for i=1,lib_objects_size do
        local lib_object = darwin.argv.get_flag_arg_by_index_consider_only_first({"lib_objects"}, i)
        local func_name_flag lib_object..":func"
        local func_name = darwin.argv.get_flag_arg_by_index_consider_only_first({func_name_flag}, 1)
        project:load_lib_from_c(func_name, lib_object)
    end


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

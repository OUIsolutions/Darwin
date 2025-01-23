
function create_lib_source_project(project,output, output_mode)

    local object_export = darwin.argv.get_flag_arg_by_index({"object_export"}, 1)
    if not object_export then
        private_darwin.print_red("Error: object_export is required")
        return 
    end
    
    if not handle_main_file() then
        return
    end
    
    
    if not handle_unused() then
        return
    end



    project.generate_c_lib_file({
        output = output,
        object_export = object_export
    })
    
end
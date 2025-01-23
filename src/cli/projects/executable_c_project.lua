
function create_executable_c_project(project, output, output_mode)


    if not handle_main_file(project) then
        return
    end
    
    
    if not handle_unused() then
        return
    end
    
    project.generate_c_file({
        output = output,
        include_embed_data = true
    })

end
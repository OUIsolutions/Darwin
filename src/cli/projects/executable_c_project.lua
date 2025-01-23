
function create_executable_c_project(entry, output, output_mode)


    project.generate_c_file({
        output = output,
        include_embed_data = true
    })

end
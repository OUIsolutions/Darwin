
function create_lib_source_project(entry, output, output_mode)


    local default_name = dtw.path.newPath(output).get_only_name()
    local project_name = darwin.argv.get_flag_arg_by_index({"name"}, 1, default_name)
    local project = darwin.create_project(project_name)
    local relative_path = darwin.argv.get_flag_arg_by_index({"relative_path"}, 1)
    project.add_lib_source_file(entry, relative_path)

    project.generate_lib_source_file({
        output = output,
        include_embed_data = true
    })
end
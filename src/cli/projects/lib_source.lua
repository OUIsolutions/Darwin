
function create_lib_source_project(entry, output, output_mode)

    local default_name = dtw.path.newPath(output).get_only_name()
    local project_name = darwin.argv.get_flag_arg_by_index({"name"}, 1, default_name)
    local project = darwin.create_project(project_name)
    local relative_path = darwin.argv.get_flag_arg_by_index({"relative_path"}, 1)
    project.add_lua_file_following_require(entry,relative_path)
    local object_export = darwin.argv.get_flag_arg_by_index({"object_export"}, 1)
    if not object_export then
        private_darwin.print_red("Error: object_export is required")
    end

    project.generate_c_lib_file({
        lib_name=project_name,
        output = output,
        object_export = object_export
    })
    
end
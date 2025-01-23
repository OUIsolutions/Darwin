
---@param entry string
---@param output string
---@param output_mode string
function create_lua_project(entry, output,output_mode)
    local project_name = darwin.argv.get_flag_arg_by_index({"name"}, 1,"darwinrproject")
    local project = darwin.create_project(project_name)
    local relative_path = darwin.argv.get_flag_arg_by_index({"relative_path"}, 1)
    project.add_lua_file_following_require(entry,relative_path)

    project.generate_lua_file({
        output = output,
        include_embed_data = true
    })
    
end 
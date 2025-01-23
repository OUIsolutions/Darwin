
---@param entry string
---@param output string
---@param output_mode string
function create_lua_project(entry_mode,project,output,output_mode)


    local main_file_or_folder = darwin.argv.get_next_unused()
    if not main_file then
        private_darwin.print_red("main file not found")
        return
    end

    local unused_index = darwin.argv.get_next_unused_index()
    if unused_index then
        local unused_arg = darwin.argv.get_arg_by_index(unused_index)
        local msg = "arg:" .. unused_arg .. " at index: " .. unused_index .. "its unused"
        private_darwin.print_red(msg)
        return 
    end

    project.add_lua_file_following_require(main_file,relative_path)


    
    project.generate_lua_file({
        output = output,
        include_embed_data = true
    })
    
end 


function handle_main_file(project)

    local entry_mode = darwin.argv.get_flag_arg_by_index_consider_only_first("entry_mode",1, "file")
    if not private_darwin.is_inside({"file","folder"},entry_mode) then
        private_darwin.print_red("entry mode not valid")
        return
    end

    local relative_path = darwin.argv.get_flag_arg_by_index_consider_only_first("relative_path")

    local main_file_or_folder = darwin.argv.get_next_unused()
    if not main_file_or_folder then
        private_darwin.print_red("main file not found")
        return false 
    end
    
    if entry_mode == "file" then
        project.add_lua_file_following_require(main_file_or_folder,relative_path)
    end 


    if entry_mode == "folder" then
        if not darwin.dtw.isdir(main_file_or_folder) then
            private_darwin.print_red(main_file_or_folder .. "its not a folder\n")
            return false
        end
        local all_paths = darwin.dtw.list_files_recursively(main_file_or_folder, true)
        for i = 1, #all_paths do
            project.add_lua_file(all_paths[i],relative_path)
        end
    end 
    return true
end 
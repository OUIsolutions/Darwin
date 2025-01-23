
---@param project DarwinProject
function get_embed_vars(project)

    local embed_vars_size = darwin.argv.get_flag_size_consider_only_first("embed_vars")
    for i=1,embed_vars_size do
        local embed_var = darwin.argv.get_flag_arg_by_index_consider_only_first("embed_vars", i)
        local possible_text = darwin.argv.get_flag_arg_by_index_consider_only_first(embed_var..":text",1)
        local possible_file = darwin.argv.get_flag_arg_by_index_consider_only_first(embed_var..":file",1)
        local possible_folder = darwin.argv.get_flag_arg_by_index_consider_only_first(embed_var..":folder",1)
        if not possible_text and not possible_file and not possible_folder then
            private_darwin.print_red("embed_var:"..embed_var.." not found\n")
            return false
        end
        
        if possible_text then
            project.embed_global(embed_var, possible_text)
        end

        if possible_file then
            project.embed_global(embed_var,darwin.file_stream(possible_file))
        end

        if possible_folder then
            local folder_to_be_embed = {}
            if not darwin.dtw.isdir(possible_folder) then
                private_darwin.print_red("folder not found")
                return
            end

            local concat_path = false
            local files = darwin.dtw.list_files_recursively(possible_folder,concat_path)
            for i=1,#files do
                local file = files[i]         
                local full_path = darwin.dtw.concat_path(possible_folder,file)  
                folder_to_be_embed[file] = darwin.file_stream( full_path)
            end
            project.embed_global(embed_var,folder_to_be_embed)

        end

    end
    return true
end 
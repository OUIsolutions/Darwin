---@param blueprint string[]
---@param used_flags string[]
function Perform_blue_print()

    
    local blue_print_mode = darwin.argv.get_first_flag_arg("mode",1, "file")
    if not private_darwin.is_inside({ "file", "folder" }, blue_print_mode) then
        private_darwin.print_red("blue print mode must be file or folder\n")
        return
    end

    local file_or_folder = darwin.argv.get_next_unused()
    if not file_or_folder then
        file_or_folder = "darwinconf.lua"        
    end

    if not handle_unused() then
        return
    end

    
    if blue_print_mode == "folder" then
        if not darwin.dtw.isdir(file_or_folder) then
            private_darwin.print_red(file_or_folder .. "its not a folder\n")
            return
        end


        local all_paths = darwin.dtw.list_files_recursively(file_or_folder, true)
        for i = 1, #all_paths do
            dofile(all_paths[i])
        end

        if not main then
            private_darwin.print_red("main function not provided\n")
            return
        end
        main()
    end

    if blue_print_mode == "file" then
        if not darwin.dtw.isfile(file_or_folder) then
            private_darwin.print_red("blue print:"..file_or_folder.." its not a file")
            return
        end
        dofile(file_or_folder)
    end
    return
end

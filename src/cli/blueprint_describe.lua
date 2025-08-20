---@param blueprint string[]
---@param used_flags string[]
function Perform_blue_print()

    
    local blue_print_mode = darwin.argv.get_flag_arg_by_index_consider_only_first("mode",1, "file")
    if not private_darwin.is_inside({ "file", "folder" }, blue_print_mode) then
        private_darwin.print_red("blue print mode must be file or folder\n")
        return
    end

    local file_or_folder = darwin.argv.get_next_unused()
    if not file_or_folder then
        file_or_folder = "darwinconf.lua"        
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
    end

    if blue_print_mode == "file" then
        if not darwin.dtw.isfile(file_or_folder) then
            private_darwin.print_red("blue print:"..file_or_folder.." its not a file")
            return
        end
        dofile(file_or_folder)
    end

    for i =1,#darwin.available_builds do 
        private_darwin.print_blue("Available build: " .. darwin.available_builds[i].name .. "\n")
        private_darwin.print_blue("Description: " .. darwin.available_builds[i].description .. "\n")
        private_darwin.print_blue("Outputs: \n")
        for j = 1, #darwin.available_builds[i].outs do
            private_darwin.print_blue("    " .. darwin.available_builds[i].outs[j] .. "\n")
        end
        private_darwin.print_green("=======================================\n")
    end




end

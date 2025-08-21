
darwin.load_all = function (target_dir)
        if not darwin.dtw.isdir(target_dir) then
            private_darwin.print_red(target_dir .. "its not a folder\n")
            return
        end
        local all_paths = darwin.dtw.list_files_recursively(target_dir, true)
        for i = 1, #all_paths do
            dofile(all_paths[i])
        end
end 
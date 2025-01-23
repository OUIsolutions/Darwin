

function create_dynamic_link_lib_project( project,output, output_mode)


    local compiler = nil
    if output_mode == "windows_bin" then
        compiler = darwin.argv.get_flag_arg_by_index_consider_only_first("compiler",1,"i686-w64-mingw32-gcc")
    end 
    if output_mode == "linux_bin" then
        compiler = darwin.argv.get_flag_arg_by_index_consider_only_first("compiler",1, "gcc")
    end

    local flags_size = darwin.argv.get_flag_size_consider_only_first("flags")
    local flags_text = ""
    for i = 1, flags_size do
        local flag = darwin.argv.get_flag_arg_by_index_consider_only_first("flags", i, "")
        flags_text = flags_text .. " " .. flag
    end

    if not handle_main_file(project) then
        return
    end
    
    
    if not handle_unused() then
        return
    end

    local cache_output = "darwin_cache.c"
    darwin.dtw.remove_any(cache_output)
    project.generate_c_lib_file({
        output = cache_output,
        object_export = object_export
    })


    os.execute(compiler.." -shared -fPIC "..cache_output.." -o "..output.." "..flags)
    
end
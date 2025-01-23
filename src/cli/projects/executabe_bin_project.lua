
function create_executable_bin_project(project, output,output_mode)

    local compiler = nil
    if output_mode == "windows_bin" then
        compiler = darwin.argv.get_first_flag_arg({"compiler"},"i686-w64-mingw32-gcc")
    end 
    if output_mode == "linux_bin" then
        compiler = darwin.argv.get_first_flag_arg({"compiler"}, "gcc")
    end

    local flags_size = darwin.argv.get_first_flag_arg("flags")
    local flags_text = ""
    for i = 1, flags_size do
        local flag = darwin.argv.get_compact_flags("flags:", i, "")
        flags_text = flags_text .. " " .. flag
    end

    if not handle_main_file() then
        return
    end
    
    
    if not handle_unused() then
        return
    end
    

    local cache_output = "darwin_cache.c"
    darwin.dtw.remove_any(cache_output)
    project.generate_c_file({
        output = cache_output,
        include_embed_data = true
    })

    os.execute(compiler.." "..cache_output.." -o "..output.." "..flags_text)
    
    darwin.dtw.remove_any(cache_output)

    
end
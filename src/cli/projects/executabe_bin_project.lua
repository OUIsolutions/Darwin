
function create_executable_bin_project(project, output,output_mode)

    local cache_output = "darwin_cache.c"
    darwin.dtw.remove_any(cache_output)
    project.generate_c_file({
        output = cache_output,
        include_embed_data = true
    })
    local compiler = nil
    if output_mode == "windows_bin" then
        compiler = darwin.argv.get_flag_arg_by_index({"compiler"}, 1,"i686-w64-mingw32-gcc")
    end 
    if output_mode == "linux_bin" then
        compiler = darwin.argv.get_flag_arg_by_index({"compiler"}, 1,"gcc")
    end

    local flags_size = darwin.argv.get_compact_flags_size("flags:")
    local flags_text = ""
    for i = 1, flags_size do
        local flag = darwin.argv.get_compact_flags("flags:", i, "")
        flags_text = flags_text .. " " .. flag
    end

    os.execute(compiler.." "..cache_output.." -o "..output.." "..flags_text)
    
    darwin.dtw.remove_any(cache_output)

    
end
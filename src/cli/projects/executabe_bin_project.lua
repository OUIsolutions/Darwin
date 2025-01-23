
function create_executable_bin_project(project, output,output_mode)

    local cache_output = "darwin_cache.c"
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
    local flags = darwin.argv.get_flag_arg_by_index({"compiler_flags"}, 1,"")
    
    os.execute(compiler.." "..cache_output.." -o "..output.." "..flags)
    
    darwin.dtw.remove_any(cache_output)

    
end
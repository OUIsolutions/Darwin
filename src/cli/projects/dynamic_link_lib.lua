

function create_dynamic_link_lib_project( output, output_mode)

    local object_export = darwin.argv.get_flag_arg_by_index({"object_export"}, 1)
    if not object_export then
        private_darwin.print_red("Error: object_export is required")
    end

    local cache_output = "darwin_cache.c"
    project.generate_c_lib_file({
        output = cache_output,
        object_export = object_export
    })

    local compiler = nil
    if output_mode == "windows_dll" then
        compiler = darwin.argv.get_flag_arg_by_index({"compiler"}, 1,"i686-w64-mingw32-gcc")
    end
    if output_mode == "linux_so" then
        compiler = darwin.argv.get_flag_arg_by_index({"compiler"}, 1,"gcc")
    end
    local flags = darwin.argv.get_flag_arg_by_index({"compiler_flags"}, 1,"")

    os.execute(compiler.." -shared -fPIC "..cache_output.." -o "..output.." "..flags)
    
end
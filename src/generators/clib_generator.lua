darwin.generate_c_lib_code = function(props)
    if props.include_e_luacembed ~= false then
        private_darwin.include_lua_cembed = true
    end

    private_darwin.darwin_execcode = private_darwin.create_c_str_bufer(
        darwin.generate_lua_code({
            temp_shared_lib_dir = props.temp_shared_lib_dir
        })
    )

    private_darwin.lib_name = props.libname
    private_darwin.object_export = props.object_export

    local executable = private_darwin.get_asset('lib.c')
    if not executable then
        error("internal error: executable not found")
    end
    local candango_result = private_darwin_candango.Render_text(executable)

    if candango_result.exist_error then
        error("internal error " .. candango_result.error_message)
    end
    return candango_result.render_text
end


darwin.generate_c_lib_output = function(props)
    dtw.write_file(props.output_name, darwin.generate_c_lib_code({
        libname = props.libname,
        object_export = props.object_export,
        include_e_luacembed = props.include_e_luacembed,
        temp_shared_lib_dir = props.temp_shared_lib_dir
    }))
end

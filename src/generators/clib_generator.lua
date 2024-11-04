darwin.generate_c_lib_code = function(lib_name, object_export)
    private_darwin.darwin_execcode = private_darwin.create_c_str_buffer(
        darwin.generate_lua_code()
    )
    private_darwin.lib_name = lib_name
    private_darwin.object_export = object_export
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


darwin.generate_c_lib_output = function(libnname, object_export, filename)
    dtw.write_file(filename, darwin.generate_c_lib_code(libnname, object_export))
end

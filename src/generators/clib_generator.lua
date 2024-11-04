darwin.generate_c_lib_code = function()
    private_darwin.darwin_execcode = private_darwin.create_c_str_buffer(
        darwin.generate_lua_code()
    )
    local executable = private_darwin.get_asset('executable.c')
    if not executable then
        error("internal error: executable not found")
    end
    local candango_result = private_darwin_candango.Render_text(executable)

    if candango_result.exist_error then
        error("internal error " .. candango_result.error_message)
    end
    return candango_result.render_text
end


darwin.generate_c_lib_output = function(filename)
    dtw.write_file(filename, darwin.generate_c_lib_code())
end

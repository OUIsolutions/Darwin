darwin.generate_c_executable_code = function(props)
    if not props then
        props = {}
    end
    if props.include_lua_cembed ~= false then
        private_darwin.include_lua_cembed = true
    end

    private_darwin.darwin_execcode = private_darwin.create_c_str_bufer(
        darwin.generate_lua_code({ temp_shared_lib_dir = props.temp_shared_lib_dir })
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


darwin.generate_c_executable_output = function(props)
    dtw.write_file(props.filename,
        darwin.generate_c_executable_code({
            include_lua_cembed = props.include_lua_cembed,
            temp_shared_lib_dir = props.temp_shared_lib_dir
        }))
end

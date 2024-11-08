private_darwin.create_c_str_bufer = function(value)
    local name = string.format("private_darwin_sha%s", dtw.generate_sha(value))

    if private_darwin.is_inside(private_darwin.generated_c_str_shas, name) then
        return name
    end
    private_darwin.generated_c_str_shas[#private_darwin.generated_c_str_shas + 1] = name

    local buffer = { string.format("unsigned char  %s[] = {", name) }

    local size = string.len(value)
    for i = 1, size do
        local current_char = string.sub(value, i, i)
        local byte = string.byte(current_char)
        buffer[#buffer + 1] = string.format("%d,", byte)
    end
    buffer[#buffer + 1] = "0};\n"

    private_darwin.c_str_shas_code = private_darwin.c_str_shas_code .. table.concat(buffer, "")
    return name
end

private_darwin.create_lua_str_buffer = function(str_code)
    PrivateDarwin_require_parse_to_bytes = true
    local name = string.format("private_darwin_sha%s", dtw.generate_sha(str_code))

    if private_darwin.is_inside(private_darwin.generated_lua_str_shas, name) then
        return name
    end
    private_darwin.generated_lua_str_shas[#private_darwin.generated_lua_str_shas + 1] = name

    local buffer = {
        string.format(
            "%s = table.concat(PrivateDarwing_parse_to_bytes({",
            name
        )
    }
    local size = string.len(str_code)
    for i = 1, size do
        local current_char = string.sub(str_code, i, i)
        local byte = string.byte(current_char)
        buffer[#buffer + 1] = string.format("%d,", byte)
    end

    buffer[#buffer + 1] = "}))"
    private_darwin.lua_str_shas_code = private_darwin.lua_str_shas_code .. table.concat(buffer, "")
    return name
end

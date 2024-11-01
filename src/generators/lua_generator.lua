darwin.generate_lua_code = function()
    local final = ""
    if private_darwin.require_parse_to_bytes then
        final = final .. PRIVATE_DARWIN_ASSETS["assets/parse_to_bytes.lua"] .. "\n"
    end
    final = final .. private_darwin.lua_globals .. "\n"
    final = final .. private_darwin.main_lua_code .. "\n"
    return final
end

darwin.generate_lua_output = function(filename)
    io.open(filename, "w"):write(darwin.generate_lua_code()):close()
end

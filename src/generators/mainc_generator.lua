darwin.generate_c_executable_code = function()
    local main_lua_code = private_darwin.create_c_str_buffer(
        darwin.generate_lua_code()
    )

    local replacers = {
        { item = "darwin_luacembed", value = PRIVATE_DARWIN_LUA_CEMBED },
        { item = "darwin_cglobals",  value = private_darwin.cglobals },
        { item = "darwin_execcode",  value = main_lua_code },
        { item = "cincludes",        value = private_darwin.include_code },
        { item = "ccalls",           value = private_darwin.c_calls },

    }
    local final = PRIVATE_DARWIN_ASSETS["assets/executable.c"]
    for i = 1, #replacers do
        local current = replacers[i]

        final = private_darwin.replace_simple(final, current.item, current.value)
    end
    return final
end

darwin.generate_c_executable_output = function(filename)
    io.open(filename, "w"):write(darwin.generate_c_executable_code()):close()
end

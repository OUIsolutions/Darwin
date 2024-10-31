---@return string
function Generate_c_executable_code()
    local main_lua_code = PrivateDarwing_Create_c_str_buffer(
        Generate_lua_code()
    )

    local replacers = {
        { item = "darwin_luacembed", value = LUA_CEMBED },
        { item = "darwin_cglobals",  value = PrivateDarwin_cglobals },
        { item = "darwin_execcode",  value = main_lua_code },
        { item = "cincludes",        value = PrivateDarwin_include_code },
        { item = "ccalls",           value = PrivateDarwin_c_calls },

    }
    local final = MAIN_C
    for i = 1, #replacers do
        local current = replacers[i]

        final = PrivateDarwingreplace_simple(final, current.item, current.value)
    end
    return final
end

---@param filename string
function Generate_c_executable_output(filename)
    io.open(filename, "w"):write(Generate_c_executable_code()):close()
end

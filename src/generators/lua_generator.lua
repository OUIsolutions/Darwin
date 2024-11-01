---@return string
function Generate_lua_code()
    local final = ""
    if PrivateDarwin_require_parse_to_bytes then
        final = final .. ASSETS["assets/parse_to_bytes.lua"] .. "\n"
    end
    final = final .. PrivateDarwin_lua_globals .. "\n"
    final = final .. PrivateDarwing_main_lua_code .. "\n"
    return final
end

---@param filename string
function Generate_lua_output(filename)
    io.open(filename, "w"):write(Generate_lua_code()):close()
end

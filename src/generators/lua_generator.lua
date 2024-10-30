PARSE_TO_BYTES = [[
function PrivateDarwing_parse_to_bytes(seq)
    local buffer = {}
    for i = 1, #seq do
        buffer[#buffer + 1] = string.char(seq[i])
    end
    return buffer
end
]]

---@return string
function Generate_lua_code()
    local final = ""
    if PrivateDarwin_require_parse_to_bytes then
        final = final .. PARSE_TO_BYTES .. "\n"
    end
    final = final .. PrivateDarwin_lua_globals .. "\n"
    final = final .. PrivateDarwing_main_lua_code .. "\n"
    return final
end

---@param filename string
function Generate_lua_output(filename)
    io.open(filename, "w"):write(Generate_lua_code()):close()
end

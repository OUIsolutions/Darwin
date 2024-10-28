---@return string
function Generate_lua_code()
    return PrivateDarwin_lua_globals .. '\n' .. PrivateDarwing_main_lua_code
end

---@param filename string
function Generate_lua_output(filename)
    io.open(filename, "w"):write(Generate_lua_code()):close()
end

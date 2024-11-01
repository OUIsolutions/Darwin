darwin.Addlua_code = function(code)
    PrivateDarwing_main_lua_code = PrivateDarwing_main_lua_code .. "\n" .. code
end

darwin.Addluafile = function(filename)
    local content = io.open(filename)
    if not content then
        print("content of: " .. filename .. " not provided")
        os.exit(1) -- Encerra o programa com código de saída 0
    end
    darwin.Addlua_code(content:read('a'))
    content:close()
end

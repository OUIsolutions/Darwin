darwin.add_lua_code = function(code)
    private_darwin.main_lua_code = private_darwin.main_lua_code .. "\n" .. code
end

darwin.add_lua_file = function(filename)
    local content = io.open(filename)
    if not content then
        print("content of: " .. filename .. " not provided")
        os.exit(1) -- Encerra o programa com código de saída 0
    end
    darwin.add_lua_code(content:read('a'))
    content:close()
end

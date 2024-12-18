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

private_darwin.construct_possible_files = function(item)
    return {
        string.format("/usr/share/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/share/lua/%s/%s/init.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s/init.lua", _VERSION, item),
        string.format("./%s.lua", item),
        string.format("./%s/init.lua", item),
        string.format("/usr/lib64/lua/%s/%s.so", _VERSION, item),
        string.format("/usr/lib64/lua/%s/loadall.so", _VERSION),
        string.format("./%s.so", item),
    }
end

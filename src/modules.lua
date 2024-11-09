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
darwin.unsafe_add_lua_code_following_require = function(start_filename)
    local old_require = require

    require = function(item)
        local content = nil
        local possible_paths = private_darwin.construct_possible_files(item)
        for i = 1, #possible_paths do
            local current = possible_paths[i]
            local is_file = dtw.isfile(current)
            if is_file and dtw.ends_with(current, ".so") then
                private_darwin.embed_shared_lib(item, current)
                content = string.format("return require('%s')",item)
                break
            end
            if is_file then
                content = dtw.load_file(current)
                break
            end
        end
        if not content then
            error("item: " .. item .. " not provided")
        end

        for i = 1, #private_darwin.lua_modules do
            local already_imported = private_darwin.lua_modules[i].item == item
            if already_imported then
                return
            end
        end

        private_darwin.lua_modules[#private_darwin.lua_modules + 1] = {
            item = item,
            content = content
        }
        return old_require(item)
    end
    dofile(start_filename)
    require = old_require
    darwin.add_lua_file(start_filename)
end

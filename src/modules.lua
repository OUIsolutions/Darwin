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


darwin.unsafe_add_lua_code_following_require = function(start_filename)
    local old_require = require

    require = function(item)
        local filename = item .. ".lua"
        local content = dtw.load_file(filename)
        if not content then
            error("file " .. item .. " not provided")
        end
        dofile(filename)
        for i = 1, #private_darwin.lua_modules do
            local already_imported = private_darwin.lua_modules[i].path == filename
            if already_imported then
                return
            end
        end
        private_darwin.lua_modules[#private_darwin.lua_modules + 1] = {
            path = filename,
            content = content
        }
    end

    dofile(start_filename)
    require = old_require
    darwin.add_lua_file(start_filename)
end

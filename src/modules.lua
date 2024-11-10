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
darwin.unsafe_add_lua_code_following_require = function(start_filename, shared_lib_import)
    local old_package_load_lib = package.loadlib
    local old_require = require

    if shared_lib_import == nil then
        shared_lib_import = true
    end

    if shared_lib_import then
        package.loadlib = function(filename, func_name)
            private_darwin.embed_shared_lib(filename)
            return old_package_load_lib(filename, func_name)
        end
    end


    require = function(item)
        local content = nil
        local possible_paths = private_darwin.construct_possible_files(item)
        local chosed_file = nil
        for i = 1, #possible_paths do
            local current = possible_paths[i]
            chosed_file = current
            local is_file = dtw.isfile(current)
            local is_shared = is_file and dtw.ends_with(current, ".so")
            if is_shared and not shared_lib_import then
                return
            end

            if is_shared then
                local sha = private_darwin.embed_shared_lib(current)
                content = string.format(
                    "return PrivateDarwin_old_load_lib(Private_darwin_shared_dir..'/%s.so','luaopen_%s')()",
                    sha,
                    item
                )
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
        local start_comptime_dir = 'Private_darwin_comptime_dir =""'
        local dir                = dtw.newPath(chosed_file).get_dir()
        if dir then
            start_comptime_dir = string.format('Private_darwin_comptime_dir ="%s"', dir)
        end

        content = string.format([[
                Private_darwin_old_comptime_dir =Private_darwin_comptime_dir
                %s
                local private_darwin_internal_callback = function ()
                    %s
                end
                private_darwin_internal_callback = private_darwin_internal_callback()
                if Private_darwin_old_comptime_dir then
                    Private_darwin_comptime_dir = Private_darwin_old_comptime_dir
                end
                return private_darwin_internal_callback
            ]], start_comptime_dir, content)

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
    require                  = old_require
    package.loadlib          = old_package_load_lib

    local start_comptime_dir = 'Private_darwin_comptime_dir =""'
    local dir                = dtw.newPath(start_filename).get_dir()
    if dir then
        start_comptime_dir = string.format('Private_darwin_comptime_dir ="%s"', dir)
    end

    local content = dtw.load_file(start_filename)
    content       = string.format([[
            Private_darwin_old_comptime_dir =Private_darwin_comptime_dir
            %s
            %s
            if Private_darwin_old_comptime_dir then
                Private_darwin_comptime_dir = Private_darwin_old_comptime_dir
            end
    ]], start_comptime_dir, content)

    darwin.add_lua_code(content)
end

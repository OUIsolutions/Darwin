function Drop_types()
    local file = darwin.argv.get_next_unused()
    
    local unused_index = darwin.argv.get_next_unused_index()
    if unused_index then
        local unused_arg = darwin.argv.get_arg_by_index(unused_index)
        local msg = "arg:" .. unused_arg .. " at index: " .. unused_index .. "its unused"
        private_darwin.print_red(msg)
        return 
    end

    if not file then
        file = "darwintypes.lua"
    end

    darwin.dtw.write_file(file, PRIVATE_DARWIN_TYPES)
end


function Drop_lua_cembed()
    local file = darwin.argv.get_next_unused()
    
    local unused_index = darwin.argv.get_next_unused_index()
    if unused_index then
        local unused_arg = darwin.argv.get_arg_by_index(unused_index)
        local msg = "arg:" .. unused_arg .. " at index: " .. unused_index .. "its unused"
        private_darwin.print_red(msg)
        return 
    end
    
    if not file then
        file = "LuaCEmbed.c"
    end
    local lua_cembedd = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "LuaCEmbed.h")
    darwin.dtw.write_file(file, lua_cembedd)
end
darwin.generate_lua_code = function()
    local final = ""
    if #private_darwin.lua_modules > 0 then
        final = final .. "Private_darwin_modules = {}\n"
    end

    for i = 1, #private_darwin.lua_modules do
        local current = private_darwin.lua_modules[i]
        final = final .. string.format("Private_darwin_modules[%d] = {\n", i)
        final = final .. string.format("item = '%s',\n", current.item)
        final = final .. string.format("callback_import = function()\n%s\nend\n", current.content)
        final = final .. "\n}\n"
    end

    if #private_darwin.lua_modules > 0 then
        final = final .. private_darwin.get_asset("require.lua")
    end

    if private_darwin.require_parse_to_bytes then
        final = final .. private_darwin.get_asset("parse_to_bytes.lua") .. "\n"
    end
    final = final .. private_darwin.lua_str_shas_code .. "\n"
    final = final .. private_darwin.lua_globals .. "\n"
    final = final .. private_darwin.main_lua_code .. "\n"
    return final
end

darwin.generate_lua_output = function(filename)
    dtw.write_file(filename, darwin.generate_lua_code())
end

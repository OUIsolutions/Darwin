function Embed_c_code()
    darwin.add_c_file("dependencies/CTextEngine.h")
    darwin.add_c_file("assets/api/LuaCEmbed.h")
    darwin.add_c_file("dependencies/doTheWorld.h")
    darwin.add_c_file("dependencies/lua_c_amalgamator_dependencie_not_included.c")
    darwin.add_c_file("dependencies/silverchain_no_dependecie_included.c")

    darwin.add_c_file("dependencies/LuaDoTheWorld/src/one.c", true, function(import, path)
        -- to make the luacembe not be imported twice
        if import == "../dependencies/dependency.LuaCEmbed.h" then
            return false
        end
        if import == "../dependencies/dependency.doTheWorld.h" then
            return false
        end
        return true
    end)


    darwin.add_c_file("dependencies/candangoEngine/src/main.c", true, function(import, path)
        -- to make the luacembe not be imported twice
        if import == "../dependencies/depB.LuaCEmbed.h" then
            return false
        end
        return true
    end)
    darwin.add_c_file("dependencies/LuaFluidJson/src/main.c", true, function(import, path)
        -- to make the luacembe not be imported twice
        if import == "dependencies/LuaCEmbed.h" then
            return false
        end
        if import == "dependencies/cJSON/cJSON.h" then
            return false
        end
        if import == "dependencies/cJSON/cJSON.c" then
            return false
        end
        return true
    end)

    darwin.load_lualib_from_c("luaopen_lua_c_amalgamator", "private_darwin_camalgamator")
    darwin.load_lualib_from_c("luaopen_lua_silverchain", "private_darwin_silverchain")
    darwin.load_lualib_from_c("load_luaDoTheWorld", "private_darwin_dtw")
    darwin.load_lualib_from_c("load_lua", "private_darwin_json")
    darwin.load_lualib_from_c("candango_engine_start_point", "private_darwin_candango")
end

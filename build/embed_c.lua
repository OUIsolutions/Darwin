function Embed_c_code()
    darwin.add_c_file("dependencies/LuaDoTheWorld/src/one.c", true, function(import, path)
        -- to make the luacembe not be imported twice
        if import == "../dependencies/dependency.LuaCEmbed.h" then
            return false
        end
        return true
    end)
    darwin.load_lualib_from_c("load_luaDoTheWorld", "private_darwin_dtw")
    darwin.add_c_file("dependencies/candangoEngine/src/main.c", true, function(import, path)
        -- to make the luacembe not be imported twice
        if import == "../dependencies/depB.LuaCEmbed.h" then
            return false
        end
        return true
    end)
    darwin.load_lualib_from_c("candango_engine_start_point", "private_darwin_candango")
end

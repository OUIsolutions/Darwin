function Embed_c_code(project)
    project.add_c_file("dependencies/CTextEngineOne.c")
    project.add_c_external_code("#define error LuaError\n")
    project.add_c_file("assets/api/LuaCEmbedOne.c")
    project.add_c_external_code("#undef error\n")
    project.add_c_file("dependencies/doTheWorldOne.c")
    project.add_c_file("dependencies/lua_c_amalgamator_dependencie_not_included.c")
    project.add_c_file("dependencies/silverchain_no_dependecie_included.c")
    project.add_c_file("dependencies/luaDoTheWorld_no_dep.c")
    project.add_c_file("dependencies/luaFluidJson_no_dep.c")
    project.add_c_file("dependencies/luamdeclare.c")

    project.add_c_file("dependencies/candangoEngine/src/main.c", true, function(path,import)
        -- to make the luacembe not be imported twice
        if import == "../dependencies/depB.LuaCEmbed.h" then
            return false
        end
        return true
    end)
   
    project.load_lib_from_c("luaopen_luamdeclare", "private_darwin_luamdeclare")
    project.load_lib_from_c("luaopen_lua_c_amalgamator", "private_darwin_camalgamator")
    project.load_lib_from_c("luaopen_lua_silverchain", "private_darwin_silverchain")
    project.load_lib_from_c("load_luaDoTheWorld", "private_darwin_dtw")
    project.load_lib_from_c("load_lua_fluid_json", "private_darwin_json")
    project.load_lib_from_c("candango_engine_start_point", "private_darwin_candango")
end

function Install_all_dependencies()
    local hasher = darwin.dtw.newHasher()
    hasher.digest_folder_by_content("dependencies")
    local EXPECTED_HASH = 'd9ed3ce3c7b5b303471ed2c27838def69f1901b11e48c03e850961cfdea6413a'
    if hasher.get_value() == EXPECTED_HASH then
        return
    end

    darwin.dtw.remove_any("dependencies")
    local commands = {

        "mkdir dependencies",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaFluidJson/releases/download/0.6.1/luaFluidJson_no_dep.c -o luaFluidJson_no_dep.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaDoTheWorld/releases/download/0.7.2/luaDoTheWorld_no_dep.c -o luaDoTheWorld_no_dep.c",
        "cd dependencies && git clone -b V0.003 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git",
        "cd dependencies && curl -L https://github.com/OUIsolutions/CTextEngine/releases/download/3.0.000/CTextEngineOne.c -o CTextEngineOne.c",
        "cd assets/api && curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/0.8.3/LuaCEmbedOne.c -o LuaCEmbedOne.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/DoTheWorld/releases/download/10.1.1/doTheWorldOne.c -o doTheWorldOne.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaArgv/releases/download/0.1.0/luargv.lua -o luargv.lua",
        'cd dependencies && curl -L https://github.com/OUIsolutions/LuaShip/releases/download/0.1.0/LuaShip.lua -o LuaShip.lua',
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaSilverChain/releases/download/0.1.2/silverchain_no_dependecie_included.c -o silverchain_no_dependecie_included.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaCAmalgamator/releases/download/0.1.0/lua_c_amalgamator_dependencie_not_included.c -o lua_c_amalgamator_dependencie_not_included.c"
    }

    for _, cmd in ipairs(commands) do
        os.execute(cmd)
    end

    darwin.dtw.remove_any("dependencies/candangoEngine/.git")

    local new_hasher = darwin.dtw.newHasher()
    new_hasher.digest_folder_by_content("dependencies")
    print("dependencie hash: " .. new_hasher.get_value())
end

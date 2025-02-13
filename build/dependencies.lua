function Install_all_dependencies()
    local hasher = darwin.dtw.newHasher()
    hasher.digest_folder_by_content("dependencies")
    local EXPECTED_HASH = '0262f17af7bcc1bec65e8680ddacdb9c53b543cf947801619f2ae8bc69231a4f'
    if hasher.get_value() == EXPECTED_HASH then
        return
    end

    darwin.dtw.remove_any("dependencies")
    local commands = {

        "mkdir dependencies",
        "cd dependencies && git clone -b v0.52 https://github.com/OUIsolutions/LuaFluidJson.git",
        "cd dependencies && git clone -b v0.72 https://github.com/OUIsolutions/LuaDoTheWorld.git",
        "cd dependencies && git clone -b V0.003 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git",
        "cd dependencies && curl -L https://github.com/OUIsolutions/CTextEngine/releases/download/v2.002/CTextEngine.h -o CTextEngine.h",
        "cd assets/api && curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.780/LuaCEmbed.h -o LuaCEmbed.h",
        "cd dependencies && curl -L https://github.com/OUIsolutions/DoTheWorld/releases/download/v7.006/doTheWorld.h -o doTheWorld.h",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaArgv/releases/download/0.09/luargv.lua -o luargv.lua",
        'cd dependencies && curl -L https://github.com/OUIsolutions/LuaShip/releases/download/0.1.0/LuaShip.lua -o LuaShip.lua',
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaSilverChain/releases/download/0.002/silverchain_no_dependecie_included.c -o silverchain_no_dependecie_included.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaCAmalgamator/releases/download/0.002/lua_c_amalgamator_dependencie_not_included.c -o lua_c_amalgamator_dependencie_not_included.c"
    }

    for _, cmd in ipairs(commands) do
        os.execute(cmd)
    end
    local new_hasher = darwin.dtw.newHasher()
    new_hasher.digest_folder_by_content("dependencies")
    print("dependencie hash: " .. new_hasher.get_value())
end

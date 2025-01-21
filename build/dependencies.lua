function Install_all_dependencies()
    dtw.remove_any("dependencies")
    local commands = {

        "mkdir dependencies",
        "cd dependencies && git clone -b v0.52 https://github.com/OUIsolutions/LuaFluidJson.git",
        "cd dependencies && git clone -b v0.72 https://github.com/OUIsolutions/LuaDoTheWorld.git",
        "cd dependencies && git clone -b V0.003 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git",
        "cd dependencies && curl -L https://github.com/OUIsolutions/CTextEngine/releases/download/v2.002/CTextEngine.h -o CTextEngine.h",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.780/LuaCEmbed.h -o LuaCEmbed.h",
        "cd dependencies && curl -L https://github.com/OUIsolutions/DoTheWorld/releases/download/v7.006/doTheWorld.h -o doTheWorld.h",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaArgv/releases/download/0.02/luargv.lua -o luargv.lua",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaSilverChain/releases/download/0.002/silverchain_no_dependecie_included.c -o silverchain_no_dependecie_included.c",
        "cd dependencies && curl -L https://github.com/OUIsolutions/LuaCAmalgamator/releases/download/0.002/lua_c_amalgamator_dependencie_not_included.c -o lua_c_amalgamator_dependencie_not_included.c"
    }

    for _, cmd in ipairs(commands) do
        os.execute(cmd)
    end
end

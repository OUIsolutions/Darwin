local cache_arg = arg[4]
if cache_arg ~= "cache" then
    os.execute("curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.77/LuaCEmbed.h -o LuaCEmbed.h  ")
    dtw.remove_any("LuaDoTheWorld")
    os.execute("git clone -b v0.71 https://github.com/OUIsolutions/LuaDoTheWorld.git")
    dtw.remove_any("candangoEngine")
    os.execute("git clone -b V0.001 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git")
end

darwin.embedglobal("PRIVATE_DARWIN_LUA_CEMBED", dtw.load_file("LuaCEmbed.h"))

local assets_files = dtw.list_files_recursively("assets", true)
local assets = {}
for i = 1, #assets_files do
    local current = assets_files[i]
    assets[current] = dtw.load_file(current)
end
darwin.embedglobal("PRIVATE_DARWIN_ASSETS", assets)


darwin.add_c_file("LuaDoTheWorld/src/one.c", true, function(import, path)
    -- to make the luacembe not be imported twice
    if import == "../dependencies/dependency.LuaCEmbed.h" then
        return false
    end
    return true
end)

darwin.add_c_file("candangoEngine/src/main.c", true, function(import, path)
    -- to make the luacembe not be imported twice
    if import == "../dependencies/depB.LuaCEmbed.h" then
        return false
    end
    return true
end)

darwin.load_lualib_from_c("load_luaDoTheWorld", "dtw")
darwin.load_lualib_from_c("candango_engine_start_point", "private_darwin_candango")

darwin.add_lua_code("darwin = {}")
darwin.add_lua_code("private_darwin = {}")

local src_files = dtw.list_files_recursively("src", true)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_file(current)
end
darwin.add_lua_code("main()")
darwin.generate_lua_output("debug.lua")
darwin.generate_c_executable_output("darwin011.c")
os.execute("gcc darwin011.c -o  darwin011.o")
os.execute("gcc darwin011.c -o  darwin011.o")

local types =
    dtw.load_file("assets/dtw_types.lua") ..
    dtw.load_file("assets/candango_type.lua") ..
    dtw.load_file("assets/types.lua")

dtw.write_file("types011.lua", types)

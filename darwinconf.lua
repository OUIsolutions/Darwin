os.execute("curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.77/LuaCEmbed.h -o LuaCEmbed.h  ")

Embedglobal("LUA_CEMBED", dtw.load_file("LuaCEmbed.h"))

local assets_files = dtw.list_files_recursively("assets", true)
local assets = {}
for i = 1, #assets_files do
    local current = assets_files[i]
    assets[current] = dtw.load_file(current)
end
Embedglobal("ASSETS", assets)

dtw.remove_any("LuaDoTheWorld")
os.execute("git clone -b v0.71 https://github.com/OUIsolutions/LuaDoTheWorld.git")
Add_c_file("LuaDoTheWorld/src/one.c", true, function(import, path)
    -- to make the luacembe not be imported twice
    if import == "../dependencies/dependency.LuaCEmbed.h" then
        return false
    end
    return true
end)
Load_lualib_from_c("load_luaDoTheWorld", "dtw")


local src_files = dtw.list_files_recursively("src", true)
for i = 1, #src_files do
    local current = src_files[i]
    Addluafile(current)
end
Addlua("main()")
Generate_lua_output("debug.lua")
Generate_c_executable_output("darwin008.c")
os.execute("gcc darwin008.c -o  darwin008.o")
os.execute("gcc darwin008.c -o  darwin008.o")

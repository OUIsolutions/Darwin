os.execute("curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.77/LuaCEmbed.h -o LuaCEmbed.h  ")
darwin.embedglobal("PRIVATE_DARWIN_LUA_CEMBED", dtw.load_file("LuaCEmbed.h"))

local assets_files = dtw.list_files_recursively("assets", true)
local assets = {}
for i = 1, #assets_files do
    local current = assets_files[i]
    assets[current] = dtw.load_file(current)
end
darwin.embedglobal("PRIVATE_DARWIN_ASSETS", assets)

dtw.remove_any("LuaDoTheWorld")
os.execute("git clone -b v0.71 https://github.com/OUIsolutions/LuaDoTheWorld.git")
darwin.add_c_file("LuaDoTheWorld/src/one.c", true, function(import, path)
    -- to make the luacembe not be imported twice
    if import == "../dependencies/dependency.LuaCEmbed.h" then
        return false
    end
    return true
end)
darwin.load_lualib_from_c("load_luaDoTheWorld", "dtw")

darwin.add_lua_code("darwin = {}")
darwin.add_lua_code("private_darwin = {}")

local src_files = dtw.list_files_recursively("src", true)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_file(current)
end
darwin.add_lua_code("main()")
darwin.generate_lua_output("debug.lua")
darwin.generate_c_executable_output("darwin010.c")
os.execute("gcc darwin010.c -o  darwin010.o")
os.execute("gcc darwin010.c -o  darwin010.o")

local types = dtw.load_file("assets/dtw_types.lua") .. dtw.load_file("assets/types.lua")
dtw.write_file("types010.lua", types)

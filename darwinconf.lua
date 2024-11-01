os.execute("curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.77/LuaCEmbed.h -o LuaCEmbed.h  ")

Embedglobal("LUA_CEMBED", dtw.load_file("LuaCEmbed.h"))

local assets = dtw.list_files_recursively("assets", true)
for i = 1, #assets do
    local current = assets[i]
    print(current)
end

local executable = io.open("assets/executable.c")
Embedglobal("MAIN_C", executable:read("a"))
executable:close()

local parse_to_bytes = io.open("assets/parse_to_bytes.lua")
Embedglobal("PARSE_TO_BYTES", parse_to_bytes:read("a"))
parse_to_bytes:close()

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

Generate_lua_output("debug.lua")
Generate_c_executable_output("darwin008.c")
os.execute("gcc darwin008.c -o  darwin008.o")
os.execute("gcc darwin008.c -o  darwin008.o")

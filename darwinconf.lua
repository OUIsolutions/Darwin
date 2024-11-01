os.execute("curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.77/LuaCEmbed.h -o LuaCEmbed.h  ")

local luaembed = io.open("LuaCEmbed.h")
Embedglobal("LUA_CEMBED", luaembed:read("a"))
luaembed:close()

local executable = io.open("assets/executable.c")
Embedglobal("MAIN_C", executable:read("a"))
executable:close()

local parse_to_bytes = io.open("assets/parse_to_bytes.lua")
Embedglobal("PARSE_TO_BYTES", parse_to_bytes:read("a"))
parse_to_bytes:close()
os.execute("rm -rf LuaDoTheWorld")
os.execute("git clone -b v0.71 https://github.com/OUIsolutions/LuaDoTheWorld.git")
Add_c_file("LuaDoTheWorld/src/one.c", true, function(import, path)
    -- to make the luacembe not be imported twice
    if import == "../dependencies/dependency.LuaCEmbed.h" then
        return false
    end
    return true
end)

Addfile("src/extra.lua")
Addfile("src/globals.lua")
Addfile("src/modules.lua")
Addfile("src/embed/embed.lua")
Addfile("src/cinterop/basic.lua")
Addfile("src/cinterop/cfile.lua")
Addfile("src/embed/luaembed.lua")
Addfile("src/embed/cembed.lua")
Addfile("src/generators/mainc_generator.lua")
Addfile("src/generators/lua_generator.lua")
Addfile("src/main.lua")


Generate_c_executable_output("darwin006.c")
os.execute("gcc darwin006.c -o  darwin006.o")

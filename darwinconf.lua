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

Addlua("src/extra.lua")
Addlua("src/globals.lua")
Addlua("src/modules.lua")
Addlua("src/embed/embed.lua")
Addlua("src/cinterop/basic.lua")
Addlua("src/cinterop/cfile.lua")
Addlua("src/embed/luaembed.lua")
Addlua("src/embed/cembed.lua")
Addlua("src/generators/mainc_generator.lua")
Addlua("src/generators/lua_generator.lua")
Addlua("src/main.lua")


Generate_c_executable_output("darwin007.c")
os.execute("gcc darwin007.c -o  darwin007.o")

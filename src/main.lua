MAIN_C = [[

    darwin_luacembed
    void private_darwing_set_globals(LuaCEmbed *args){
        darwin_cglobals
    };

    unsigned char exec_code[] = darwin_execcode;

    int main(){
        LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
        LuaCEmbed_load_native_libs(main_obj);
        private_darwing_set_globals(main_obj);
        LuaCEmbed_evaluate(main_obj, "%s",(const char*)exec_code);
        if(LuaCEmbed_has_errors(main_obj)){
            printf("%s\n",LuaCEmbed_get_error_message(main_obj));
        }
        LuaCEmbed_free(main_obj);
    }
]]

function main()
    if not io.open("darwinconf.lua") then
        print("darwinconf.lua not provided")
        return
    end

    dofile("darwinconf.lua")

    local replacers = {
        { item = "darwin_luacembed", value = LUA_CEMBED },
        { item = "darwin_cglobals",  value = PrivateDarwin_cglobals },
        { item = "darwin_execcode",  value = PrivateDarwing_Create_c_str_buffer(PrivateDarwing_main_lua_code) },
    }
    local final = MAIN_C
    for i = 1, #replacers do
        local current = replacers[i]

        final = PrivateDarwingreplace_simple(final, current.item, current.value)
    end

    if not Cfilename then
        Cfilename = "final004.c"
    end

    io.open(Cfilename, "w"):write(final):close()

    if Luaoutput then
        io.open(Luaoutput, "w"):write(main_code):close()
    end

    if not Compiler then
        return
    end


    if not Output then
        Output = "final004"
    end


    local compilation_command = Compiler .. " " .. Cfilename .. " -o " .. Output
    os.execute(compilation_command)

    if Runafter then
        os.execute("./" .. Output)
    end
end

main()

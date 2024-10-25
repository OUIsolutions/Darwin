function main()
    if not io.open("darwinconf.lua") then
        print("darwinconf.lua not provided")
        return
    end

    dofile("darwinconf.lua")

    local set_globals_func = string.format([[
       void private_darwing_set_globals(LuaCEmbed *args){
            %s
       };
    ]], PrivateDarwin_cglobals)

    local formmated_main_code = Create_c_str_buffer(main_code)
    local final = string.format(
        "%s %s \nunsigned char exec_code[] = %s;\n %s",
        LUA_CEMBED,
        set_globals_func,
        formmated_main_code,
        MAIN_C
    )

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

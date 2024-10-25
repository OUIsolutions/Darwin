function main()
    if not io.open("darwinconf.lua") then
        print("darwinconf.lua not provided")
        return
    end

    dofile("darwinconf.lua")

    local replacers = {
        { item = "##luacembed##", value = LUA_CEMBED },
        { item = "##cglobals##",  value = PrivateDarwin_cglobals },
        { item = "##execcode##",  value = Create_c_str_buffer(main_code) },
    }
    local final = ""
    for i = 1, #replacers do
        local current = replacers[i]
        final = string.gsub(final, current.item, current.value)
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

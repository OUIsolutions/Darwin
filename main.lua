

function main()
    if not io.open("darwinconf.lua") then
        print("darwinconf.lua not provided")
        return 
    end

    dofile("darwinconf.lua")
    local size =  string.len(main_code)
    local buffer = { "unsigned char exec_code[] = {" }
    for i = 1, size do
          local current_char = string.sub(main_code, i, i)
          local byte = string.byte(current_char)
          buffer[#buffer + 1] = string.format("%d,", byte)
        
    end
    buffer[#buffer + 1] = "0,};\n"
    local formmated_main_code =  table.concat(buffer, "")

    local final = LUA_CEMBED .. formmated_main_code .. MAIN_C

    if not Cfilename then
        Cfilename = "final004.c"
    end

    io.open(Cfilename, "w"):write(final):close()

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

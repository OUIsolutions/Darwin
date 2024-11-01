function main()
    if not io.open("darwinconf.lua") then
        print("darwinconf.lua not provided")
        return
    end
    dofile("darwinconf.lua")
end

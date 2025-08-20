---@class Darwin
darwin = darwin


function main()


  
    local build_funcs = create_build_funcs()

    local i = 1
    for name, buld_lambda in pairs(build_funcs) do
        if darwin.argv.one_of_args_exist(name) then
            print("\n=========================================================================================")
            print("\tstarted of build:", i, "of ", name,  "\n")
            buld_lambda()
            print("\n\tA build [" .. i .. "] finished")
            print("=========================================================================================\n\n")
            i = i + 1
        end
    end

    darwin.dtw.move_any_overwriting("release/alpine_static_bin.out","release/"..PROJECT_NAME..".out")
    darwin.dtw.move_any_overwriting("release/windows64.exe","release/"..PROJECT_NAME.."64.exe")
    darwin.dtw.move_any_overwriting("release/windowsi32.exe","release/"..PROJECT_NAME.."i32.exe")
    darwin.dtw.move_any_overwriting("release/debian_static.deb","release/"..PROJECT_NAME..".deb")
    darwin.dtw.move_any_overwriting("release/rpm_static_build.rpm","release/"..PROJECT_NAME..".rpm")

    if darwin.argv.flags_exist({ "local_linux_install" }) then
        os.execute("sudo chmod +x release/"..PROJECT_NAME..".out && sudo cp release/"..PROJECT_NAME..".out /bin/"..PROJECT_NAME)
    end
end
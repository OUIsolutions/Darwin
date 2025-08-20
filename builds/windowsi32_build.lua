local windows_build_done = false
function windowsi32_build()
    if windows_build_done then
        return
    end
    windows_build_done = true
    amalgamation_build()

    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("debian:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apt-get update")
    image.add_comptime_command("apt-get -y install mingw-w64")
    local compiler = "i686-w64-mingw32-gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "i686-w64-mingw32-g++"
    end

    image.start({
        volumes = {
            { "././release", "/release" },

        },
        command = compiler..[[ --static    /release/amalgamation.c  -o /release/windowsi32.exe -lws2_32]]
    })
end

darwin.add_recipe({
    name="windowsi32_build",
    requires={"amalgamation"},
    description="build a 32-bit Windows executable",
    outs={"release/windowsi32.exe"},
    callback=windowsi32_build
})

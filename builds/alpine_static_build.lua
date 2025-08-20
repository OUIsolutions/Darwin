
function linux_bin()

    amalgamation_build()

    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("alpine:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apk update")
    image.add_comptime_command("apk add --no-cache gcc g++ musl-dev curl")
    local compiler = "gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "g++"
    end

    image.start({
        volumes = {
            { "././release", "/release" },
        },
        command = compiler..[[ --static /release/amalgamation.c  -o /release/linux_bin.out]]

    })
end

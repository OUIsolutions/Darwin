
function linux_bin()

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
        command = compiler..[[ --static /release/darwin.c  -o /release/darwin_linux_bin.out]]

    })
end

darwin.add_recipe({
    name="linux_bin",
    requires={"amalgamation"},
    description="make a static compiled linux binary of the project",
    outs={"release/darwin_linux_bin.out"},
    inputs={"src","dependencies","assets"},

    callback=linux_bin
})
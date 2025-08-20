
function debian_static_build()

    local control = [[
Package: PROJECT_NAME
Version: VERSION
Section: base
Priority: optional
Architecture: amd64
Depends: libc6 (>= 2.27)
Maintainer: FULLNAME EMAIL
Description: SUMARY
]]

    control = string.gsub(control, "PROJECT_NAME", PROJECT_NAME)
    control = string.gsub(control, "VERSION", VERSION)
    control = string.gsub(control, "SUMARY", SUMARY)
    control = string.gsub(control, "FULLNAME", FULLNAME)
    control = string.gsub(control, "EMAIL", EMAIL)


    darwin.dtw.write_file(".cache/debian_static_build/project/DEBIAN/control", control)

    darwin.dtw.copy_any_overwriting(

        "release/linux_bin.out",
        '.cache/debian_static_build/project/usr/local/bin/' .. PROJECT_NAME
    )
    local POST_INSTALL = 
    [[
        #!/bin/sh
        set -e
        chmod 755 /usr/local/bin/PROJECT_NAME
        exit 0

    ]]
    POST_INSTALL = string.gsub(POST_INSTALL, "PROJECT_NAME", PROJECT_NAME)
    darwin.dtw.write_file(".cache/debian_static_build/project/DEBIAN/postinst", POST_INSTALL)

    local image = darwin.ship.create_machine("debian:latest")
    image.provider = CONTANIZER

    image.start({
        flags = { "-it" },
        volumes = {
            { "./.cache/debian_static_build/project", "/project" },
            { "./release",                          "/release" },

        },
        command = "chmod 755 /project/DEBIAN/postinst &&  dpkg-deb --build /project /release/debian_static.deb"
    })
end

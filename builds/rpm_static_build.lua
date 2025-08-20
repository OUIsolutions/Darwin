local rpm_static_build_done = false
function rpm_static_build()
    if rpm_static_build_done then
        return
    end
    rpm_static_build_done = true
    alpine_static_build()
    darwin.dtw.copy_any_overwriting("release/linux_bin.out",
        ".cache/rpm_static_build/SOURCES/linux_bin.out"
    )

    local formmatted_rpm = [[
Name:           PROJECT_NAME
Version:        VERSION
Release:        1%{?dist}
Summary:        SUMARY
Source0:        linux_bin.out

License:        LICENSE
URL:           PROJECT_URL

BuildRoot:      %{_tmppath}/%{name}-%{version}-buildroot
BuildArch:      x86_64

%description

DESCRIPITION

%prep

%build


%install
mkdir -p %{buildroot}/usr/local/bin
cp %{_sourcedir}/linux_bin.out   %{buildroot}/usr/local/bin/PROJECT_NAME
chmod +x %{buildroot}/usr/local/bin/PROJECT_NAME
%files
/usr/local/bin/PROJECT_NAME

%changelog
* TIMEZONE - FULLNAME EMAIL  - 1.0.0-1
- YOUR_CHANGES
]]

    formmatted_rpm = string.gsub(formmatted_rpm, "PROJECT_NAME", PROJECT_NAME)
    formmatted_rpm = string.gsub(formmatted_rpm, "VERSION", VERSION)
    formmatted_rpm = string.gsub(formmatted_rpm, "SUMARY", SUMARY)

    formmatted_rpm = string.gsub(formmatted_rpm, "LICENSE", LICENSE)
    formmatted_rpm = string.gsub(formmatted_rpm, "DESCRIPITION", DESCRIPITION)
    formmatted_rpm = string.gsub(formmatted_rpm, "PROJECT_URL", URL)
    formmatted_rpm = string.gsub(formmatted_rpm, "FULLNAME", FULLNAME)
    formmatted_rpm = string.gsub(formmatted_rpm, "TIMEZONE", os.date("%a %b %d %Y"))

    formmatted_rpm = string.gsub(formmatted_rpm, "EMAIL", EMAIL)
    formmatted_rpm = string.gsub(formmatted_rpm, "YOUR_CHANGES", YOUR_CHANGES)


    darwin.dtw.write_file(".cache/rpm_static_build/SPECS/project.spec", formmatted_rpm)
    os.execute("mkdir -p .cache/rpm_static_build/RPMS")

    local image = darwin.ship.create_machine("almalinux:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("dnf install rpm-build rpmdevtools -y")
    image.add_comptime_command("dnf install gcc -y")
    image.add_comptime_command("rpmdev-setuptree")
    image.start({
        flags = {
            "-it "
        },
        volumes = {
            { "./.cache/rpm_static_build/SOURCES", "/root/rpmbuild/SOURCES" },
            { "./.cache/rpm_static_build/SPECS",   "/root/rpmbuild/SPECS" },
            { "./.cache/rpm_static_build/RPMS",    "/root/rpmbuild/RPMS" }
        },
        command = "rpmbuild -ba ~/rpmbuild/SPECS/project.spec"
    })

    local rpms = darwin.dtw.list_files_recursively(".cache/rpm_static_build/RPMS", true)
    for _, file in ipairs(rpms) do
        if darwin.dtw.ends_with(file, ".rpm") then
            --it will have only one rpm
            darwin.dtw.copy_any_overwriting(file, "release/rpm_static_build.rpm")
            break
        end
    end
end

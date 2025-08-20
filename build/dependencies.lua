function Install_all_dependencies()
    local hasher = darwin.dtw.newHasher()
    hasher.digest_folder_by_content("dependencies")
    local EXPECTED_HASH = '3e068ac738d936a994acb8e3982e3896bfefbc77530e75cf5ef6ca83e67bd464'
    if hasher.get_value() == EXPECTED_HASH then
        return
    end

    darwin.dtw.remove_any("dependencies")
    local json = dofile("./build/json.lua")
    local commands = {}

    table.insert(commands, "mkdir dependencies")

    local file = io.open("./packages.json", "r")
    if file then
        local content = file:read("*all")
        file:close()
        local packages_data = json.parse(content)

        for _, dep in ipairs(packages_data.dependencies) do
            if dep.type == "curl" then
                local cmd = string.format("curl -L %s -o %s", dep.url, dep.destination)
                table.insert(commands, cmd)
            elseif dep.type == "git" then
                local cmd = string.format("git clone -b %s %s %s", dep.branch, dep.url, dep.destination)
                table.insert(commands, cmd)
            end
        end
    else
        error("Could not open packages.json")
    end

    for _, cmd in ipairs(commands) do
        os.execute(cmd)
    end

    darwin.dtw.remove_any("dependencies/candangoEngine/.git")

    local new_hasher = darwin.dtw.newHasher()
    new_hasher.digest_folder_by_content("dependencies")
    print("dependencie hash: " .. new_hasher.get_value())
end
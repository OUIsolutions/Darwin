function main()
    local action = arg[2]

    if not action then
        private_darwin.print_red(string.format("action not provided type help to get informatons\n", action))
        return
    end

    if private_darwin.is_inside({ "build", "--build" }, action) then
        local darwin_conf_file = arg[3]
        if not darwin_conf_file then
            darwin_conf_file = "darwinconf.lua"
        end
        if not io.open(darwin_conf_file) then
            private_darwin.print_red(darwin_conf_file .. " not provided\n")
            return
        end
        private_darwin.print_blue("starting: " .. darwin_conf_file .. "\n")
        dofile(darwin_conf_file)
        return
    end
    if private_darwin.is_inside({ "start", "--start" }, action) then
        private_darwin.print_blue("starting examples\n")
        return
    end

    if private_darwin.is_inside({ "list", "examples", "list-examples", "--list", "--examples", "--list-examples" }, action) then
        for i = 1, #private_darwin.actions do
            local current = private_darwin.actions[i]
            private_darwin.print_blue(string.format("%s:", current.name))
            private_darwin.print_green(string.format("%s\n", current.description))
        end
        return
    end

    if private_darwin.is_inside({ "help", "--help" }, action) then
        private_darwin.print_blue(PRIVATE_DARWIN_ASSETS["help.txt"])
        return
    end

    if private_darwin.is_inside({ "about", "--about" }, action) then
        private_darwin.print_blue(PRIVATE_DARWIN_ASSETS["about.txt"])
        return
    end
    private_darwin.print_red(string.format("invalid action:%s, type help to get informatons\n", action))
end

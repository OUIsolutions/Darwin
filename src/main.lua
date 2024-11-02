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
        private_darwin.print_blue("creating blueprint: " .. darwin_conf_file .. "\n")
        dofile(darwin_conf_file)
        return
    end
    if private_darwin.is_inside({ "start", "--start", "start-example", "--start-example" }, action) then
        local example = arg[3]
        if not example then
            private_darwin.print_red("example not passed\n")
            return
        end

        private_darwin.print_red(string.format("example:%s not found\n", example))
        return
    end

    if private_darwin.is_inside({ "list", "examples", "list-examples", "--list", "--examples", "--list-examples" }, action) then
        local elements = private_darwin.list_assets("examples")
        for i = 1, #elements do
            local current = elements[i]
            private_darwin.print_green(string.format("%s:", current))
            local description = private_darwin.get_asset(string.format("examples/%s/description.txt", current))
            description = string.gsub(description, '\n', "")
            private_darwin.print_blue(string.format("%s\n", description))
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

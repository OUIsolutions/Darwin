function main()
    local action = arg[1]
    if action == "build" then
        local darwin_conf_file = arg[2]
        if not io.open(darwin_conf_file) then
            private_darwin.print_red(darwin_conf_file .. " not provided\n")
            return
        end
        private_darwin.print_blue("starting: " .. darwin_conf_file .. "\n")
        dofile(darwin_conf_file)
    elseif action == "start" then
        private_darwin.print_blue("starting examples\n")
    else
        private_darwin.print_red("Invalid action\n")
    end
end

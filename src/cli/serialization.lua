
function Global_configure()
    local prop = darwin.argv.get_next_unused()
    if not prop then
        private_darwin.print_red("prop not provided\n")
        return
    end
    local value = darwin.argv.get_next_unused()
    if not value then
        private_darwin.print_red("value not provided\n")
        return
    end
    darwin.configure_global(prop, value)
end
function Get_global_config()
    local prop = darwin.argv.get_next_unused()
    local data = darwin.get_global_config(prop)
    if not data then
        private_darwin.print_red("No value found for that property\n")
        return
    end
    private_darwin.print_green("Value: " .. tostring(data) .. "\n")
end

function Local_configure()
    local prop = darwin.argv.get_next_unused()
    if not prop then
        private_darwin.print_red("prop not provided\n")
        return
    end
    local value = darwin.argv.get_next_unused()
    if not value then
        private_darwin.print_red("value not provided\n")
        return
    end
    darwin.configure_local(prop, value)
end

function Get_local_config()
    local prop = darwin.argv.get_next_unused()
    local data = darwin.get_local_config(prop)
    if not data then
        private_darwin.print_red("No value found for that property\n")
        return
    end
    private_darwin.print_green("Value: " .. tostring(data) .. "\n")
end

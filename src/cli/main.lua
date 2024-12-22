---typestart
---@class PrivateDarwin
---@field main fun()
---typeend

private_darwin.main = function()
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

    private_darwin.print_red(string.format("invalid action:%s, type help to get informatons\n", action))
end

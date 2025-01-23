---typestart
---@class PrivateDarwin
---@field main fun()
---typeend

private_darwin.main = function()
    darwin.argv.get_arg_by_index(1)
    if darwin.argv.one_of_args_exist("run_blueprint") then
        Perform_blue_print()
    end

    if darwin.argv.one_of_args_exist("drop_types") then
        Drop_types()
    end
    local unused_index = darwin.argv.get_next_unused_index()
    if unused_index then
        local unused_arg = darwin.argv.get_arg_by_index(unused_index)
        local msg = "arg:" .. unused_arg .. " at index: " .. unused_index .. "its unused"
        private_darwin.print_red(msg)
    end
end

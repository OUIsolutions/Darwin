---typestart
---@class PrivateDarwin
---@field main fun()
---typeend

private_darwin.main = function()
    local action = darwin.argv.get_arg_by_index(2)
    if not action then
        private_darwin.print_red("action not passed")
    end
    if action == "run_blueprint" then
        Perform_blue_print()
    elseif action == "drop_types" then
        Drop_types()
    else

    end
end

---typestart
---@class PrivateDarwin
---@field main fun()
---typeend

private_darwin.main = function()
    darwin.argv.get_arg_by_index(1)
    if darwin.argv.one_of_args_exist("run_blueprint") then
        Perform_blue_print()
    elseif darwin.argv.one_of_args_exist("drop_types") then
        Drop_types()
    elseif darwin.argv.one_of_args_exist("drop_lua_cembed") then
        Drop_lua_cembed()   
    else
        Default_execution()
    end

  
end

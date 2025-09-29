---typestart
---@class PrivateDarwin
---@field main fun()
---typeend

private_darwin.main = function()
    darwin.argv.get_arg_by_index(1)
    if darwin.argv.one_of_args_exist({"run_blueprint","run_blueprints"}) then
        Perform_blue_print()
    elseif darwin.argv.one_of_args_exist({"list_blueprints","list_blueprint","list"}) then
        Describe_blue_prints()
    elseif darwin.argv.one_of_args_exist({"install_deps","install"}) then
        dep_solver()
    elseif darwin.argv.one_of_args_exist("drop_types") then
        Drop_types()
    elseif darwin.argv.one_of_args_exist("drop_lua_cembed") then
        Drop_lua_cembed()
    elseif darwin.argv.one_of_args_exist("set_global_config") then
        Global_configure()
    elseif darwin.argv.one_of_args_exist("get_global_config") then
         Get_global_config()
    elseif darwin.argv.one_of_args_exist("set_local_config") then
        Local_configure()
    elseif darwin.argv.one_of_args_exist("get_local_config") then
        Get_local_config()
    elseif darwin.argv.flags_exist({ "help" }) or darwin.argv.one_of_args_exist("help") then
        Drop_help()
    elseif darwin.argv.flags_exist({ "version" }) or darwin.argv.one_of_args_exist("version") then
        print("darwin "..darwin.version)
    else
        Default_execution()
    end
end

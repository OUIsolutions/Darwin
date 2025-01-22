private_darwin_project.add_c_external_code = function(selfob, code)
    selfob.c_external_code[#selfob.c_external_code + 1] = code
end

private_darwin_project.add_c_include = function(selfob, file)
    local include_code = string.format('#include "%s"\n', file)
    private_darwin_project.add_c_external_code(selfob, include_code)
end


private_darwin_project.add_c_call = function(selfob, func_name)
    local c_call = string.format("%s(darwin_main_obj)", func_name)
    selfob.c_main_code[#selfob.c_main_code + 1] = c_call
end


private_darwin_project.load_lib_from_c = function(selfob, lib_start_func, lua_obj)
    local c_call = string.format(
        "LuaCEmbed_load_lib_from_c(darwin_main_obj,%s,%q)",
        lib_start_func,
        lua_obj
    )

    selfob.c_main_code[#selfob.c_main_code + 1] = c_call
end

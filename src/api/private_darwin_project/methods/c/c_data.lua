private_darwin_project.add_c_external_code = function(selfob, code)
    selfob.c_external_code[#selfob.c_external_code + 1] = code
end

private_darwin_project.add_c_include = function(selfobj, file)
    local include_code = string.format('#include "%s"\n', file)
    private_darwin_project.add_c_external_code(selfobj, include_code)
end

private_darwin_project.add_c_file = function(selfobj, filename, follow_includes, verifier_callback)
    if not follow_includes then
        selfobj.c_external_code[#selfobj.c_external_code + 1] = darwin.file_stream(filename)
        return
    end
end

private_darwin_project.add_c_call = function(selfob, func_name)
    local c_call = string.format("%s(darwin_main_obj);", func_name)
    selfob.c_main_code[#selfob.c_main_code + 1] = c_call
end


private_darwin_project.load_lib_from_c = function(selfobj, lib_start_func, lua_obj)
    local c_call = string.format(
        "LuaCEmbed_load_lib_from_c(darwin_main_obj,%s,%q);",
        lib_start_func,
        lua_obj
    )
    print("hamou aqui")
    selfobj.c_main_code[#selfobj.c_main_code + 1] = c_call
end

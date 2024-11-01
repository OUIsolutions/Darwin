darwin.add_c_code = function(code)
    private_darwin.include_code = private_darwin.include_code .. code
end

darwin.c_include = function(lib)
    darwin.add_c_code(string.format('#include "%s"', lib))
end

darwin.add_c_internal = function(code)
    private_darwin.c_calls = private_darwin.c_calls .. code
end


darwin.load_lualib_from_c = function(function_name, object_name)
    darwin.add_c_internal(string.format(
        'LuaCEmbed_load_lib_from_c(main_obj,%s, "%s");\n',
        function_name,
        object_name
    ))
end

---@param function_name string
darwin.call_c_func = function(function_name)
    darwin.add_c_internal(string.format(
        '%s(main_obj);\n',
        function_name
    ))
end

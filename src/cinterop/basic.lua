---@param  code string
function Add_c_code(code)
    PrivateDarwin_include_code = PrivateDarwin_include_code .. code
end

---@param code string
function Add_c_internal(code)
    PrivateDarwin_c_calls = PrivateDarwin_c_calls .. code
end

---@param function_name string
---@param object_name string
function Load_lualib_from_c(function_name, object_name)
    Add_c_internal(string.format(
        'LuaCEmbed_load_lib_from_c(main_obj,%s, "%s");\n',
        function_name,
        object_name
    ))
end

---@param function_name string
function Call_c_func(function_name)
    Add_c_internal(string.format(
        '%s(main_obj);\n',
        function_name
    ))
end

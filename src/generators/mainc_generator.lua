MAIN_C = [[
    darwin_luacembed
    int main(){
    unsigned char exec_code[] = darwin_execcode;
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
        LuaCEmbed_load_native_libs(main_obj);
        darwin_cglobals
        LuaCEmbed_evaluate(main_obj, "%s",(const char*)exec_code);
        if(LuaCEmbed_has_errors(main_obj)){
            printf("%s\n",LuaCEmbed_get_error_message(main_obj));
        }
        LuaCEmbed_free(main_obj);
    }
]]
---@return string
function Generate_c_executable_code()
    local main_lua_code = PrivateDarwing_Create_c_str_buffer(
        Generate_lua_code()
    )

    local replacers = {
        { item = "darwin_luacembed", value = LUA_CEMBED },
        { item = "darwin_cglobals",  value = PrivateDarwin_cglobals },
        { item = "darwin_execcode",  value = main_lua_code },
    }
    local final = MAIN_C
    for i = 1, #replacers do
        local current = replacers[i]

        final = PrivateDarwingreplace_simple(final, current.item, current.value)
    end
    return final
end

---@param filename string
function Generate_c_executable_output(filename)
    io.open(filename, "w"):write(Generate_c_executable_code()):close()
end

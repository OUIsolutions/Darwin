{{if private_darwin.include_lua_cembed then}
    {!private_darwin.get_asset("LuaCEmbed.h")}
}

{private_darwin.include_code}

int luaopen_{private_darwin.lib_name}(lua_State *state){private_darwin.OPEN}
    //functions will be only assescible by the required reciver
    LuaCEmbed *main_obj = newLuaCEmbedLib(state);

    {private_darwin.cglobals}
    {private_darwin.c_calls}

    LuaCEmbed_evaluate(main_obj,"{private_darwin.PERCENT}s",(const char[]){private_darwin.darwin_execcode});


    if(LuaCEmbed_has_errors(main_obj)) {private_darwin.OPEN}
        char *error = LuaCEmbed_get_error_message(main_obj);
        lua_pushstring(main_obj->state, error);
        LuaCEmbed_clear_errors(main_obj);
        lua_error(main_obj->state);
        return 0;
    {private_darwin.CLOSE}

    {{if private_darwin.object_export then}
        lua_getglobal(main_obj->state,"my_project");
       return  1;
    }
    return 0;

{private_darwin.CLOSE}

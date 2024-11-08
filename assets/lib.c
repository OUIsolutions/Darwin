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
        LuaCEmbed_dangerous_raise_self_error_jumping(main_obj);
        return 0;
    {private_darwin.CLOSE}

    {{if private_darwin.object_export then}
        return  LuaCembed_send_global_as_lib(main_obj,"{private_darwin.object_export}");
    {%else}
        return 0;
    }

{private_darwin.CLOSE}

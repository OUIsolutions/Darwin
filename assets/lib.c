
{{if private_darwin.include_lua_cembed then}
    {!private_darwin.get_asset("LuaCEmbed.h")}
{%end}

{private_darwin.include_code}

#define OPEN {private_darwin.OPEN}
#define CLOSE {private_darwin.CLOSE}


int luaopen_{private_darwin.lib_name}(lua_State *state)OPEN
    //functions will be only assescible by the required reciver
    LuaCEmbed * l  = newLuaCEmbedLib(state);

    {private_darwin.cglobals}
    {private_darwin.c_calls}

    LuaCEmbed_evaluate(main_obj,"{private_darwin.PERCENT}s",(const char[]){private_darwin.darwin_execcode});


    if(LuaCEmbed_has_errors(main_obj)) OPEN
        return 0;
    CLOSE

    {{if private_darwin.lib_object then}
        lua_getglobal(self->state,"{private_darwin.lib_object}");
        return 1;
    {%else}
        return 0;
    }

CLOSE

#undef OPEN
#undef  CLOSE

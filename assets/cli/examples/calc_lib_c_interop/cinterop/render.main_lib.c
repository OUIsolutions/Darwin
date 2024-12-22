
#include "LuaCEmbed.h"

LuaCEmbedNamespace  lua_n;


LuaCEmbedResponse  *mull_func(LuaCEmbed *args){private_darwin.OPEN}
    double first_num = lua_n.args.get_double(args,0);
    double second_num = lua_n.args.get_double(args,1);

    if(lua_n.has_errors(args)){private_darwin.OPEN}
        char *message = lua_n.get_error_message(args);
        return lua_n.response.send_error(message);
    {private_darwin.CLOSE}

    double result = first_num * second_num;
    return lua_n.response.send_double(result);
{private_darwin.CLOSE}

LuaCEmbedResponse  *div_func(LuaCEmbed *args){private_darwin.OPEN}
    double first_num = lua_n.args.get_double(args,0);
    double second_num = lua_n.args.get_double(args,1);

    if(lua_n.has_errors(args)){private_darwin.OPEN}
        char *message = lua_n.get_error_message(args);
        return lua_n.response.send_error(message);
    {private_darwin.CLOSE}
    double result = first_num / second_num;
    return lua_n.response.send_double(result);
    {private_darwin.CLOSE}

LuaCEmbedResponse  *add_cfunc(LuaCEmbed *args){private_darwin.OPEN}
    double first_num = lua_n.args.get_double(args,0);
    double second_num = lua_n.args.get_double(args,1);

    if(lua_n.has_errors(args)){private_darwin.OPEN}
        char *message = lua_n.get_error_message(args);
        return lua_n.response.send_error(message);
    {private_darwin.CLOSE}

    double result = first_num + second_num;
    return lua_n.response.send_double(result);
{private_darwin.CLOSE}

LuaCEmbedResponse  *sub_cfunc(LuaCEmbed *args){private_darwin.OPEN}
    double first_num = lua_n.args.get_double(args,0);
    double second_num = lua_n.args.get_double(args,1);

    if(lua_n.has_errors(args)){private_darwin.OPEN}
        char *message = lua_n.get_error_message(args);
        return lua_n.response.send_error(message);
    {private_darwin.CLOSE}

    double result = first_num - second_num;
    return lua_n.response.send_double(result);
{private_darwin.CLOSE}


int luaopen_private_{private_darwin.project_name}_cinterop(lua_State *state){private_darwin.OPEN}
    lua_n = newLuaCEmbedNamespace();
    //functions will be only assescible by the required reciver
    LuaCEmbed * l  = lua_n.newLuaLib(state);
    lua_n.add_callback(l,"add",add_cfunc);
    lua_n.add_callback(l,"sub",sub_cfunc);
    lua_n.add_callback(l,"div",div_func);
    lua_n.add_callback(l,"mull",mull_func);
return lua_n.perform(l);
{private_darwin.CLOSE}

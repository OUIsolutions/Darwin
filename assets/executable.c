

{!private_darwin.get_asset("LuaCEmbed.h")}
{private_darwin.include_code}


int main(int argc,char *argv[]) {private_darwin.OPEN}
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_load_native_libs(main_obj);

    LuaCEmbedTable *args_table =LuaCembed_new_global_table(main_obj,"arg");
    for(int i =0; i <argc;i++) {private_darwin.OPEN}
            LuaCEmbedTable_append_string(args_table,argv[i]);
    {private_darwin.CLOSE}
    {private_darwin.cglobals}
    {private_darwin.c_calls}
    LuaCEmbed_evaluate(main_obj,"{private_darwin.PERCENT}s",(const char[]){private_darwin.darwin_execcode});
    if(LuaCEmbed_has_errors(main_obj)) {private_darwin.OPEN}
        printf("{private_darwin.PERCENT}s",LuaCEmbed_get_error_message(main_obj));
    {private_darwin.CLOSE}

    LuaCEmbed_free(main_obj);
{private_darwin.CLOSE}

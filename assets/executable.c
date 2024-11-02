

{PRIVATE_DARWIN_ASSETS["LuaCEmbed.h"]}
{private_darwin.include_code}

#define OPEN {private_darwin.OPEN}
#define CLOSE {private_darwin.CLOSE}


int main(int argc,char *argv[]) OPEN
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_load_native_libs(main_obj);

    LuaCEmbedTable *args_table =LuaCembed_new_global_table(main_obj,"arg");
        for(int i =0; i <argc;i++) OPEN
            LuaCEmbedTable_append_string(args_table,argv[i]);
        CLOSE
    {private_darwin.cglobals}
    {private_darwin.c_calls}
    LuaCEmbed_evaluate(main_obj,"{private_darwin.PERCENT}s",(const char[]){private_darwin.darwin_execcode});
    if(LuaCEmbed_has_errors(main_obj)) OPEN
        printf("{private_darwin.PERCENT}s",LuaCEmbed_get_error_message(main_obj));
    CLOSE

    LuaCEmbed_free(main_obj);
CLOSE

#undef OPEN
#undef  CLOSE

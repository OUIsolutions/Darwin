
darwin_luacembed
cincludes
int main(){
LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_load_native_libs(main_obj);
    darwin_cglobals
    ccalls
    LuaCEmbed_evaluate(main_obj, "%s",(const char[])darwin_execcode);
    if(LuaCEmbed_has_errors(main_obj)){
        printf("%s\n",LuaCEmbed_get_error_message(main_obj));
    }
    LuaCEmbed_free(main_obj);
}

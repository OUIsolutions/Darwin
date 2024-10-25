MAIN_C = [[
int main(){
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_load_native_libs(main_obj);
    private_darwing_set_globals(main_obj);
    LuaCEmbed_evaluate(main_obj, "%s",(const char*)exec_code);
    if(LuaCEmbed_has_errors(main_obj)){
        printf("%s\n",LuaCEmbed_get_error_message(main_obj));
    }
    LuaCEmbed_free(main_obj);
}
]]

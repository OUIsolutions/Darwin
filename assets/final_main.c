
// these its just fo facilitate intelisense
// and wont be used in the final code
#ifndef DARWING_BUILD
#include "../dependencies/LuaCEmbed.h"
unsigned char exec_code[10] = {0};
#endif



int main(){
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_load_native_libs(main_obj);

    LuaCEmbed_evaluate(main_obj, "%s",(const char*)exec_code);
    if(LuaCEmbed_has_errors(main_obj)){
        printf("%s\n",LuaCEmbed_get_error_message(main_obj));
    }
    LuaCEmbed_free(main_obj);
}

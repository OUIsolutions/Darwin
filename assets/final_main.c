
#ifndef DARWING_BUILD //these its just fo facilitate intelisense
#include "../dependencies/LuaCEmbed.h"
unsigned char exec_code[10] = {0};
#endif



int main(){
    LuaCEmbed *main_obj = newLuaCEmbedEvaluation();
    LuaCEmbed_evaluate(main_obj, "%s",(const char*)exec_code);
    LuaCEmbed_free(main_obj);
}

#include "dependencies/doTheWorld.h"
#include "dependencies/CTextEngine.h"
#include "dependencies/UniversalGarbage.h"
#include <stdbool.h>

DtwNamespace dtw;
CTextStackModule stack;
int main(){
    dtw = newDtwNamespace();
    stack = newCTextStackModule();
    UniversalGarbage *garbage = newUniversalGarbage();

    long size;

    CTextStack *final = stack.newStack_string_empty();
    UniversalGarbage_add(garbage,stack.free, final);
    //these its requred because there is a debug flag for intelisense
    stack.text(final,"#define DARWING_BUILD\n");

    stack.text(final,"unsigned char lua_code[] = {");
    bool is_binary;
    unsigned char *lua_code = dtw.load_any_content("dependencies/LuaCEmbed.h",&size,&is_binary);
    UniversalGarbage_add_simple(garbage, lua_code);
    for(int i = 0;i< size;i++){
        stack.format(final,"%d,",lua_code[i]);
    }
    stack.text(final,"0};\n");

    stack.text(final,"unsigned char main_code[] ={");
    unsigned char *main_code = dtw.load_any_content("assets/final_main.c",&size,&is_binary);
    UniversalGarbage_add_simple(garbage, main_code);
    for(int i = 0;i< size;i++){
        stack.format(final,"%d,",lua_code[i]);
    }
    stack.text(final,"0};\n");

    char *build_main = dtw.load_string_file_content("assets/build_main.c");
    UniversalGarbage_add_simple(garbage,build_main);

    stack.format(final,"%s",build_main);
    dtw.write_string_file_content("first.c",final->rendered_text);
    UniversalGarbage_free(garbage);

}

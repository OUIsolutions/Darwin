#include "dependencies/doTheWorld.h"
#include "dependencies/CTextEngine.h"
#include "dependencies/UniversalGarbage.h"
#include <stdbool.h>

DtwNamespace dtw;
CTextStackModule stack;
int main(){
    dtw = newDtwNamespace();
    stack = newCTextStackModule();

    long size;

    CTextStack *final = stack.newStack_string_empty();
    //these its requred because there is a debug flag for intelisense
    stack.text(final,"#define DARWING_BUILD\n");

    stack.text(final,"unsigned char lua_code[] = {");
    bool is_binary;
    unsigned char *lua_code = dtw.load_any_content("dependencies/LuaCEmbed.h",&size,&is_binary);

    for(int i = 0;i< size;i++){
        stack.format(final,"%d,",lua_code[i]);
    }
    stack.text(final,"0};\n");






}

#include "dependencies/doTheWorld.h"
#include "dependencies/CTextEngine.h"
#include <stdbool.h>

DtwNamespace dtw;
CTextStackModule stack;
int main(){
    dtw = newDtwNamespace();
    stack = newCTextStackModule();

    long size;
    bool is_binary;
    unsigned char *content = dtw.load_any_content("dependencies/LuaCEmbed.h",&size,&is_binary);
    CTextStack *s = stack.newStack_string("unsigned char lua_code[] = {");
    for(int i = 0;i< size;i++){
        stack.format(s,"%d,",content[i]);
    }
    stack.text(s,"0};");
    dtw.write_string_file_content("assets/lua_code.h",s->rendered_text);
    stack.free(s);
    free(content);
}

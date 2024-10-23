
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <sys/file.h>
#include <sys/time.h>


#ifdef __linux__
#include <sys/wait.h>
  #include <dirent.h>
  #include <unistd.h>
#elif _WIN32
  #include <windows.h>
  #include <tchar.h>
  #include <wchar.h>
  #include <locale.h>
  #include <direct.h>
#endif


unsigned char *load_any_content(const char * path,long *size,bool *is_binary){

    *is_binary = false;
    *size = 0;


    FILE  *file = fopen(path,"rb");

    if(file ==NULL){
        return NULL;
    }


    if(fseek(file,0,SEEK_END) == -1){
        fclose(file);
        return NULL;
    }


    *size = ftell(file);

    if(*size == -1){
        fclose(file);
        return NULL;
    }

    if(*size == 0){
        fclose(file);
        return NULL;
    }


    if(fseek(file,0,SEEK_SET) == -1){
        fclose(file);
        return NULL;
    }

    unsigned char *content = (unsigned char*)malloc(*size +1);
    int bytes_read = fread(content,1,*size,file);
    if(bytes_read <=0 ){
        free(content);
        fclose(file);
        return NULL;
    }


    *is_binary = false;
    for(int i = 0;i < *size;i++){
        if(content[i] == 0){
            *is_binary = true;
            break;
        }
    }
    content[*size] = '\0';

    fclose(file);
    return content;
}

char *load_string_file_content(const char * path){
    long size;
    bool is_binary;
    unsigned char *element = load_any_content(path,&size,&is_binary);
    if(element == NULL){
        return NULL;
    }

    if(is_binary){
        free(element);
        return NULL;
    }
    return (char*)element;
}

#ifndef  DARWING_BUILD
unsigned char lua_code [10] ={0};
unsigned char main_code[10] = {0};


#endif


int main(int argc,char *argv[]){

    if(argc < 2){
        printf("file not provided\n");
        return 1;
    }

    char *file = load_string_file_content(argv[1]);
    if(file == NULL){
        printf("file not provided\n");
        return 1;
    }

    char *required_size = (char*)calloc(
        sizeof(lua_code) + sizeof(main_code) + (size_t)strlen(file)
        ,sizeof(char)
    );




}

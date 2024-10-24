
#ifndef DARWING_BUILD
unsigned char lua_code[] = "lua code\n";
unsigned char main_code[] = "main code\n";

#endif

#include <string.h>
#include <time.h>
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
#define static_str_size(str) sizeof(str)-1

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

bool write_any_content(const char *path,unsigned  char *content,long size){
    //Iterate through the path and create directories if they don't exist
    FILE *file = fopen(path,"wb");
    if(file == NULL){

        return false;
    }

    fwrite(content, sizeof(char),size, file);

    fclose(file);
    return true;
}


void concat_str(
     char *dest,
    const  char *value,
    int value_size,
    int *acumulated_size
){
    memcpy((dest+ *acumulated_size),value,value_size);
    *acumulated_size+=value_size;
}

int main(int argc,char *argv[]){

    if(argc < 3){
        printf("args not provided not provided \n");
        return 1;
    }

    bool is_binary;
    long size;
    unsigned char *file = load_any_content(argv[1],&size,&is_binary);
    if(file == NULL){
        printf("file not provided\n");
        return 1;
    }

    if(is_binary){
        free(file);
        printf("its not a valid file\n");
        return 1;
    }
    const int BUFFER_SIZE = 6;
    const int SECURITY_EXTRA_SIZE = 200;
    int required_final_size = (size * BUFFER_SIZE) +
        sizeof(lua_code) +
        sizeof(main_code) +
        SECURITY_EXTRA_SIZE;

    char *final = (char*)calloc(required_final_size, sizeof(unsigned char));
     int actual_size = 0;


    const char  darwing_build[] ="#define DARWING_BUILD\n";
    concat_str(final,darwing_build, static_str_size(darwing_build),&actual_size);

    concat_str(final,(char*)lua_code,static_str_size(lua_code),&actual_size);

    const char start[]  = "unsigned char exec_code[] = {";
    concat_str(final,start,static_str_size(start),&actual_size);

    for(int i = 0; i< size; i++){
        char buffer[BUFFER_SIZE];
        int buffer_size = sprintf(buffer,"%d,", file[i]);
        concat_str(final,buffer,buffer_size,&actual_size);
    }

    const char end_acumulator[] = "0};\n";
    concat_str(final,end_acumulator,static_str_size(end_acumulator),&actual_size);
    concat_str(final,(char*)main_code,static_str_size(main_code),&actual_size);
    write_any_content(argv[2],(unsigned char*)final,actual_size);
    free(final);
    free(file);
}

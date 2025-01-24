## Compilations

### Linux Compilation
these generate a basic linux compilation

```shell
darwin main.lua -o my_program.out  
```

### Windows Compilation
```shell
darwin main.lua -o my_program.exe
```
### Setting Compiler
you can set compilers and flags, in windows compilation,the default compiler its 
**"i686-w64-mingw32-gcc** and  on linux its **gcc** ,but you can set the compiler with 
**compiler** flag 
```shell
darwin main.lua -o my_program.out  -compiler clang
```
### Setting flags 
its also possible to set  compilation flags with the **flags** flag 
```shell
darwin main.lua -o my_program.out  -compiler clang -flags -DMY_DEFINITION -flags-static
```

### Embedding Global Variables
you can embed data into your priject, you just need to especify the **--embed_vars** flags 

```shell 
darwin main.lua -o my_program.out  -embed_vars my_image -my_image:file my_file.png 
```
you can embed  **files**, **folders** and **text**, just change :file for :folder or :text


### Generating Blue Prints
if you need to make the you compilation props into a **darwinconf.lua** file , you can make your generation by passing a file to be **interpreted** 
```shell
./darwin.out  run_blueprint props.lua 
```
if you dont pass the **props.lua** darwin will try to open a  **darwinconf.lua**  file 

### Generating Blue Prints by  folder 
you also can generate a blue print by folder ,but you need to specify the mode as **folder**, and your code 
must have a **main** function,since it will load recursively all files of the folder, then 
call the **main** function

```shell
./darwin.out  run_blueprint my_folder -mode folder 
```
### Adding C include files

you can add c include files to your project by passing the **-c_include** flag 
```shell
darwin main.lua -o my_program.out  -c_include my_include.h
```

### Adding C Calls 
you can add c calls to your project by passing the **-c_calls** flag 
```shell
darwin main.lua -o my_program.out  -c_calls my_func
```
note that the **my_func** must be a function that is defined in the **c_include** file
and must follow the following signature 
```c
void my_c_function(LuaCEmbed *lua);
```

###  Load a C Library
you can load a c library by passing the **-c_lib** flag 
```shell
darwin main.lua -o my_program.out  --lib_objects dtw --dtw:func load_luaDoTheWorld 
```

### Adding a amalgamation 
you can add a amalgamation to your project by passing the **-amalgamation** flag 
```shell
darwin main.lua -o my_program.out  -amalgamation my_amalgamation.c
```

## Compilations

### Linux Compilation
these generate a basic linux compilation

```lua
darwin main.lua -o my_program.out  
```

### Windows Compilation
```lua
darwin main.lua -o my_program.exe
```
### Setting Compiler
you can set compilers and flags, in windows compilation,the default compiler its 
**"i686-w64-mingw32-gcc** and  on linux its **gcc** ,but you can set the compiler with 
**compiler** flag 
```lua
darwin main.lua -o my_program.out  -compiler clang
```
### Setting flags 
its also possible to set  compilation flags with the **flags** flag 
```lua
darwin main.lua -o my_program.out  -compiler clang flags:-DMY_DEFINITION flags:--static
```

### Embedding Global Variables
you can embed data into your priject, you just need to especify the **--embed_vars** flags 

```lua 
darwin main.lua -o my_program.out  -embed_vars my_image -my_image:file my_file.png 
```
you can embed , **files** 


### Generating Blue Prints
if you need to make the you compilation props into a **darwinconf.lua** file , you can make your generation by passing a file to be **interpreted** 
```lua
./darwin.out  run_blueprint props.lua 
```
if you dont pass the **props.lua** darwin will try to open a  **darwinconf.lua**  file 

### Generating Blue Prints by  folder 
you also can generate a blue print by folder ,but you need to specify the mode as **folder**, and your code 
must have a **main** function,since it will load recursively all files of the folder, then 
call the **main** function

```lua
./darwin.out  run_blueprint my_folder -mode folder 
```

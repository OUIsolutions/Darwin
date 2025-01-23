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
### Seting flags 
its also possible to set  compilation flags with the **flags** flag 
```lua
darwin main.lua -o my_program.out  -compiler clang flags:-DMY_DEFINITION flags:--static
```


# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.005/darwin005.c)
by typing
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.005/darwin005.c -o darwin005.c
```

Create the **darwinconf.lua** file, these file configure the entire project ,to you

```lua
Embedglobal("hello_msg", "hello world")
Addcode("print(hello_msg)")
Generate_c_executable_output("saida.c")
Generate_lua_output("saida.lua")
os.execute("g++ saida.c ")
os.execute("./a.out")
```
and run with:
```shel
gcc darwin005.c -o darwin005.o && ./darwin005.o
```
### Understanding Commands

### Addfile
Add a lua file to be embed into the final  code

### Addcode
Add code to be interpreted

### Embedglobal
Embed anything to the final executable,it works for any type of object ,(except for functions)
if you pass "lua" as the 3 parameter, it will embed into the final lua


### Generators
there is a lot of generators , that can be used to generate exports, for a lot
of formats

### Generate_c_executable_output
export to a final *c* file , with a full runable executable code

### Generate_lua_output
Generate a full lua code, with all the elements you added

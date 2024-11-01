# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.006/darwin006.c)
by typing
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.006/darwin006.c -o darwin006.c
```

Create the **darwinconf.lua** file, these file configure the entire project ,to you

```lua
darwin.embedglobal("hello_msg", "hello world")
darwin.add_lua_code("print(hello_msg)")
darwin.generate_c_executable_output("saida.c")
darwin.generate_lua_output("saida.lua")
os.execute("g++ saida.c ")
os.execute("./a.out")


```
and run with:
```shel
gcc darwin006.c -o darwin006.o && ./darwin006.o
```
### Getting type anotations
if you need to get type annotations

### Understanding Commands

### darwin.add_lua_file
Add a lua file to be embed into the final  code

### darwin.add_lua_code
Add code to be interpreted

### darwin.embedglobal
Embed anything to the final executable,it works for any type of object ,(except for functions)
if you pass "lua" as the 3 parameter, it will embed into the final lua


### Generators
there is a lot of generators , that can be used to generate exports, for a lot
of formats

### darwin.generate_c_executable_output
export to a final *c* file , with a full runable executable code

### darwin.generate_lua_output
Generate a full lua code, with all the elements you added

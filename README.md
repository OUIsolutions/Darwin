# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.010/darwin010.c)
and [Type Anotations](https://github.com/OUIsolutions/Darwin/releases/download/0.010/types010.lua)
by typing
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.010/darwin010.c -o darwin010.c &&
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.010/types010.lua -o types010.lua

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
gcc darwin010.c -o darwin010.o && ./darwin010.o
```

### Understanding Commands

#### darwin.add_lua_file

Add a lua file to be embed into the final  code

```lua
darwin.add_lua_file("main.lua")
```

#### darwin.add_lua_code
Add code to be interpreted
```lua
darwin.add_lua_code("print(hello_msg)")
```


#### darwin.embedglobal
Embed anything to the final executable,it works for any type of object ,(except for functions)
if you pass "lua" as the 3 parameter, it will embed into the final lua
```lua
darwin.embedglobal("hello_msg", "hello world")
```

### Generators
there is a lot of generators , that can be used to generate exports, for a lot
of formats

#### darwin.generate_c_executable_output
export to a final *c* file , with a full runable executable code
```lua
darwin.generate_c_executable_output("saida.c")
```
#### darwin.generate_lua_output
Generate a full lua code, with all the elements you added
```lua
darwin.generate_lua_output("saida.lua")
```
### CInterop
#### darwin.add_c_code
Add C code to the final **.c** file

```lua
darwin.add_c_code('#include "your lib here"')
```

#### darwin.add_c_file
Add C file to your project,if you pass true as second argument (folow_includes) ,it will follow
all the **#includes** of the file, and embed into the **final.c** file
```lua
  local follow = true
 darwin.add_c_file("your c file", follow)
```
#### darwin.c_include
Include your lib into the final **c** code

```lua
darwin.c_include('your lib path')
```
#### darwin.add_c_internal
Calls includes C code into your **main** code
```lua
darwin.add_c_internal('printf("test\n");')
```
#### darwin.load_lualib_from_c
Loads a LuaLib into your code, note that the lib must follow the standard lua format
```c
int load_luaDoTheWorld(lua_State *state);
```
```lua
darwin.load_lualib_from_c("load_luaDoTheWorld", "dtw")
```

#### darwin.call_c_func
Calls a C func passing the LuaCEmbed object to it,
Note that your C func, must recive the **LuaCEmbed** object as argument
```c
void your_func(LuaCEmbed *l);
```
```lua
darwin.call_c_func("your_func")
```
### LuaDotheWorld
Note that Darwin has [LuaDotheWorld](https://github.com/OUIsolutions/LuaDoTheWorld) Embed inside
as **dtw** ,so , any function of dotheWorld, will work at  **darwinconf.lua**
```lua
local src_files = dtw.list_files_recursively("src", true)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_file(current)
end
```

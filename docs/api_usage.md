
## Project Explanation
the first thing you need to do, its to create a a project,then you can add lua and C code to it
```lua
project = darwin.create_project("teste")
```
### Working with Lua

## Adding lua Code 
you can add what ever lua code you want by calling **project.add_lua_code**
```lua
project.add_lua_code("print('Hello World!')")
```
## Adding Lua File
you also can add a lua file to your project 
```lua
project.add_lua_file("test.lua")
```

## Adding lua File Following Require 
you can add a lua file ,and follow all **requires** and **packages.load_lib** of your code, 
and them embed into your final code with
```lua
project.add_lua_file_following_require("test.lua")
```
### Working With C 


### Adding C include 
you can add a C include file to be included into your main code 
```lua 
project.add_c_include("teste.c")
```

### Adding C File 
you also can add a C file directly, and you also can decide to include all the itens of file recusively
```lua
local follow_require = true 
local verifier_callback = function (import,path)
    print("import",import)
    print("path",path)
    print("----------------")
    --if you return false the file will not be added
    return true
end 
project.add_c_file("LuaDoTheWorld/src/one.c",true,verifier_callback)
```

### Adding C call func 
you can set a c function to be called on your main code 
```lua
project.add_c_call("my_c_function")
```
these function must accet **LuaCEmbed** as first argument and return void
```c
void my_c_function(LuaCEmbed *lua)
{
    printf("Hello World\n");
}
```

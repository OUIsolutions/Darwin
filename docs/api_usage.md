
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

### Generatig lua output
you can generate a lua file with:
```lua
project.generate_lua_file({output="my_out.lua",include_embed_data=true})
```
you also can get the lua code generation with:
```lua
local code = project.generate_lua_code({include_embed_data=true})
```
if you need , you can generate lua code streaming data to what ever you want 
```lua
project.generate_lua_complex({

    stream=function(s) 
        print(s) 
    end,
    include_embed_data=true
})
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
these function must accept **LuaCEmbed** as first argument and return void,for having 
[LuaCEmbed.c](https://github.com/OUIsolutions/LuaCEmbed) file  run: 
```bash
darwin drop_lua_cembed
```
function example:
```c

#include "LuaCEmbed.c"
void my_c_function(LuaCEmbed *lua)
{
    printf("Hello World\n");
}
```
## Load a C Library
for load a clib, the function must follow the pattern :
```c    
int your_func(lua_State *state);
```
and you can add it to your project with:
```lua
project.load_lib_from_c("your_func","my_output_object")
```
and a global object will be created with the name **my_output_object**


### Generating C output
you can generate a C file with:
```lua
project.generate_c_file({output="mycode.c",include_lua_cembed=true})
```
you also can get the C code generation with:
```lua
local code = project.generate_c_code({include_lua_cembed=true})
```
if you need , you can generate C code streaming data to what ever you want 
```lua
project.generate_c_complex({

    stream=function(s) 
        print(s) 
    end,
    include_lua_cembed=true
})
```

### Generating C lib 
you can generate a C lib with:
```lua
project.generate_c_lib_file({
    output="mycode.c",
    include_lua_cembed=true,
    lib_name="mylib",
    object_export="my_object"
})

```
where lib name will became the name of the lib, with a c function called  **luaopen_mylib** and a global object that will be returned by the function called **my_object**

### Generating C lib Code
you can generate a C lib code with:
```lua
local code = project.generate_c_lib_code({
    include_lua_cembed=true,
    lib_name="mylib",
    object_export="my_object"
})
```

### Generating C lib Code Streaming
if you need , you can generate C lib code streaming data to what ever you want 
```lua
project.generate_c_lib_complex({

    stream=function(s) 
        print(s) 
    end,
    include_lua_cembed=true,
    lib_name="mylib",
    object_export="my_object"
})
```


## Building libs
Darwin Have The Follow libs native

|  Object Name  | Lib Name |
|--------------|---------|
|darwin.camalgamator | [LuaCAmalgamator](https://github.com/OUIsolutions/LuaCAmalgamator) |
|darwin.dtw| [LuaDoTheWorld](https://github.com/OUIsolutions/LuaDoTheWorld)|
|darwin.candango|[candangoEngine](https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine) |
|darwin.json|[LuaFluidJson](https://github.com/OUIsolutions/LuaFluidJson) |
|darwin.argv|[LuaFluidJson](https://github.com/OUIsolutions/LuaArgv) |
|darwin.silverchain|[LuaFluidJson](https://github.com/OUIsolutions/LuaSilverChain) |
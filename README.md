# Darwin
A Boostrapped lua Compiler

## Releases
| item          | plataform |
|-------        |-----------|
| [Amalgamation](https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.c)| Source  |
| [darwin.out](https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.out)|Linux binary|
| [darwin.exe](https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.exe)|Windows binary |


## Compile:
download ando compile darwin  the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.c)
by typing
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.c -o darwin.c &&
gcc darwin.c -o darwin.o
```

## Building from scratch
for building from scratch you will need gcc  installed on your machine,clone the repo and run
```shell
sh download_dependencies.sh
./darwin.out build darwinconf.lua  build_windows build_linux
```


## Building from docker
if you have docker installed on your machine, you can build for all  plataforms suportted  with:
```shell
sh download_dependencies.sh
sh create_all_docker_images.sh
sh build_all_from_docker.sh
```

Then start a example project
```shel
./darwin.out start calc my_project_name
```

Alternativly you can list all the available start examples with:
```shel
./darwin.out list
```

and build with:
```shel
./darwin.out build darwinconf.lua
```
now you can run the final bin with:
```shel
./my_project_name.o 10 + 10
```

### Understanding darwinconf.lua Commands
The **darwinconf.lua** its the **blueprint** of  your project, its where you
can put all the definitions of the project

#### darwin.add_lua_file

Add a lua file to be embed into the final  code

```lua
darwin.add_lua_file("main.lua")
```
#### darwin.unsafe_add_lua_code_following_require
these will ad your files following the 'required' files,note that
these functions uses evaluation and preserve your paths attributes to tthe final
binary, use only on trusted sources, and always make your bins using relative paths
```lua
local include_shared_libs  = true
darwin.unsafe_add_lua_code_following_require("main.lua",include_shared_libs)
```
#### darwin.embed_shared_libs
these functions embed the **.so**,its required if you need some **so** loaded by **unsafe_add_lua_code_following_require**
call these function only after all your loadings ,and these function can be called only once per project (unless darwin.resset_all()
```lua
local mode = "c"
darwin.embed_shared_libs(mode)
```

#### darwin.add_lua_code
Add code to be interpreted
```lua
darwin.add_lua_code("print(hello_msg)")
```


#### darwin.embed_global
Embed anything to the final executable,it works for any type of object ,(except for functions)
if you pass "lua" as the 3 parameter, it will embed into the final lua
```lua
darwin.embed_global("hello_msg", "hello world")
```

### Generators
there is a lot of generators , that can be used to generate exports, for a lot
of formats

#### darwin.generate_c_executable_output
export to a final *c* file , with a full runable executable code
```lua
darwin.generate_c_executable_output({output_name="saida.c"})
```
#### darwin.generate_c_lib_output
export to a lib  *c* file , that can be compiled as a shared lib after
```lua
darwin.generate_c_lib_output({
    libname = "your_lib_name",
    object_export = "the_global_object_you_want_to_export",
    output_name = "your_output.c",
    include_e_luacembed = true
})
```
than you can complie with
```shel
gcc -Wall -shared -fpic -o your_output.so  your_output.c
```



#### darwin.generate_lua_output
Generate a full lua code, with all the elements you added
```lua
darwin.generate_lua_output({output_name="saida.lua"})
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

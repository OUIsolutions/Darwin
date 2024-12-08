# Darwin
A Boostrapped lua Compiler


## Compile:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.013/darwin014.c)
by typing
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.014/darwin014.c -o darwin.c
```
first compile darwin
```shel
gcc darwin.c -o darwin.o
```


## Building from scratch
for building from scratch you will need gcc  installed on your machine,clone the repo and run 
```shell
sh install_dependencies.sh  
./darwin.o build 
```
## Building from docker
if you have docker installed on your machine, you can create a docker image with:
```shell
docker build -t darwin .
```
and then you can run the container with:
```shell 
 docker run  --volume $(pwd)/:/project:z -it  darwin
```
and now , the hole project will be mounted in the **project** folder, inside the container
then , its possible to make the project, type: 
```shell 
cd project/ 
sh install_dependencies.sh 
./darwin.o build 
```

Then start a example project
```shel
./darwin.o start calc my_project_name
```

Alternativly you can list all the available start examples with:
```shel
./darwin.o list
```

and build with:
```shel
./darwin.o build darwinconf.lua
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

### Building from scratch
if you want to build darwin from scratch run:
```shell
sh install_dependencies.sh
sh compiledarwin.sh
sh build.sh
```

### DePendencies:
## Lua:
**Lua** from https://lua.org/

Lua is free software distributed under the terms of the MIT license reproduced here. Lua may be used for any purpose, including commercial purposes, at absolutely no cost. No paperwork, no royalties, no GNU-like "copyleft" restrictions, either. Just download it and use it.

Lua is certified Open Source software. [Open Source Initiative Approved License]Its license is simple and liberal and is compatible with GPL. Lua is not in the public domain and PUC-Rio keeps its copyright.

The spirit of the Lua license is that you are free to use Lua for any purpose at no cost without having to ask us. The only requirement is that if you do use Lua, then you should give us credit by including the copyright notice somewhere in your product or its documentation. A nice, but optional, way to give us further credit is to include a Lua logo and a link to our site in a web page for your product.

The Lua language is entirely designed, implemented, and maintained by a team at PUC-Rio in Brazil. The implementation is not derived from licensed software.


## LuaCEmbed
**LuaCEmbed** from: https://github.com/OUIsolutions/LuaCEmbed
MIT License

Copyright (c) 2024 Mateus Moutinho Queiroz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## LuaDoTheWorld
**LuaDoTheWorld**:from https://github.com/OUIsolutions/LuaDoTheWorld
MIT License

Copyright (c) 2024 OUI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
## DoTheWorld
MIT License
**DoTHeWorld** from: https://github.com/OUIsolutions/DoTheWorld
Copyright (c) 2023 Mateus Moutinho Queiroz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## CJson<br><br>
**CJson**: from https://github.com/DaveGamble/cJSON <br>
Copyright (c) 2009-2017 Dave Gamble and cJSON contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## sha-256 <br>
**sha-256**: from https://github.com/amosnier/sha-2 <br>

Zero Clause BSD License
© 2021 Alain Mosnier

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


## Project Explanation
the first thing you need to do, its to create a a project,then you can add lua and C code to it
```lua
project = darwin.create_project("teste")
```

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

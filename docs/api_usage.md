
# API Usage Guide - Advanced Project Creation

Learn how to create sophisticated Darwin projects using the programmatic API.

## What is the Darwin API?

The Darwin API lets you create blueprint files that define complex compilation setups. Think of it as a recipe for building your project programmatically instead of using long command lines.

### Table of Contents
- [Getting Started](#getting-started)
- [Working with Lua](#working-with-lua)
- [Working with C](#working-with-c)
- [Generation Options](#generation-options)
- [Built-in Libraries](#built-in-libraries)

## Getting Started

### Create Your First Project
Create a blueprint file (e.g., `darwinconf.lua`):

```lua
-- Create a new project
local project = darwin.create_project("MyAwesomeApp")

-- Add your Lua code
project.add_lua_code([[
    print("Hello from my compiled app!")
    print("This was built using Darwin API!")
]])

-- Generate a Linux executable
project.generate_c_file({
    output = "myapp.c",
    include_lua_cembed = true
})
```

Run the blueprint:
```bash
darwin run_blueprint darwinconf.lua
```

Compile the generated C code:
```bash
gcc myapp.c -o myapp.out
./myapp.out
```

Darwin takes your Lua code, wraps it in C, and creates a source file ready for compilation.

## Working with Lua

### Adding Inline Lua Code
For small scripts or configuration:

```lua
local project = darwin.create_project("Calculator")

-- Add simple calculations
project.add_lua_code([[
    function add(a, b)
        return a + b
    end
    
    function multiply(a, b)
        return a * b
    end
    
    -- Test the functions
    print("5 + 3 =", add(5, 3))
    print("4 × 6 =", multiply(4, 6))
]])
```

### Adding Lua Files
For existing Lua scripts:

```lua
local project = darwin.create_project("FileProcessor")

-- Add your main application file
project.add_lua_file("src/main.lua")

-- Add utility modules
project.add_lua_file("src/utils.lua")
project.add_lua_file("src/config.lua")
```

### Smart Dependency Resolution
When your Lua files use `require()` or `package.load_lib()`:

```lua
local project = darwin.create_project("WebServer")

-- This automatically includes ALL required files!
project.add_lua_file_following_require("src/server.lua")
```

If `server.lua` contains:
```lua
local http = require("http_utils")
local db = require("database")
local json = package.load_lib("json_parser")
```

Darwin will automatically find and include `http_utils.lua`, `database.lua`, and `json_parser` in your project.

### Generate Lua Outputs

#### Create a Standalone Lua File
```lua
-- Generate a single Lua file with everything included
project.generate_lua_file({
    output = "complete_app.lua",
    include_embed_data = true  -- Include any embedded files
})
```

#### Get Lua Code as String
```lua
-- Get the generated code in a variable
local complete_code = project.generate_lua_code({
    include_embed_data = true
})

print("Generated code length:", #complete_code)
```

#### Stream Lua Generation
```lua
-- Process the code as it's generated (useful for large projects)
project.generate_lua_complex({
    stream = function(code_chunk) 
        -- Process each chunk (e.g., save to file, send over network)
        print("Processing chunk:", #code_chunk, "bytes")
        io.write(code_chunk)  -- Write to stdout
    end,
    include_embed_data = true
})
```

## Working with C

### Adding C Headers
When you need to include C libraries or custom functions:

```lua
local project = darwin.create_project("SystemTool")

-- Include standard C libraries
project.add_c_include("stdio.h")
project.add_c_include("stdlib.h")

-- Include your custom C code
project.add_c_include("src/custom_functions.h")
```

### Adding C Source Files
For complex C integration with dependency tracking:

```lua
local project = darwin.create_project("GraphicsApp")

-- Add C file and follow its includes
local follow_includes = true

-- Optional: Verify each include before adding
local verify_callback = function(import_name, file_path)
    print("Found import:", import_name)
    print("At path:", file_path)
    
    -- Return false to skip this include
    if import_name:match("test_") then
        return false  -- Skip test files
    end
    
    return true  -- Include this file
end

project.add_c_file("src/graphics.c", follow_includes, verify_callback)
```

### Adding C Function Calls
To run C functions during program startup:

```lua
local project = darwin.create_project("DatabaseApp")

-- Include your C header
project.add_c_include("database/db_functions.h")

-- Call initialization functions
project.add_c_call("init_database")
project.add_c_call("setup_logging")
project.add_c_call("load_configuration")
```

Your C functions must look like this:
```c
#include "LuaCEmbed.c"

void init_database(LuaCEmbed *lua) {
    printf("Database initialized!\n");
    // Your initialization code here
}

void setup_logging(LuaCEmbed *lua) {
    printf("Logging system ready!\n");
    // Setup logging
}
```

### Load C Libraries as Lua Objects
To make C libraries available in Lua:

```lua
local project = darwin.create_project("DataProcessor")

-- Load DoTheWorld library as 'dtw' object
project.load_lib_from_c("load_luaDoTheWorld", "dtw")

-- Load JSON library as 'json' object  
project.load_lib_from_c("load_luaFluidJson", "json")

-- Add Lua code that uses these libraries
project.add_lua_code([[
    -- Now you can use dtw and json objects!
    if dtw.file_exists("config.json") then
        local content = dtw.load_file("config.json")
        local config = json.decode(content)
        print("Config loaded:", config.app_name)
    end
]])
```

Note: The C function (e.g., `load_luaDoTheWorld`) must follow this pattern:
> ```c
> int load_luaDoTheWorld(lua_State *state);
> ```

## Generation Options

### Generate C Executables

#### Create C Source File
```lua
-- Generate C code for compilation
project.generate_c_file({
    output = "myapp.c",
    include_lua_cembed = true  -- Include Lua interpreter
})
```

#### Get C Code as String
```lua
-- Get the C code in memory
local c_code = project.generate_c_code({
    include_lua_cembed = true
})

-- Save it yourself
local file = io.open("custom_name.c", "w")
file:write(c_code)
file:close()
```

#### Stream C Generation
```lua
-- Process C code in chunks
project.generate_c_complex({
    stream = function(code_chunk)
        -- Send to compiler, save to file, etc.
        process_c_chunk(code_chunk)
    end,
    include_lua_cembed = true
})
```

### Generate C Libraries

#### Create Shared Library File
```lua
-- Generate a .so/.dll library
project.generate_c_lib_file({
    output = "mylibrary.c",
    include_lua_cembed = true,
    lib_name = "mylib",        -- Creates luaopen_mylib() function
    object_export = "MyAPI"    -- Global object name in Lua
})
```

#### Get Library Code as String
```lua
local lib_code = project.generate_c_lib_code({
    include_lua_cembed = true,
    lib_name = "awesome_lib",
    object_export = "awesome"
})
```

#### Stream Library Generation
```lua
project.generate_c_lib_complex({
    stream = function(code_chunk)
        -- Process library code chunks
        handle_lib_code(code_chunk)
    end,
    include_lua_cembed = true,
    lib_name = "streaming_lib",
    object_export = "stream_api"
})
```

Usage of generated library:
```lua
-- In another Lua script
local awesome = require("awesome_lib")
awesome.do_something()
```

## Built-in Libraries

Darwin comes with powerful built-in libraries ready to use:

### Available Libraries

| Object Name | Library | Description | Use Case |
|-------------|---------|-------------|----------|
| `darwin.camalgamator` | [LuaCAmalgamator](https://github.com/OUIsolutions/LuaCAmalgamator) | C code amalgamation | Combining C files |
| `darwin.dtw` | [LuaDoTheWorld](https://github.com/OUIsolutions/LuaDoTheWorld) | File/system operations | File management |
| `darwin.candango` | [candangoEngine](https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine) | Template engine | Dynamic content |
| `darwin.json` | [LuaFluidJson](https://github.com/OUIsolutions/LuaFluidJson) | JSON processing | API data handling |
| `darwin.argv` | [LuaArgv](https://github.com/OUIsolutions/LuaArgv) | Command line parsing | CLI applications |
| `darwin.silverchain` | [LuaSilverChain](https://github.com/OUIsolutions/LuaSilverChain) | Method chaining | Fluent APIs |
| `darwin.ship` | [LuaShip](https://github.com/OUIsolutions/LuaShip) | Package management | Dependency handling |

### Quick Examples

#### File Operations with DoTheWorld
```lua
local project = darwin.create_project("FileManager")

project.add_lua_code([[
    -- Check if file exists
    if darwin.dtw.file_exists("important.txt") then
        -- Read file content
        local content = darwin.dtw.load_file("important.txt")
        print("File content:", content)
        
        -- Copy file
        darwin.dtw.copy_file("important.txt", "backup.txt")
    end
    
    -- Create directory
    darwin.dtw.create_dir("output")
    
    -- List directory contents
    local files = darwin.dtw.list_files(".")
    for i, file in ipairs(files) do
        print("Found file:", file)
    end
]])
```

#### JSON Processing
```lua
local project = darwin.create_project("APIClient")

project.add_lua_code([[
    -- Create JSON data
    local user_data = {
        name = "John Doe",
        age = 30,
        skills = {"Lua", "Python", "JavaScript"}
    }
    
    -- Convert to JSON string
    local json_string = darwin.json.encode(user_data)
    print("JSON:", json_string)
    
    -- Parse JSON back
    local parsed = darwin.json.decode(json_string)
    print("Name:", parsed.name)
    print("Skills:", table.concat(parsed.skills, ", "))
]])
```

#### Command Line Arguments
```lua
local project = darwin.create_project("CLI_Tool")

project.add_lua_code([[
    -- Parse command line arguments
    local args = darwin.argv.parse()
    
    if args.help then
        print("Usage: mytool [options]")
        print("  --help     Show this help")
        print("  --verbose  Enable verbose output")
        print("  --output   Set output file")
        return
    end
    
    if args.verbose then
        print("Verbose mode enabled")
    end
    
    local output_file = args.output or "default.txt"
    print("Output file:", output_file)
]])
```

## Complete Example: Web Server

Here's a complete example that combines multiple features:

```lua
-- Create a web server project
local project = darwin.create_project("WebServer")

-- Add C integration for performance
project.add_c_include("server/http_handler.h")
project.add_c_call("init_http_server")

-- Load built-in libraries
project.load_lib_from_c("load_luaDoTheWorld", "dtw")
project.load_lib_from_c("load_luaFluidJson", "json")

-- Add main server logic
project.add_lua_file_following_require("src/main.lua")

-- Add template files
project.add_lua_code([[
    -- Embedded templates
    local templates = {
        home = darwin.dtw.load_file("templates/home.html"),
        error = darwin.dtw.load_file("templates/error.html")
    }
    
    -- Simple HTTP server
    function handle_request(path)
        if path == "/" then
            return templates.home
        else
            return templates.error
        end
    end
    
    print("Server starting on port 8080...")
]])

-- Generate the final executable
project.generate_c_file({
    output = "webserver.c",
    include_lua_cembed = true
})
```

To build:
```bash
darwin run_blueprint server_config.lua
gcc webserver.c -o webserver.out
./webserver.out
```

## Troubleshooting

### Common Issues

#### "Function not found" Error
```lua
-- Wrong: Function name doesn't exist
project.add_c_call("non_existent_function")

-- Correct: Make sure function is declared in included header
project.add_c_include("my_functions.h")  -- Contains the function
project.add_c_call("my_actual_function")
```

#### "Cannot follow require" Error
```lua
-- Wrong: File doesn't exist
project.add_lua_file_following_require("missing_file.lua")

-- Correct: Check file exists first
if darwin.dtw.file_exists("src/main.lua") then
    project.add_lua_file_following_require("src/main.lua")
end
```

#### Library Loading Issues
```lua
-- Wrong: Function signature doesn't match
project.load_lib_from_c("wrong_signature_func", "myobj")

-- Correct: Use proper function signature
-- int your_func(lua_State *state)
project.load_lib_from_c("proper_signature_func", "myobj")
```

## Next Steps

1. Practice: Try the examples above
2. Explore: Check the [CLI documentation](cli_usage.md) for simpler workflows
3. Build: Create your own blueprint for your project
4. Share: Show your creations to the [Darwin community](https://github.com/OUIsolutions/Darwin/discussions)

<div align="center">

**Next:** [Build Guide](build.md) | **Back:** [CLI Usage](cli_usage.md) | **Home:** [Main README](../README.md)

</div>

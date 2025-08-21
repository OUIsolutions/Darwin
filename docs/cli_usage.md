# Command Line Usage Guide

## Table of Contents
- [Basic Compilation](#basic-compilation)
- [Advanced Options](#advanced-options)
- [Embedding Resources](#embedding-resources)
- [C Integration](#c-integration)
- [Project Blueprints](#project-blueprints)
- [Type Annotations](#type-annotations)
- [Quick Reference](#quick-reference)

## Basic Compilation

### Linux Executable
Converts your Lua script into a Linux binary:

```bash
# Basic compilation
darwin main.lua -o my_program.out

# Example
darwin calculator.lua -o calc.out
./calc.out
```

### Windows Executable
Creates a `.exe` file (can be done from Linux):

```bash
darwin main.lua -o my_program.exe
darwin game.lua -o awesome_game.exe
```

## Advanced Options

### Custom Compiler
Use a specific compiler instead of the default:

```bash
# Use clang instead of gcc
darwin main.lua -o my_program.out -compiler clang

# Use specific mingw for Windows
darwin main.lua -o my_program.exe -compiler x86_64-w64-mingw32-gcc
```

### Compilation Flags
Add special compilation options:

```bash
# Add static linking
darwin main.lua -o my_program.out -flags -static

# Add multiple flags
darwin main.lua -o my_program.out -flags -DMY_DEFINITION -flags -O2

# Debug build
darwin main.lua -o my_program.out -flags -g -flags -DDEBUG
```

## Embedding Resources

### Embed Files
Include files directly in your executable:

```bash
# Embed an image
darwin main.lua -o my_app.out -embed_vars logo -logo:file company_logo.png

# Embed a config file
darwin main.lua -o my_app.out -embed_vars config -config:file settings.json

# Embed multiple files
darwin main.lua -o my_app.out \
  -embed_vars logo -logo:file logo.png \
  -embed_vars data -data:file data.csv
```

Access embedded files in Lua:
```lua
print("Logo size:", #logo)  -- logo variable contains the file data
local config = json.decode(config)  -- config variable contains the JSON
```

### Embed Folders
Include entire folders:

```bash
darwin main.lua -o my_app.out -embed_vars templates -templates:folder ./templates/
darwin main.lua -o my_app.out -embed_vars assets -assets:folder ./assets/
```

### Embed Text Data
Include text directly:

```bash
darwin main.lua -o my_app.out -embed_vars welcome -welcome:text "Welcome to my app!"
darwin main.lua -o my_app.out -embed_vars version -version:text "v1.0.0"
```

## C Integration

### Include C Header Files
Use C libraries and custom C code:

```bash
# Include a C header
darwin main.lua -o my_program.out -c_include my_functions.h

# Include multiple headers
darwin main.lua -o my_program.out -c_include math_utils.h -c_include file_utils.h
```

Example C header (my_functions.h):
```c
#include "LuaCEmbed.c"

void say_hello(LuaCEmbed *lua) {
    printf("Hello from C code!\n");
}

void calculate_something(LuaCEmbed *lua) {
    // Your C logic here
}
```

### Call C Functions
Run C functions from Lua:

```bash
# Call a C function during startup
darwin main.lua -o my_program.out -c_include functions.h -c_calls say_hello

# Call multiple functions
darwin main.lua -o my_program.out \
  -c_include functions.h \
  -c_calls initialize_app \
  -c_calls setup_logging
```

**Note:** C functions must accept `LuaCEmbed *lua` and return `void`

### Load C Libraries as Lua Objects
Make C libraries available as Lua objects:

```bash
# Load DoTheWorld library as 'dtw' object
darwin main.lua -o my_program.out --lib_objects dtw --dtw:func load_luaDoTheWorld

# Load multiple libraries
darwin main.lua -o my_program.out \
  --lib_objects dtw --dtw:func load_luaDoTheWorld \
  --lib_objects json --json:func load_luaFluidJson
```

Use in Lua code:
```lua
dtw.file_exists("myfile.txt")
local data = json.decode('{"name": "John"}')
```

### Add C Amalgamations
Include entire C libraries:

```bash
# Add a C amalgamation
darwin main.lua -o my_program.out -amalgamation big_library.c

# Add multiple amalgamations
darwin main.lua -o my_program.out \
  -amalgamation graphics_lib.c \
  -amalgamation network_lib.c
```

## Project Blueprints

### Run a Blueprint File
Use configuration files to build complex projects:

```bash
# Run a specific blueprint
darwin run_blueprint my_config.lua

# Run default blueprint (looks for darwinconf.lua)
darwin run_blueprint
```

Example blueprint file (darwinconf.lua):
```lua
local project = darwin.create_project("MyAwesomeApp")
project.add_lua_file("src/main.lua")
project.add_c_include("libs/custom.h")
project.add_c_call("init_custom_lib")
project.generate_c_file({
    output = "myapp.c",
    include_lua_cembed = true
})
```

### Build from Folder
Automatically include all Lua files in a folder:

```bash
# Build entire folder (looks for main() function)
darwin run_blueprint my_project_folder --mode folder

# Build specific folder
darwin run_blueprint src/ --mode folder
```

Required folder structure:
```
my_project/
├── main.lua        ← Must have main() function
├── utils.lua       ← Automatically included
├── helpers.lua     ← Automatically included
└── data/
    └── config.lua  ← Also included
```

## Type Annotations

Generate type definition files for better IDE support:

```bash
darwin drop_types
```

## Quick Reference

### Common Commands
```bash
# Simple compilation
darwin script.lua -o program.out

# With embedded file
darwin script.lua -o program.out -embed_vars data -data:file config.json

# With C integration
darwin script.lua -o program.out -c_include mylib.h -c_calls init_lib

# Windows compilation
darwin script.lua -o program.exe

# Run blueprint
darwin run_blueprint config.lua
```

### Flags Summary
| Flag | Description | Example |
|------|-------------|---------|
| `-o` | Output file name | `-o myapp.out` |
| `-compiler` | Set compiler | `-compiler clang` |
| `-flags` | Compiler flags | `-flags -static` |
| `-embed_vars` | Embed resources | `-embed_vars data -data:file file.txt` |
| `-c_include` | Include C header | `-c_include mylib.h` |
| `-c_calls` | Call C function | `-c_calls init_func` |
| `--lib_objects` | Load C library | `--lib_objects dtw --dtw:func load_luaDoTheWorld` |
| `-amalgamation` | Include C amalgamation | `-amalgamation biglib.c` |

## Need Help?

- **Issues?** Check our [troubleshooting guide](../README.md#community--support)
- **More examples?** See our [API documentation](api_usage.md)
- **Questions?** [Ask the community](https://github.com/OUIsolutions/Darwin/discussions)

---

**Next:** [Learn API Usage](api_usage.md) | **Back:** [Main README](../README.md)

# 🖥️ Command Line Usage Guide

[![Difficulty](https://img.shields.io/badge/Difficulty-Beginner-green.svg)](#)
[![Time](https://img.shields.io/badge/Reading%20Time-5%20minutes-blue.svg)](#)
[![Examples](https://img.shields.io/badge/Examples-12+-orange.svg)](#)

**Learn how to use Darwin from the command line with easy examples!**

## 🎯 Table of Contents
- [📦 Basic Compilation](#-basic-compilation)
- [🔧 Advanced Options](#-advanced-options)
- [📁 Embedding Resources](#-embedding-resources)
- [⚙️ C Integration](#️-c-integration)
- [🎨 Project Blueprints](#-project-blueprints)
- [📝 Type Annotations](#-type-annotations)

---

## 📦 Basic Compilation

### 🐧 Create a Linux Executable
**What it does:** Converts your Lua script into a Linux binary that runs anywhere

```bash
# Basic compilation
darwin main.lua -o my_program.out

# Real example
darwin calculator.lua -o calc.out
./calc.out  # Run your calculator!
```

> 💡 **Tip:** The `.out` extension is just a convention - you can name it anything!

### 🪟 Create a Windows Executable
**What it does:** Creates a `.exe` file that runs on Windows

```bash
# Windows compilation
darwin main.lua -o my_program.exe

# Real example
darwin game.lua -o awesome_game.exe
```

> 🎯 **Note:** You can compile for Windows even from Linux!

---

## 🔧 Advanced Options

### 🛠️ Custom Compiler
**When to use:** When you want to use a specific compiler like `clang` instead of `gcc`

```bash
# Use clang instead of gcc
darwin main.lua -o my_program.out -compiler clang

# Use specific mingw for Windows
darwin main.lua -o my_program.exe -compiler x86_64-w64-mingw32-gcc
```

### 🏴 Compilation Flags
**When to use:** When you need special compilation options

```bash
# Add static linking
darwin main.lua -o my_program.out -flags -static

# Add multiple flags
darwin main.lua -o my_program.out -flags -DMY_DEFINITION -flags -O2

# Debug build
darwin main.lua -o my_program.out -flags -g -flags -DDEBUG
```

> 📚 **What are flags?** Think of them as special instructions for the compiler

---

## 📁 Embedding Resources

### 🖼️ Embed Files (Images, Data, etc.)
**What it does:** Puts files directly inside your executable - no external files needed!

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

**In your Lua code:**
```lua
-- Access your embedded files
print("Logo size:", #logo)  -- logo variable contains the file data
local config = json.decode(config)  -- config variable contains the JSON
```

### 📂 Embed Entire Folders
**What it does:** Includes a whole folder and all its contents in your executable

```bash
# Embed a templates folder
darwin main.lua -o my_app.out -embed_vars templates -templates:folder ./templates/

# Embed assets folder
darwin main.lua -o my_app.out -embed_vars assets -assets:folder ./assets/
```

### 📝 Embed Text Data
**What it does:** Includes text directly in your program

```bash
# Embed a welcome message
darwin main.lua -o my_app.out -embed_vars welcome -welcome:text "Welcome to my awesome app!"

# Embed version info
darwin main.lua -o my_app.out -embed_vars version -version:text "v1.0.0"
```

> 🎯 **Pro Tip:** Embedding makes your app portable - it works even without the original files!

---

## ⚙️ C Integration

### 📚 Include C Header Files
**What it does:** Lets you use C libraries and custom C code

```bash
# Include a C header
darwin main.lua -o my_program.out -c_include my_functions.h

# Include multiple headers
darwin main.lua -o my_program.out -c_include math_utils.h -c_include file_utils.h
```

**Example C header (my_functions.h):**
```c
#include "LuaCEmbed.c"

void say_hello(LuaCEmbed *lua) {
    printf("Hello from C code!\n");
}

void calculate_something(LuaCEmbed *lua) {
    // Your C logic here
}
```

### 🚀 Call C Functions
**What it does:** Runs your C functions from Lua

```bash
# Call a C function during startup
darwin main.lua -o my_program.out -c_include functions.h -c_calls say_hello

# Call multiple functions
darwin main.lua -o my_program.out \
  -c_include functions.h \
  -c_calls initialize_app \
  -c_calls setup_logging
```

> 📖 **Function Requirements:** C functions must accept `LuaCEmbed *lua` and return `void`

### 📦 Load C Libraries as Lua Objects
**What it does:** Makes C libraries available as Lua objects

```bash
# Load DoTheWorld library as 'dtw' object
darwin main.lua -o my_program.out --lib_objects dtw --dtw:func load_luaDoTheWorld

# Load multiple libraries
darwin main.lua -o my_program.out \
  --lib_objects dtw --dtw:func load_luaDoTheWorld \
  --lib_objects json --json:func load_luaFluidJson
```

**In your Lua code:**
```lua
-- Use the loaded C library
dtw.file_exists("myfile.txt")
local data = json.decode('{"name": "John"}')
```

### 🔗 Add C Amalgamations
**What it does:** Includes entire C libraries in one file

```bash
# Add a C amalgamation
darwin main.lua -o my_program.out -amalgamation big_library.c

# Add multiple amalgamations
darwin main.lua -o my_program.out \
  -amalgamation graphics_lib.c \
  -amalgamation network_lib.c
```

---

## 🎨 Project Blueprints

### 📋 Run a Blueprint File
**What it does:** Uses a configuration file to build complex projects

```bash
# Run a specific blueprint
darwin run_blueprint my_config.lua

# Run default blueprint (looks for darwinconf.lua)
darwin run_blueprint
```

**Example blueprint file (darwinconf.lua):**
```lua
-- Create your project
local project = darwin.create_project("MyAwesomeApp")

-- Add your main Lua file
project.add_lua_file("src/main.lua")

-- Add C integration
project.add_c_include("libs/custom.h")
project.add_c_call("init_custom_lib")

-- Generate the executable
project.generate_c_file({
    output = "myapp.c",
    include_lua_cembed = true
})
```

### 📁 Build from Folder
**What it does:** Automatically includes all Lua files in a folder and calls `main()`

```bash
# Build entire folder (looks for main() function)
darwin run_blueprint my_project_folder --mode folder

# Build specific folder
darwin run_blueprint src/ --mode folder
```

**Folder structure example:**
```
my_project/
├── main.lua        ← Must have main() function
├── utils.lua       ← Automatically included
├── helpers.lua     ← Automatically included
└── data/
    └── config.lua  ← Also included
```

---

## 📝 Type Annotations

### 🏷️ Get Type Definitions
**What it does:** Creates type definition files for better IDE support

```bash
# Generate type annotations
darwin drop_types
```

This creates files that help your code editor understand Darwin's functions and provide better autocomplete!

---

## 🎯 Quick Reference

### Most Common Commands
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
| Flag | What it does | Example |
|------|--------------|---------|
| `-o` | Output file name | `-o myapp.out` |
| `-compiler` | Set compiler | `-compiler clang` |
| `-flags` | Compiler flags | `-flags -static` |
| `-embed_vars` | Embed resources | `-embed_vars data -data:file file.txt` |
| `-c_include` | Include C header | `-c_include mylib.h` |
| `-c_calls` | Call C function | `-c_calls init_func` |
| `--lib_objects` | Load C library | `--lib_objects dtw --dtw:func load_luaDoTheWorld` |
| `-amalgamation` | Include C amalgamation | `-amalgamation biglib.c` |

---

## 🆘 Need Help?

- 🐛 **Something not working?** Check our [troubleshooting guide](../README.md#community--support)
- 📖 **Want more examples?** See our [API documentation](api_usage.md)
- 💡 **Have questions?** [Ask the community](https://github.com/OUIsolutions/Darwin/discussions)

---

<div align="center">

**Next:** [🔧 Learn API Usage](api_usage.md) | **Back:** [🏠 Main README](../README.md)

</div>

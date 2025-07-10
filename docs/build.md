
# 🏗️ Build Guide - Compile Darwin from Source

[![Difficulty](https://img.shields.io/badge/Difficulty-Advanced-red.svg)](#)
[![Time](https://img.shields.io/badge/Build%20Time-5--15%20minutes-blue.svg)](#)
[![Requirements](https://img.shields.io/badge/Requirements-GCC%20%7C%20Docker-orange.svg)](#)

**Learn how to build Darwin from source code for development or custom deployments!**

## 🎯 Why Build from Source?

- 🔧 **Customize Darwin** for your specific needs
- 🐛 **Contribute** to Darwin development
- 🏗️ **Learn** how Darwin works internally
- 🚀 **Get latest features** before official releases

---

## 🚀 Quick Build (Easiest)

### 📦 One-Command Build
**Perfect for:** Quick testing or when you just need a working binary

```bash
# Download and compile in one step
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out
```

**That's it!** You now have a working `darwin.out` executable.

### ✅ Test Your Build
```bash
# Test the build
./darwin.out --help

# Create a test program
echo 'print("Hello from custom Darwin!")' > test.lua
./darwin.out test.lua -o test.out
./test.out
```

---

## 🐋 Docker Build (Recommended for Development)

### 📋 Prerequisites
- ✅ Docker installed
- ✅ Darwin v0.020+ installed
- ✅ Git repository cloned

### 🖥️ Linux Build
```bash
# Clone the repository
git clone https://github.com/OUIsolutions/Darwin.git
cd Darwin

# Build for Linux using Docker
darwin run_blueprint build/ --mode folder build_linux_from_docker
```

### 🪟 Windows Build  
```bash
# Build for Windows using Docker
darwin run_blueprint build/ --mode folder build_windows_from_docker
```

### 📦 Build Both Platforms
```bash
# Build everything at once
darwin run_blueprint build/ --mode folder build_linux_from_docker build_windows_from_docker
```

**What you get:**
- 📁 `release/darwin.out` - Linux executable
- 📁 `release/darwin.exe` - Windows executable
- 📁 `release/darwin.c` - Source amalgamation

> 🐋 **Why Docker?** It provides a consistent build environment regardless of your host system!

---

## 🛠️ Native Build (For Experts)

### 📋 Prerequisites
- ✅ Darwin v0.020+ installed
- ✅ GCC with `--static` flag support
- ✅ MinGW-w64 (for Windows builds)
- ✅ Git repository cloned

### 🐧 Linux Native Build
```bash
# Clone repository
git clone https://github.com/OUIsolutions/Darwin.git
cd Darwin

# Build for Linux
darwin run_blueprint build/ --mode folder build_linux
```

### 🪟 Windows Cross-Compilation
```bash
# Build Windows executable from Linux
darwin run_blueprint build/ --mode folder build_windows
```

### 📦 Build All Targets
```bash
# Build everything
darwin run_blueprint build/ --mode folder build_linux build_windows
```

### 🔧 Install Dependencies (Ubuntu/Debian)
```bash
# Install required packages
sudo apt update
sudo apt install -y gcc mingw-w64 git curl

# Install Darwin if you don't have it
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

### 🔧 Install Dependencies (Fedora/RHEL)
```bash
# Install required packages
sudo dnf install -y gcc mingw64-gcc git curl

# Install Darwin
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

---

## 📄 Source-Only Build

### 🎯 Generate Amalgamation
**When to use:** You only need the C source code

```bash
# Clone repository
git clone https://github.com/OUIsolutions/Darwin.git
cd Darwin

# Generate only the C amalgamation
darwin run_blueprint build/ --mode folder build_source
```

**Output:** `release/darwin.c` - Complete C source code in a single file

### 🔨 Compile the Amalgamation
```bash
# Compile with your preferred settings
gcc release/darwin.c -o darwin.out

# Or with optimizations
gcc -O3 -DNDEBUG release/darwin.c -o darwin.out

# Or statically linked
gcc -static release/darwin.c -o darwin.out
```

---

## 🎯 Understanding the Build Process

### 📁 Build Structure
```
build/
├── assets.lua          # Asset management
├── dependencies.lua    # Dependency handling
├── embed_c.lua         # C code embedding
├── main.lua            # Main build logic
└── types.lua           # Type definitions
```

### 🏗️ Build Targets Explained

| Target | What it does | Output |
|--------|--------------|--------|
| `build_linux` | Native Linux compilation | `release/darwin.out` |
| `build_windows` | Windows cross-compilation | `release/darwin.exe` |
| `build_source` | Generate C amalgamation | `release/darwin.c` |
| `build_linux_from_docker` | Linux build in Docker | `release/darwin.out` |
| `build_windows_from_docker` | Windows build in Docker | `release/darwin.exe` |

### 🔄 Build Process Steps

1. **📥 Dependency Collection** - Gather all required C files
2. **🔗 Amalgamation** - Combine into single C file
3. **⚙️ Compilation** - Build executable with appropriate flags
4. **✅ Testing** - Verify the build works correctly
5. **📦 Packaging** - Place results in `release/` folder

---

## 🐛 Troubleshooting

### ❌ "Darwin command not found"
```bash
# Install Darwin first
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

### ❌ "MinGW not found" (Windows builds)
```bash
# Ubuntu/Debian
sudo apt install mingw-w64

# Fedora/RHEL  
sudo dnf install mingw64-gcc

# Arch Linux
sudo pacman -S mingw-w64-gcc
```

### ❌ "Docker command not found"
```bash
# Install Docker on Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
# Log out and log back in
```

### ❌ "Permission denied" errors
```bash
# Make sure you have permissions
sudo chmod +x darwin.out

# Or run with sudo if needed
sudo ./darwin.out
```

### ❌ "Build failed" errors
```bash
# Check you have all dependencies
gcc --version
mingw-w64-gcc --version  # For Windows builds
docker --version         # For Docker builds

# Verify Darwin version
darwin --version  # Should be 0.020 or higher
```

---

## 🔧 Customizing the Build

### 🎨 Custom Compilation Flags
Edit the build scripts to add custom flags:

```lua
-- In build/main.lua, modify the compilation section
local custom_flags = "-O3 -march=native -DCUSTOM_FEATURE"
-- Add your custom flags to the compilation command
```

### 📦 Custom Dependencies
Add your own C libraries to the build:

```lua
-- In build/dependencies.lua
project.add_c_include("my_custom_lib.h")
project.add_c_file("my_custom_lib.c")
```

### 🔧 Build Variants
Create different Darwin versions:

```bash
# Debug build
CFLAGS="-g -DDEBUG" darwin run_blueprint build/ --mode folder build_linux

# Optimized build  
CFLAGS="-O3 -DNDEBUG" darwin run_blueprint build/ --mode folder build_linux

# Minimal build
CFLAGS="-Os -DMINIMAL" darwin run_blueprint build/ --mode folder build_linux
```

---

## 🚀 Development Workflow

### 🔄 Typical Development Cycle

1. **📝 Make Changes** to Darwin source code
2. **🏗️ Rebuild** using your preferred method
3. **✅ Test** the new functionality
4. **🔁 Repeat** until satisfied

```bash
# Quick development cycle
edit_source_files()
darwin run_blueprint build/ --mode folder build_linux
./release/darwin.out test_script.lua -o test.out
./test.out
```

### 🧪 Testing Your Changes
```bash
# Create test scripts
echo 'print("Testing custom Darwin")' > test1.lua
echo 'print("Feature test:", 42 + 58)' > test2.lua

# Test compilation
./release/darwin.out test1.lua -o test1.out
./release/darwin.out test2.lua -o test2.out

# Run tests
./test1.out
./test2.out
```

---

## 📊 Build Performance Tips

### ⚡ Speed Up Builds

| Method | Speed Gain | Trade-off |
|--------|------------|-----------|
| Use Docker | 🚀🚀🚀 | Requires Docker |
| Native build | 🚀🚀 | Platform dependent |
| Source only | 🚀 | Manual compilation |
| Parallel builds | 🚀🚀 | More CPU usage |

### 💾 Reduce Build Size
```bash
# Strip debug symbols
strip release/darwin.out

# Use size optimization
CFLAGS="-Os" darwin run_blueprint build/ --mode folder build_linux

# Static linking (larger but more portable)
CFLAGS="-static" darwin run_blueprint build/ --mode folder build_linux
```

---

## 🆘 Getting Help

- 🐛 **Build issues?** [Open an issue](https://github.com/OUIsolutions/Darwin/issues/new)
- 💬 **Questions?** [Join discussions](https://github.com/OUIsolutions/Darwin/discussions)  
- 📖 **Documentation unclear?** Help us improve it!
- 🤝 **Want to contribute?** Check our [contribution guidelines](https://github.com/OUIsolutions/Darwin/blob/main/CONTRIBUTING.md)

---

<div align="center">

**Next:** [📚 Dependencies](dependencies.md) | **Back:** [🔧 API Usage](api_usage.md) | **Home:** [🏠 Main README](../README.md)

</div>

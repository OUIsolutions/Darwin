# 🏗️ Build Guide - Compile Darwin from Source

[![Difficulty](https://img.shields.io/badge/Difficulty-Advanced-red.svg)](#)
[![Time](https://img.shields.io/badge/Build%20Time-5--15%20minutes-blue.svg)](#)
[![Requirements](https://img.shields.io/badge/Requirements-GCC%20%7C%20Podman-orange.svg)](#)

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
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.7.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out
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

## 🐳 Container Build (Recommended for Development)

### 📋 Prerequisites
- ✅ Podman installed (or Docker as alternative)
- ✅ Darwin v0.020+ installed
- ✅ Git repository cloned

### 🖥️ Linux Builds
```bash
# Clone the repository
git clone https://github.com/OUIsolutions/Darwin.git
cd Darwin

# Linux static build (small, portable)
darwin run_blueprint --target linux_bin

# RPM-based static build (RedHat, Fedora, CentOS)
darwin run_blueprint --target rpm_static_build

# Debian static build (Ubuntu, Debian)
darwin run_blueprint --target debian_static_build
```

### 🪟 Windows Builds  
```bash
# Windows 32-bit build
darwin run_blueprint --target windowsi32_build

# Windows 64-bit build
darwin run_blueprint --target windows64_build
```

### 📦 Build Multiple Targets
```bash
# Build all Linux variants
darwin run_blueprint --target linux_bin rpm_static_build debian_static_build

# Build all Windows variants
darwin run_blueprint --target windowsi32_build windows64_build

# Build everything at once
darwin run_blueprint --target all
```

**What you get:**
- 📁 `release/linux_bin.out` - Linux executable
- 📁 `release/windows64.exe` / `release/windowsi32.exe` - Windows executables
- 📁 `release/amalgamation.c` - Source amalgamation

> 🐳 **Why Containers?** They provide consistent build environments regardless of your host system!

---

## 🛠️ Native Build (GCC Only)

### 📋 Prerequisites
- ✅ GCC compiler
- ✅ Git repository cloned

### 🐧 Simple GCC Build
```bash
# Clone repository
git clone https://github.com/OUIsolutions/Darwin.git
cd Darwin

# Generate amalgamation and compile with GCC
darwin run_blueprint --target amalgamation

# The above generates release/amalgamation.c, then compile it:
gcc release/amalgamation.c -o release/darwin.out
```

### 🔧 Install Dependencies (Ubuntu/Debian)
```bash
# Install required packages
sudo apt update
sudo apt install -y gcc git curl podman

# Install Darwin if you don't have it
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

### 🔧 Install Dependencies (Fedora/RHEL)
```bash
# Install required packages
sudo dnf install -y gcc git curl podman

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
darwin run_blueprint --target amalgamation
```

**Output:** `release/amalgamation.c` - Complete C source code in a single file

### 🔨 Compile the Amalgamation
```bash
# Compile with your preferred settings
gcc release/amalgamation.c -o darwin.out

# Or with optimizations
gcc -O3 -DNDEBUG release/amalgamation.c -o darwin.out

# Or statically linked
gcc -static release/amalgamation.c -o darwin.out
```

---

## 🎯 Understanding the Build Process

### 📁 Build Structure
```
builds/
├── amalgamation_build.lua  # Generate C amalgamation
├── linux_bin.lua          # Linux static binary
├── debian_static_build.lua # Debian package
├── rpm_static_build.lua    # RPM package
├── windowsi32_build.lua    # Windows 32-bit binary
└── windows64_build.lua     # Windows 64-bit binary
```

### 🏗️ Build Targets Explained

| Target | What it does | Output | Container |
|--------|--------------|--------|-----------|
| `amalgamation` | Generate C amalgamation | `release/amalgamation.c` | No |
| `linux_bin` | Linux static build | `release/linux_bin.out` | Yes |
| `debian_static_build` | Debian package build | `release/debian_static.deb` | Yes |
| `rpm_static_build` | RPM package build | `release/rpm_static_build.rpm` | Yes |
| `windowsi32_build` | Windows 32-bit build | `release/windowsi32.exe` | Yes |
| `windows64_build` | Windows 64-bit build | `release/windows64.exe` | Yes |

### 🔄 Build Process Steps

1. **📥 Dependency Collection** - Gather all required C files
2. **🔗 Amalgamation** - Combine into single C file
3. **🐳 Container Setup** - Prepare build environment (if using containers)
4. **⚙️ Compilation** - Build executable with appropriate flags
5. **✅ Testing** - Verify the build works correctly
6. **📦 Packaging** - Place results in `release/` folder

---

## 🐛 Troubleshooting

### ❌ "Darwin command not found"
```bash
# Install Darwin first
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

### ❌ "Podman command not found"
```bash
# Install Podman on Ubuntu/Debian
sudo apt update
sudo apt install -y podman

# Install Podman on Fedora/RHEL  
sudo dnf install -y podman

# Install Podman on Arch Linux
sudo pacman -S podman
```

### ❌ "Container build failed"
```bash
# Check Podman/Docker is running
podman --version
# or
docker --version

# Check if you can pull images
podman pull alpine:latest
# or  
docker pull alpine:latest

# The blueprint system will automatically choose the available container engine
```

### ❌ "Permission denied" errors
```bash
# Make sure you have permissions
sudo chmod +x darwin.out

# For container builds, check user permissions
sudo usermod -aG podman $USER
# Log out and log back in
```

### ❌ "Build failed" errors
```bash
# Check you have all dependencies
gcc --version
podman --version
darwin --version  # Should be 0.020 or higher

# For GCC builds, ensure you have development tools
sudo apt install build-essential  # Ubuntu/Debian
sudo dnf groupinstall "Development Tools"  # Fedora/RHEL
```

---

## 🔧 Container Options

### 🐳 Using Docker Instead of Podman
**Note:** The new blueprint system handles containerization automatically based on your system configuration.

```bash
# The containerization is handled internally by the blueprint system
# Simply run your desired target
darwin run_blueprint --target linux_bin

# All builds work with the available container engine (Podman/Docker)
darwin run_blueprint --target windowsi32_build windows64_build
```

### 🚀 Container Benefits

| Build Type | Benefits |
|------------|----------|
| `linux_bin` | Small, secure, fully static |
| `debian_static_build` | Compatible, well-tested |
| `rpm_static_build` | Enterprise-ready |
| `windowsi32_build` | Legacy Windows support |
| `windows64_build` | Modern Windows support |

---

## 🔧 Customizing the Build

### 🎨 Custom Compilation Flags
Edit the build scripts to add custom flags:

```lua
-- In builds/amalgamation_build.lua, modify the compilation section
local custom_flags = "-O3 -march=native -DCUSTOM_FEATURE"
-- Add your custom flags to the compilation command
```

### 📦 Custom Dependencies
Add your own C libraries to the build:

```lua
-- In builds/amalgamation_build.lua
project.add_c_include("my_custom_lib.h")
project.add_c_file("my_custom_lib.c")
```

### 🔧 Build Variants
Create different Darwin versions:

```bash
# Debug build (amalgamation only)
CFLAGS="-g -DDEBUG" darwin run_blueprint --target amalgamation
gcc -g -DDEBUG release/amalgamation.c -o darwin_debug.out
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

# Generate amalgamation and compile
darwin run_blueprint build/ --mode folder amalgamation_build
gcc release/darwin.c -o release/darwin.out

# Test
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
| Container builds | 🚀🚀🚀 | Requires containers |
| Amalgamation + GCC | 🚀🚀 | Manual compilation |
| Parallel builds | 🚀🚀 | More CPU usage |

### 💾 Reduce Build Size
```bash
# Use Alpine static build (smallest)
darwin run_blueprint build/ --mode folder alpine_static_build --contanizer podman

# Strip debug symbols after GCC build
gcc -Os release/darwin.c -o release/darwin.out
strip release/darwin.out
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

# Darwin 🧬
**The Most Advanced Lua Compiler** - Transform your Lua code into powerful executables

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-0.3.0-green.svg)](https://github.com/OUIsolutions/Darwin/releases)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows-lightgrey.svg)](#releases)
[![Language](https://img.shields.io/badge/Language-Lua%20%7C%20C-orange.svg)](#features)
[![Status](https://img.shields.io/badge/Status-Active-success.svg)](https://github.com/OUIsolutions/Darwin)

## 🎯 What can Darwin do?

Darwin is a **powerful Lua compiler** that transforms your Lua scripts into:

| Output Type | Description | Perfect for |
|-------------|-------------|-------------|
| 🐧 **Linux Executable** | Standalone binary for Linux | Servers, CLI tools |
| 🪟 **Windows Executable** | Standalone .exe for Windows | Desktop apps, utilities |
| ⚙️ **C/C++ Code** | Generated C source code | Integration, performance |
| 📚 **SO Library** | Shared object libraries | Modular applications |
| 🔗 **Lua Amalgamation** | Single Lua file | Distribution, embedding |

## ✨ Why Choose Darwin?

- 📁 **Embed Files & Folders** - Bundle resources directly into your executable
- 🔧 **C/C++ Integration** - Mix Lua with native C code seamlessly
- ⚡ **Compile-time Magic** - Manipulate code during compilation
- 🎨 **Zero Dependencies** - Your compiled programs run anywhere
- 🚀 **Lightning Fast** - Optimized compilation and execution

## 🚀 Quick Start (30 seconds!)

### Step 1: Create a simple Lua file
```lua
-- hello.lua
print("Hello from Darwin! 🧬")
print("This is now a compiled executable!")
```

### Step 2: Compile it
```bash
darwin hello.lua -o hello.out
```

### Step 3: Run it
```bash
./hello.out
```

**That's it!** You've just created your first compiled Lua program! 🎉

## 📦 Installation

### 🐧 Linux (One-liner)
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out && sudo chmod +x darwin.out && sudo mv darwin.out /usr/bin/darwin
```

### 🪟 Windows
Download [darwin.exe](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.exe) and add it to your PATH

## 📋 Download Options

[![Download for Linux](https://img.shields.io/badge/Download-Linux%20Binary-blue?style=for-the-badge&logo=linux)](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out)
[![Download for Windows](https://img.shields.io/badge/Download-Windows%20Binary-blue?style=for-the-badge&logo=windows)](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.exe)
[![Download Source](https://img.shields.io/badge/Download-Source%20Code-green?style=for-the-badge&logo=github)](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.c)

| Platform | File | Size | Description |
|----------|------|------|-------------|
| 🐧 Linux | [darwin.out](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out) | ~2MB | Ready-to-use Linux binary |
| 🪟 Windows | [darwin.exe](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.exe) | ~2MB | Ready-to-use Windows executable |
| 📄 Source | [darwin.c](https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.c) | ~500KB | C amalgamation for compilation |

## 🎓 Learning Resources

### 📖 Documentation
| Guide | Difficulty | Description |
|-------|------------|-------------|
| 🚀 [Quick Start Examples](#quick-start-30-seconds) | Beginner | Get started in 30 seconds |
| 🖥️ [Command Line Usage](docs/cli_usage.md) | Beginner | All CLI commands explained |
| 🔧 [API Usage](docs/api_usage.md) | Intermediate | Advanced project creation |
| 🏗️ [Build Guide](docs/build.md) | Advanced | Build from source |
| 📚 [Dependencies](docs/dependencies.md) | Reference | License information |

### 🎯 Common Use Cases

<details>
<summary>🛠️ <strong>Command Line Tools</strong></summary>

Perfect for creating system utilities and CLI applications:
```bash
# Create a file manager
darwin file_manager.lua -o fm.out

# Create a text processor
darwin text_processor.lua -o process.out
```
</details>

<details>
<summary>🌐 <strong>Web Applications</strong></summary>

Build web servers and APIs:
```bash
# Simple web server
darwin web_server.lua -o server.out

# REST API
darwin api.lua -o api.out
```
</details>

<details>
<summary>🎮 <strong>Games & Interactive Apps</strong></summary>

Create games and interactive applications:
```bash
# Simple game
darwin game.lua -o game.out

# Interactive quiz
darwin quiz.lua -o quiz.out
```
</details>

<details>
<summary>⚙️ <strong>System Integration</strong></summary>

Integrate with existing C/C++ projects:
```bash
# Generate C library
darwin my_logic.lua -o liblogic.so

# Create C header
darwin logic.lua -output-type c-header
```
</details>

## 🤝 Community & Support

[![GitHub Issues](https://img.shields.io/badge/Issues-GitHub-red?style=flat-square&logo=github)](https://github.com/OUIsolutions/Darwin/issues)
[![Discussions](https://img.shields.io/badge/Discussions-GitHub-blue?style=flat-square&logo=github)](https://github.com/OUIsolutions/Darwin/discussions)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

- 🐛 **Found a bug?** [Open an issue](https://github.com/OUIsolutions/Darwin/issues/new)
- 💡 **Have an idea?** [Start a discussion](https://github.com/OUIsolutions/Darwin/discussions)
- 📖 **Need help?** Check our [documentation](docs/)
- 🌟 **Like Darwin?** Give us a star on GitHub!

## 🏆 Why Darwin is Special

Darwin isn't just another compiler - it's a **complete ecosystem** for Lua development:

| Feature | Traditional Lua | Darwin |
|---------|----------------|--------|
| **Distribution** | Script files | Single executable |
| **Dependencies** | External libs | Everything embedded |
| **Performance** | Interpreted | Compiled optimization |
| **Integration** | Lua only | Lua + C seamlessly |
| **Deployment** | Complex setup | Drop and run |

---

<div align="center">

**Made with ❤️ by the OUI Solutions team**

[⭐ Star us on GitHub](https://github.com/OUIsolutions/Darwin) • [📖 Read the docs](docs/) • [🚀 Try Darwin now](#installation)

</div>

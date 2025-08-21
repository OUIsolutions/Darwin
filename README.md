<div align="center">

# Darwin
![Lua Logo](https://img.shields.io/badge/Darwin-0.11.0-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/Darwin.svg?style=for-the-badge)](https://github.com/OUIsolutions/Darwin/releases)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/Darwin/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Alpha-orange?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux%20|%20WebAssembly-lightgrey?style=for-the-badge)

</div>

---

## ⚠️ Important Notice

> **This is alpha software!** Use at your own risk. While we're working hard to make it stable, bugs are expected. Perfect for learning and prototyping! 🧪

---

### Overview

Darwin is a powerful Lua compiler that transforms your Lua scripts into standalone executables. It provides a streamlined interface for compilation, eliminating the complexity of traditional build systems:

1. **Write your Lua code** 
2. **Compile to executable**
3. **Deploy anywhere**

This compiler is designed for developers who need to:
- Create standalone applications from Lua scripts
- Embed files and resources into executables
- Mix Lua with native C code seamlessly
- Deploy applications without dependencies

### Key Features

- **Multi-platform compilation** - Create executables for Windows, Linux, and more
- **File embedding** - Bundle resources directly into your executable
- **C/C++ integration** - Mix Lua with native code
- **Zero dependencies** - Your compiled programs run anywhere
- **Lua amalgamation** - Single file distribution
- **SO library generation** - Create shared libraries from Lua code


### Linux Installation 
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/linux_bin.out -o darwin.out && chmod +x darwin.out &&   mv darwin.out /usr/local/bin/darwin 
```
### Mac-Os Instalation
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/amalgamation.c -o amalgamation.c && gcc amalgamation.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm amalgamation.c 
```

### AI/LLM Integration

Want to learn how to use Darwin with AI assistance? Download the [ai_doc.md](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/ai_doc.md) file and paste its contents to your preferred AI assistant (ChatGPT, Claude, Copilot, etc.) for interactive learning and code examples.

---

## Releases


|  **File**                                                                                                           | **What is**                                |
|---------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
|[amalgamation.c](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/amalgamation.c) | A Amalgamation Containing all the Library  |
|[linux_bin.out](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/linux_bin.out)   | Ready-to-use Linux binary           |
|[windowsi32.exe](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/windowsi32.exe)       | Ready-to-use Windows 32-bit executable                         |
|[debian_static.deb](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/debian_static.deb)       | Debian package for easy installation                             |
|[rpm_static_build.rpm](https://github.com/OUIsolutions/Darwin/releases/download/0.11.0/rpm_static_build.rpm)       | RPM package for easy installation            |



## [Public API](docs/public_api.md)
Click here [Public API](docs/public_api.md) to see the full list of public API functions.

## Usage Tutorials 

| **Tutorial**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [API Usage](docs/api_usage.md)              | Working with Darwin's API                       |
| [Build Guide](docs/build.md)                           | Building Darwin from source                               |
| [CLI Usage](docs/cli_usage.md)                   | Command line interface guide                     |
| [Dependencies](docs/dependencies.md)      | Understanding project dependencies                          |

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.003/darwin003.c)
by typing 
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.003/darwin003.c -o darwin003.c 
```

Create the **darwinconf.lua** file, these file configure the entire project ,to you 

```lua
Addcode("print('hello world')") -- embed these code to o final.o
Addfile("test.lua") --embed these file to final.o

Cfilename = "final.c" 
Compiler = "gcc" 
Output = "final.o"  
Runafter = true 
```
and run with: 
```shel
gcc darwin003.c -o darwin003.o && ./darwin003.o 
```


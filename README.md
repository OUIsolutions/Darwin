# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.004/darwin004.c)
by typing 
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.004/darwin004.c -o darwin004.c 
```

Create the **darwinconf.lua** file, these file configure the entire project ,to you 

```lua

local main_code = "print('hello word')"

io.open("main.lua", "w"):write(main_code):close()

Addcode("print('hello world 2')") -- embed these code to o final.o
Addfile("main.lua") --embed these file to final.o

Cfilename = "final.c" 
Compiler = "gcc" 
Output = "final.o"  
Runafter = true 
```
and run with: 
```shel
gcc darwin004.c -o darwin004.o && ./darwin004.o 
```


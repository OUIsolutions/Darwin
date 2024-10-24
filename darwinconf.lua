
Addcode("print('hello world')") -- embed these code to o final.o
Addfile("test.lua") --embed these file to final.o

Cfilename = "final.c" 
Compiler = "gcc" 
Output = "final.o"  
Runafter = true 
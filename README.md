# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.001/darwin.c)
and run
```shel
gcc darwin.c -o darwin.o && ./darwin.o && gcc final.c -o final.o
```
note that these its a especif designed for boostraping version, it does not suport
argv, env variables, etc, it only suport one file , called **main.lua**, that needs to
be in the same path that you are running, and its generates the **final.c** file,
containing all the lua virtual machine, and the code of main.lua, to be able to boostrap
to the next version

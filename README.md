# Darwin
A Boostrapped lua Compiler

Install:
download the: [Darwin](https://github.com/OUIsolutions/Darwin/releases/download/0.002/darwin002.c)
by typing 
```shel
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.002/darwin002.c -o darwin002.c 
```

and run
```shel
gcc darwin002.c -o darwin002.o && ./darwin002.o && gcc final002.c -o final002.o
```

note that these its a especif version its designed for boostraping, it does not suport
argv, env variables, etc, it only suport one file , called **main.lua**, that needs to
be in the same path that you are running, and its generates the **final002a.c** file,
containing all the lua virtual machine, and the code of main.lua, to be able to boostrap
to the next version

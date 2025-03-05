
## Building From source
for building from source,  type
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.1.21/darwin.c -o darwin.c &&
gcc darwin.c -o darwin.out
```
### Building From Docker
for building from docker,you must have darwin installed on version 0.020 and docker installed,clone the repo  then type
```bash
darwin run_blueprint build/ --mode folder  build_linux_from_docker build_windows_from_docker
```

### Building From Native
for building from native,you must have darwin installed on version 0.020,gcc with the **--static** flag and **mingw** installed,clone the repo  then type

```bash
darwin run_blueprint build/ --mode folder   build_linux build_windows
```
### Building Only source
you can build the source amalgamation **darwin.c** only
```bash
darwin run_blueprint build/ --mode folder   build_source
```

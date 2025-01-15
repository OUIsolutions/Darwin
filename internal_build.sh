sudo rm -rf release
./darwin.out build build/main.lua
gcc  release/darwin.c -o  release/darwin.out
sudo cp  release/darwin.out /home/mateusmoutinho/Documentos/darwin_test/darwin.out

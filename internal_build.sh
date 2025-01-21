sudo rm -rf release
./darwin.out build build/main.lua build_code build_linux_from_docker

sudo cp  release/darwin.out /home/mateusmoutinho/Documentos/darwin_test/darwin.out

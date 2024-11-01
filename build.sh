
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.008/darwin008.c -o darwin008.c
echo "get previus darwin"
gcc darwin008.c -o darwin008.o
echo "compilded the previus darwin"
./darwin008.o
echo "generate the new version"

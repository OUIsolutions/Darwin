
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.006/darwin006.c -o darwin006.c
echo "get previus darwin"
gcc darwin006.c -o darwin006.o
echo "compilded the previus darwin"
./darwin006.o
echo "generate the new version"

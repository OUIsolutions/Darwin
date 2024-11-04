
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.011/darwin011.c -o darwin011.c
echo "get previus darwin"
gcc darwin011.c -o darwin011.o
echo "compilded the previus darwin"
./darwin011.o
echo "generate the new version"

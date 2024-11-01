
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.009/darwin009.c -o darwin009.c
echo "get previus darwin"
gcc darwin009.c -o darwin009.o
echo "compilded the previus darwin"
./darwin009.o
echo "generate the new version"

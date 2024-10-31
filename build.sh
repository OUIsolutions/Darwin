
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.005/darwin005.c -o darwin005.c

echo ""
echo "get trivals darwin"
echo ""

gcc darwin005.c -o darwin005.o

echo "compilded the trivals darwin"
echo ""

./darwin005.o

echo "generate the new version"
echo ""

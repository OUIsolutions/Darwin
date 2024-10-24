
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.003/darwin003.c -o darwin003.c

echo ""
echo "get trivals darwin"
echo ""

gcc darwin003.c -o darwin003.o

echo "compilded the trivals darwin"
echo ""

./darwin003.o

echo "generate the new version"
echo ""


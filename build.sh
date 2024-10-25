
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.004/darwin003.c -o darwin004.c

echo ""
echo "get trivals darwin"
echo ""

gcc darwin003.c -o darwin003.o

echo "compilded the trivals darwin"
echo ""

./darwin003.o

echo "generate the new version"
echo ""


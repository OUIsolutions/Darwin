
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.004/darwin004.c -o darwin004.c

echo ""
echo "get trivals darwin"
echo ""

gcc darwin004.c -o darwin004.o

echo "compilded the trivals darwin"
echo ""

./darwin004.o

echo "generate the new version"
echo ""

mv darwin005.o /home/mateusmoutinho/Documentos/teste/darwin005.o
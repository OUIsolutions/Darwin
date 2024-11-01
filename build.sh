
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.010/darwin010.c -o darwin010.c
echo "get previus darwin"
gcc darwin010.c -o darwin010.o
echo "compilded the previus darwin"
./darwin010.o
echo "generate the new version"

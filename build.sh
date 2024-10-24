
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.001/darwin.c -o darwin.c
gcc darwin.c -o darwin.o && ./darwin.o && mv  final.c darwin002.c && gcc darwin002.c -o darwin002.o

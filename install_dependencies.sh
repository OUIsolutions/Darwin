rm -rf LuaDoTheWorld
rm -rf candangoEngine
git clone -b v0.72 https://github.com/OUIsolutions/LuaDoTheWorld.git
git clone -b V0.003 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git
curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.779/LuaCEmbed.h -o assets/LuaCEmbed.h
RUN curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.013/darwin013.c -o darwin.c
RUN gcc darwin.c -o darwin.o
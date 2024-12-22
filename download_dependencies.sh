rm -rf dependencies
mkdir dependencies
cd dependencies
git clone -b v0.72 https://github.com/OUIsolutions/LuaDoTheWorld.git
git clone -b V0.003 https://github.com/SamuelHenriqueDeMoraisVitrio/candangoEngine.git
curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.779/LuaCEmbed.h -o assets/LuaCEmbed.h
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.out -o darwin.out
sudo chmod +x darwin.out
mv  darwin.out ..

# Reversing script

cd ~/Programmation/Gits/Ombridride-minetest-minetestforfun-server-access/

# Removed old files... While saving IRC mod

rm -rf ./mods/*
rm -rf ./minetestforfun_game/*


# Copy files
cp -Rf ~/.minetest/worlds/NodesJustWannaHaveFun/worldmods/* ./mods/
cp -Rf ~/.minetest/games/minetestforfun_game/* ./minetestforfun_game/

echo "Finished"

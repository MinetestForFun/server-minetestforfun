#!/bin/bash

# Update MinetestForFun Sources

datecom=`date`
echo "[$datecom] Updated MinetestForFun Sources by $USER" >> ~/.git_sh_history

cd ~/Programmation/
cd Gits/Ombridride-minetest-minetestforfun-server-access

# If argument is passed, then update the clone
if [ ! -z $1 ]
then
	echo "=> Getting lastest sources..."
	# Actualize MFF's clone
	git checkout master
	git pull origin master
else
	echo "=> Skipping clone actualization"
fi

echo "=> Copying files..."
cd mods
rm -rf ~/.minetest/worlds/NodesJustWannaHaveFun/worldmods/*
cp -R ./* ~/.minetest/worlds/NodesJustWannaHaveFun/worldmods/

cd ..
rm -rf ~/.minetest/games/minetestforfun_game
cp -r ./minetestforfun_game ~/.minetest/games

cp -f ./worlds/minetestforfun/news.txt ~/.minetest/worlds/NodesJustWannaHaveFun/

echo "== Finished =="
sleep 2

   _____                       __  __           _ 
  / ____|                     |  \/  |         | |
 | (___  _ __   _____      __ | \  / | ___   __| |
  \___ \| '_ \ / _ \ \ /\ / / | |\/| |/ _ \ / _` |
  ____) | | | | (_) \ V  V /  | |  | | (_) | (_| |
 |_____/|_| |_|\___/ \_/\_/   |_|  |_|\___/ \__,_|
				
					Version 3.2
				
By Splizard and LazyJ.

Minetest version:  0.4.9
Depends: default
License:  GPL v2

Complimentary Mods: 
---------------------
*	"Snowdrift" by paramat
*	"More Blocks" by Calinou (2014_05_11 or newer)
*	"Skins" by Zeg9


Install:

Forum post: http://minetest.net/forum/viewtopic.php?id=2290
Github: https://github.com/Splizard/minetest-mod-snow
Website: http://splizard.com/minetest/mods/snow/

INSTALL:
----------
Place this folder in your minetest mods folder.
(http://dev.minetest.net/Installing_Mods)

	* After downloading, unzip the file.
	* Rename the directory "minetest-mod-snow-master" to "snow"
	* Copy the "snow" directory into either
	../minetest/worlds/yourworld'sname/worldmods/
	or
	../minetest/mods/
	* If you put "snow" in the ../minetest/mods/ directory, either
	enable the mod from within Minetest's "Configure" button
	(main menu, bottom right) or by adding this line to the
	world's "world.mt" file:
	load_mod_snow = true



NOTICE
While this mod is installed you may experience slower map loading while a snow biome is generated.

USAGE:
-------
If you walk around a bit you will find snow biomes scattered around the world.

There are nine biome types:
* Normal
* Icebergs
* Icesheet
* Broken icesheet
* Icecave
* Coast
* Alpine
* Snowy
* Plain
  
Snow can be picked up and thrown as snowballs or stacked into snow blocks.
Snow and ice melts when near warm blocks such as torches or igniters such as lava.
Snow blocks freeze water source blocks around them.
Moss can be found in the snow, when moss is placed near cobble it spreads.
Christmas trees can be found when digging pine needles.
Sleds allow for faster travel on snow.

CRAFTING:
-----------
Snow Brick:

Snow Block    Snow Block
Snow Block    Snow Block

Sled:
				Stick
Wood	Wood	Wood

Icy Snow:

Snow	Ice
Ice		Snow

MAPGEN_V7:
------------
If you are using minetest 0.4.8 or the latest dev version of minetest you can choose to generate a v7 map.
This option can be found when creating a new map from the menu.
Snow Biomes has support for this though you might need a couple other biomes too otherwise you will only spawn snow.
There are a couple of bugs and limitations with this such as no ice being generated at the moment.

Config file:
------------
After starting a game in minetest with snow mod, a config file will be placed in this folder that contains the various options for snow mod.
As admin you can use the /snow command in-game to make various changes.

UNINSTALL:
------------
Simply delete the folder snow from the mods folder.

Minetest mod: Hunger [hbhunger]
===============================
Version: 0.3.0

License of source code: WTFPL
-----------------------------
by Wuzzy (2015)

Forked from the “Better HUD (and hunger)” mod by BlockMen (2013-2014).


Using the mod:
--------------
This mod adds a mechanic for hunger.
This mod depends on the HUD bars mod [hudbars], major version 1.

You can create a "hunger.conf" file to customize the properties of hunger for your needs.

About hunger
============
This mod adds a hunger mechanic to the game.
A new player starts with 20 satiation points out of 30.
Player actions like digging, placing and walking cause exhausion, which lower the player's
satiation. Also every 800 seconds you lose 1 satiation point without doing anything.
If you are hungry (0 satiation) you will suffer damage and die in case you don't eat something.
If your satiation is greater than 15, you will slowly regenerate health points.
Eating food will increase your satiation.
Important: Eating food will not directly increase your health anymore, as long as the food item
is supported by this mod (see below).


Currently supported food:
-------------------------
- Apples (default)
- Animalmaterials (mobf modpack)
- Bread (default)
- Bushes
- bushes_classic
- Creatures
- Dwarves (beer and such)
- Docfarming
- Fishing
- Farming plus
- Farming (default and Tenplus1's fork)
- Food
- fruit
- Glooptest
- JKMod
- kpgmobs
- Mobfcooking
- Mooretrees
- Mtfoods
- mushroom
- mush45
- Seaplants (sea)
- Simple mobs

Examples: 
Eating an apple (from the default Minetest game) increases your satiation by 2,
eating a bread (from the default Minetest game) increases your satiation by 4.


License of textures:
--------------------
hunger_icon.png - PilzAdam (WTFPL), modified by BlockMen
hunger_bar.png - Wuzzy (WTFPL)

everything else is WTFPL:
(c) Copyright BlockMen (2013-2015)

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.


Thirst Mod for Minetest
This mod is part of the Survival Modpack for Minetest.
Copyright (C) 2013 Diego Martínez <lkaezadl3@gmail.com>

See the file `../LICENSE.txt' for information about distribution.

This mod adds thirst to the game. The player must drink some...drink...in
 order to not die from dehydration.

A warning will be sent to the player when thirsty, and if the player does not
 drink anything in a short time, he/she will die.

It currently supports only a few drinks: The apple juice and carrot juice from
 rubenwardy's Food mod, and a water glass defined by this mod. In all cases,
 you get an empty drinking glass after using the item (provided you have space
 in the inventory).

The water glass uses the drinking glass from the `vessels' mod. It can be
 obtained in these ways:
  - Crafting it with a drinking glass + a bucket of water (shapeless recipe;
     you get the bucket back), or...
  - By punching a "Source of water" (like a sink; not to be confused with
     `water_source') with an empty drinking glass. Currently supported
     sources are the Kitchen Cabinet with Sink (from homedecor), and the
     Bathroom Sink (from 3dforniture).

You can also craft a meter (or gauge). It shows your current thirst by means
 of a colored bar under the item (like tool wear). Craft it like this:

   +-------------+--------------+-------------+
   |             | wood planks  |             |
   +-------------+--------------+-------------+
   | wood planks | water bucket | wood planks |
   +-------------+--------------+-------------+
   |             | wood planks  |             |
   +-------------+--------------+-------------+

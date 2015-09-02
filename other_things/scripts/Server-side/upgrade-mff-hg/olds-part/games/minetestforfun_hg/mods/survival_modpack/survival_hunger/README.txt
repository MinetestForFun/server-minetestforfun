
Hunger Mod for Minetest
This mod is part of the Survival Modpack for Minetest.
Copyright (C) 2013 Diego Martínez <lkaezadl3@gmail.com>
Inspired by the existing hunger mod by randomproof.

See the file `../LICENSE.txt' for information about distribution.

This mod adds hunger to the game. The player must eat some...food...in
 order to not die.

When hungry, the player will be hurt (and will hear a characteristc sound);
 If the player does not eat anything in a short time, he/she will be damaged
 again, and so on until he eats something or dies.

It supports lot of items, and it can detect most "food" items defined by other
 mods. Currently, it supports the apple from the default game, all the eatable
 items in rubenwardy's Food mod, and PilzAdam's farming and farming_plus mods.

You can also craft a meter (or gauge). It shows your current hunger by means
 of a colored bar under the item (like tool wear). Craft it like this:

   +-------------+-------------+-------------+
   |             | wood planks |             |
   +-------------+-------------+-------------+
   | wood planks | apple       | wood planks |
   +-------------+-------------+-------------+
   |             | wood planks |             |
   +-------------+-------------+-------------+

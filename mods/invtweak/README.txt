Minetest mod "Inventory Tweaks"
===============================
version: 2.0

License of source code: WTFPL
-----------------------------
Written 2013-2015 by BlockMen

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.

License of sounds:
------------------
invtweak_break_tool.ogg by EdgardEdition (CC BY 3.0), http://www.freesound.org/people/EdgardEdition


~About~
-------
This mod add different new functions to Minetest.

First: This mod adds 3 different buttons to player inventory. With those buttons you can sort your inventory easily.
"›•"-Button concernates all stacks to their maximum size.
"^"-Button sorts all items in an ascending order
"v"-Button sorts all items in an descending order

NOTE: It's currently only working for the player inventory, not for chests or other formspecs.

Furthermore this mod has the ability to refill your wielded items automaticly. For example your current tool
break and you have one more of the same type (e.g. a stone pickaxe) this mod put it right in you hand
and you can keep digging our placing nodes without opening the inventory.
You can disable this setting by adding/changing following to your minetest.conf file: "invtweak_autorefill = false"

As a small gimmick it adds also a sound when a tool breaks, just to improve the atmosphere of the gameplay.


Supported mods:
- unified_inventory
- 3d_armor.


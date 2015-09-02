
Survival Mod for Minetest
-------------------------

Copyright (C) 2013 Diego Martínez <lkaezadl3@gmail.com>

This mod adds new hazards to the survival aspect of the game.
Currently, this adds hunger, thirst, and drowning. It's planned to add
stamina (tiredness), and temperature in the future.

See the file `LICENSE.txt' for information about distribution.

The survival_drowning mod is a modified version of the drowning mod by [who?].
The survival_hunger mod was written from scratch inspired by the existing
 hunger mod by [who?].

Forum topic: [TODO: Reserve topic]
Download: https://github.com/kaeza/minetest-survival_modpack/archive/master.zip
Github Repo: https://github.com/kaeza/minetest-survival_modpack

INSTALLING
----------
Unpack the modpack into one of the directories where Minetest looks for mods.
For more information, see http://wiki.minetest.com/wiki/Installing_mods

See the respective mods' TECHNOTE.txt for information about technical aspects
of the implementation and known bugs.

CONFIGURING
-----------
The mod can be configured by means of a `survival_lib.conf' file. This file
is read first from the survival_lib mod's directory, and then from the
current world directory (so you can have different settings per world).
Options set in `survival_lib/survival_lib.conf' override the defaults, and
those set in `<worlddir>/survival_lib.conf' override these, so you can
specify global defaults in the mod dir, and override those settings in the
world dir.

See `survival_lib.conf.example' for an example of what can be configured.

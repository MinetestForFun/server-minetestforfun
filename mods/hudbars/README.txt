Minetest mod: HUD bars
======================
Version: 1.0.2

This software uses semantic versioning, as defined by version 2.0.0 of the SemVer
standard. <http://semver.org/>


License of source code: WTFPL
-----------------------------
Author: Wuzzy (2015)
Forked from the “Better HUD” [hud] mod by BlockMen.


Using the mod:
--------------
This mod changes the HUD of Minetest. It replaces the default health and breath symbols by horizontal colored bars with text showing
the number.

Furthermore, it enables other mods to add their own custom bars to the HUD, this mod will place them accordingly.

You can create a “hudbars.conf” file to customize the positions of the health and breath bars. Take a look at “hudbars.conf.example”
to get more infos. The lines starting with “--” are comments, remove the two dashes to activate a setting. Settings which are not
set will use a default value instead.


IMPORTANT:
Keep in mind if running a server with this mod, that the custom position should be displayed correctly on every screen size!

API:
----
The API is used to add your own custom HUD bars.
Documentation for the API of this mod can be found in API.md.


License of textures:
--------------------
hudbars_icon_health.png - celeron55 (CC BY-SA 3.0), modified by BlockMen
hudbars_icon_breath.png - kaeza (WTFPL), modified by BlockMen
hudbars_bar_health.png - Wuzzy (WTFPL)
hudbars_bar_breath.png - Wuzzy (WTFPL)
hudbars_bar_background.png - Wuzzy(WTFPL)

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://sam.zoy.org/wtfpl/COPYING for more details.

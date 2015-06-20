soundset MOD for MINETEST
========================

by Mg (@LeMagnesium) and @crabman77

YOUR mod can use THIS mod to have a volume that's adjustable by the player(s)

EXEMPLE

minetest.sound_play("music_file", {to_player=player:get_player_name(),gain=sounds.get_gain(player:get_player_name(), "music")})

OR

minetest.sound_play("mob_sound", {to_player=player:get_player_name(),gain=sounds.get_gain(player:get_player_name(), "mobs")})

OR

minetest.sound_play("wind_sound", {to_player=player:get_player_name(),gain=sounds.get_gain(player:get_player_name(), "ambience")})




commandchat

/soundset : display menu

/soundsetg : display player config

/soundsets <music|ambience|mobs|other> <number> : set volume



Licenses images: Author:mikhog  http://opengameart.org/content/play-pause-mute-and-unmute-buttons  CC0 1.0 Universal (CC0 1.0) Public Domain Dedication

0.1 - Initial Release

0.2 - change default volume to 50, add serialise|deserialise to read|write config file

0.3 - add menu setting and button for unified_inventory and chatcommand to display menu

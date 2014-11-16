
local MODPATH = minetest.get_modpath("wiki")

wikilib = { }

dofile(MODPATH.."/strfile.lua")
dofile(MODPATH.."/oshelpers.lua")
dofile(MODPATH.."/wikilib.lua")
dofile(MODPATH.."/internal.lua")
dofile(MODPATH.."/plugins.lua")

dofile(MODPATH.."/plugin_forum.lua")

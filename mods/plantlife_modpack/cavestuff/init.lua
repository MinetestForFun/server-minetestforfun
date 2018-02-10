-----------------------------------------------------------------------------------------------
local title		= "Cave Stuff"
local version 	= "0.0.3"
local mname		= "cavestuff"
-----------------------------------------------------------------------------------------------

-- support for i18n
local S = plantlife_i18n.gettext

dofile(minetest.get_modpath("cavestuff").."/nodes.lua")
dofile(minetest.get_modpath("cavestuff").."/mapgen.lua")

-----------------------------------------------------------------------------------------------

minetest.log("action", "[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...") --MFF

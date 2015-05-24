-----------------------------------------------------------------------------------------------
local title		= "Cave Stuff"
local version 	= "0.0.3"
local mname		= "cavestuff"
-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("cavestuff").."/nodes.lua")
dofile(minetest.get_modpath("cavestuff").."/mapgen.lua")

-----------------------------------------------------------------------------------------------

minetest.log("action", "[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")

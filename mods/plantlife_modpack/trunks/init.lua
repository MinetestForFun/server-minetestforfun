-----------------------------------------------------------------------------------------------
local title		= "Trunks"
local version 	= "0.1.4"
local mname		= "trunks"
-----------------------------------------------------------------------------------------------
-- Code by Mossmanikin & Neuromancer

abstract_trunks = {}

-- support for i18n
local S = plantlife_i18n.gettext

dofile(minetest.get_modpath("trunks").."/trunks_settings.txt")
dofile(minetest.get_modpath("trunks").."/generating.lua")
dofile(minetest.get_modpath("trunks").."/nodes.lua")
dofile(minetest.get_modpath("trunks").."/crafting.lua")

-----------------------------------------------------------------------------------------------
minetest.log("action", "[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...") --MFF
-----------------------------------------------------------------------------------------------

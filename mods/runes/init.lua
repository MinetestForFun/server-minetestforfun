-- Rune mod by Mg
-- License GPLv3

local modpath = minetest.get_modpath("runes")

runes = {}

-- API first
dofile(modpath.."/api.lua")

-- Then the rune themselves
dofile(modpath.."/registration.lua")

-- The handlers
dofile(modpath.."/handlers.lua")

-- The amulets
dofile(modpath.."/amulets.lua")

---- From this point everything is redo ----

-- Stylus
dofile(modpath .. "/glyphs.lua")

-- Scrolls
dofile(modpath .. "/scrolls.lua")

minetest.log("action","[runes] Mod loaded")

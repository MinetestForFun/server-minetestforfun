---------------------
-- Server Misc Mod --
---------------------

-- Give initial stuff
dofile(minetest.get_modpath("_misc").."/give_initial_stuff.lua")

-- Chat Commands
dofile(minetest.get_modpath("_misc").."/chatcommands.lua")

-- No Interact Messages
dofile(minetest.get_modpath("_misc").."/nointeract_messages.lua")

-- irc
dofile(minetest.get_modpath("_misc").."/irc.lua")
-- No Shout Messages
dofile(minetest.get_modpath("_misc").."/noshout_messages.lua")

-- Aliases
dofile(minetest.get_modpath("_misc").."/aliases.lua")

-- Craft Obsidian
dofile(minetest.get_modpath("_misc").."/craft_obsidian.lua")

-- UnCraft Woll
dofile(minetest.get_modpath("_misc").."/uncraft_woll.lua")

-- List players
dofile(minetest.get_modpath("_misc").."/list_players.lua")

-- Desert Sand/Sand swap
dofile(minetest.get_modpath("_misc").."/sand_swapping.lua")

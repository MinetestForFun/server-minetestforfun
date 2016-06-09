---------------------
-- Server Misc Mod --
---------------------

local cwd = minetest.get_modpath("_misc")

-- Give initial stuff
dofile(cwd.."/give_initial_stuff.lua")

-- Chat Commands
dofile(cwd.."/chatcommands.lua")

-- No Interact Messages
dofile(cwd.."/nointeract_messages.lua")

-- irc
dofile(cwd.."/irc.lua")
-- No Shout Messages
dofile(cwd.."/noshout_messages.lua")

-- Aliases
dofile(cwd.."/aliases.lua")

-- Craft Obsidian
dofile(cwd.."/craft_obsidian.lua")

-- UnCraft Woll
dofile(cwd.."/uncraft_woll.lua")

-- List players
dofile(cwd.."/list_players.lua")

-- Desert Sand/Sand swap
dofile(cwd.."/sand_swapping.lua")

-- Sapling craft recipes
dofile(cwd.."/sapling_crafts.lua")

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname) 

local thismod = {}
_G[modname] = thismod

local start = os.time()
minetest.log('action', "[" .. modname .. "] Loading")

dofile(modpath .. '/aliases.lua')

dofile(modpath .. '/abms.lua')
dofile(modpath .. '/biomes.lua')
dofile(modpath .. '/nodes.lua')
dofile(modpath .. '/trees.lua')
dofile(modpath .. '/craftitems.lua')
dofile(modpath .. '/registers.lua')
dofile(modpath .. '/crafting.lua')
dofile(modpath .. '/mapgen.lua')

minetest.log('action', "[" .. modname .. "] Loaded in " .. (os.time() - start)  .. " seconds")

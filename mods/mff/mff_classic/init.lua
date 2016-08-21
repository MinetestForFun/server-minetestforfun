local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname) 

local thismod = {}
_G[modname] = thismod

dofile(modpath .. '/aliases.lua')

dofile(modpath .. '/abms.lua')
dofile(modpath .. '/biomes.lua')
dofile(modpath .. '/mapgen.lua')
dofile(modpath .. '/nodes.lua')
dofile(modpath .. '/trees.lua')
dofile(modpath .. '/registers.lua')

local title   = "minesimon By Crabman77"
local version = "0.0.0"
local mname   = "minesimon"

minetest.log("action","[mod minesimon] Loading...")
local path = minetest.get_modpath("minesimon").."/"

minesimon = {}
minesimon["players"] = {}
minesimon["games"] = {}
minesimon["notes"] = {1,2,3,4}
-- load engine
dofile(path .."engine.lua")
-- load nodes
dofile(path .."nodes.lua")

-----------------------------------------------------------------------------------------------
minetest.log("action", "[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------


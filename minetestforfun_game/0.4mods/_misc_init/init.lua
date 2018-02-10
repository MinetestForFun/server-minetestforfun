----------------------------------------
-- Server Misc Mod - pre-default init --
----------------------------------------

local cwd = minetest.get_modpath(minetest.get_current_modname())

-- Inventory refill function override
-- see https://github.com/MinetestForFun/server-minetestforfun/issues/462
dofile(cwd.."/inventory_rotate_node.lua")

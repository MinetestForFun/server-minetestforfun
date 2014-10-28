-- Nature Classic mod
-- Originally by neko259

-- Nature is slowly capturing the world!

local current_mod_name = minetest.get_current_modname()

dofile(minetest.get_modpath(current_mod_name) .. "/config.lua")
dofile(minetest.get_modpath(current_mod_name) .. "/global_function.lua")
dofile(minetest.get_modpath(current_mod_name) .. "/blossom.lua")

minetest.log("info", "[Nature Classic] loaded!")

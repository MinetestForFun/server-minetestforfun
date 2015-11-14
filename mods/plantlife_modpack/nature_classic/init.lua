-- Nature Classic mod
-- Originally by neko259

-- Nature is slowly capturing the world!

local current_mod_name = minetest.get_current_modname()

nature = {}
nature.blossomqueue = {}
nature.blossomqueue_max = 1000

nature.blossom_node = "nature:blossom"
nature.blossom_leaves = "default:leaves"
nature.blossom_textures = { "default_leaves.png^nature_blossom.png" }

if minetest.get_modpath("moretrees") then
	nature.blossom_node = "moretrees:apple_blossoms"
	nature.blossom_leaves = "moretrees:apple_tree_leaves"
	nature.blossom_textures = { "moretrees_apple_tree_leaves.png^nature_blossom.png" }
	minetest.register_alias("nature:blossom", "default:leaves")
end

nature.leaves_blossom_chance = 15
nature.blossom_leaves_chance = 5
nature.blossom_delay = 3600
nature.apple_delay = 3600
nature.apple_chance = 10
nature.apple_spread = 2

nature.meta_blossom_time = "blossom_time"
nature.blossom_duration = nature.blossom_delay

function dumppos(pos)
	return "("..pos.x..","..pos.y..","..pos.z..")"
end

dofile(minetest.get_modpath(current_mod_name) .. "/config.lua")
dofile(minetest.get_modpath(current_mod_name) .. "/global_function.lua")
dofile(minetest.get_modpath(current_mod_name) .. "/blossom.lua")

minetest.log("info", "[Nature Classic] loaded!")

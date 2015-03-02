-- Bushes classic mod originally by unknown
-- now maintained by VanessaE
--
-- License:  WTFPL

local S = plantslib.intllib

bushes_classic = {}

bushes_classic.bushes = {
    "strawberry",
	"blackberry",
	"blueberry",
	"raspberry",
	"gooseberry",
	"mixed_berry"
}

bushes_classic.bushes_descriptions = {
    "Strawberry",
	"Blackberry",
	"Blueberry",
	"Raspberry",
	"Gooseberry",
	"Mixed Berry"
}

bushes_classic.spawn_list = {}

dofile(minetest.get_modpath('bushes_classic') .. '/cooking.lua')
dofile(minetest.get_modpath('bushes_classic') .. '/nodes.lua')

plantslib:spawn_on_surfaces({
	spawn_delay = 3600,
	spawn_plants = bushes_classic.spawn_list,
	avoid_radius = 10,
	spawn_chance = 100,
	spawn_surfaces = {
		"default:dirt_with_grass",
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"farming:soil",
		"farming:soil_wet"
	},
	avoid_nodes = {"group:bush"},
	seed_diff = 545342534, -- chosen by a fair mashing of the keyboard - guaranteed to be random :P
	plantlife_limit = -0.1,
	light_min = 10,
	temp_min = 0.15, -- approx 20C
	temp_max = -0.15, -- approx 35C
	humidity_min = 0, -- 50% RH
	humidity_max = -1, -- 100% RH
})

minetest.register_alias("bushes:basket_pies", "bushes:basket_strawberry")

print(S("[Bushes] Loaded."))

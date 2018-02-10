-- Bushes classic mod originally by unknown
-- now maintained by VanessaE
--
-- License:  WTFPL

bushes_classic = {}

-- support for i18n
local S = plantlife_i18n.gettext

bushes_classic.bushes = {
  "strawberry",
	"blackberry",
	"blueberry",
	"raspberry",
	"gooseberry",
	"mixed_berry"
}

bushes_classic.bushes_descriptions = {
	{S("Strawberry"),  S("Raw Strawberry pie"),  S("Cooked Strawberry pie"),  S("Slice of Strawberry pie"),  S("Basket with Strawberry pies"),  S("Strawberry Bush")},
	{S("Blackberry"),  S("Raw Blackberry pie"),  S("Cooked Blackberry pie"),  S("Slice of Blackberry pie"),  S("Basket with Blackberry pies"),  S("Blackberry Bush")},
	{S("Blueberry"),   S("Raw Blueberry pie"),   S("Cooked Blueberry pie"),   S("Slice of Blueberry pie"),   S("Basket with Blueberry pies"),   S("Blueberry Bush")},
	{S("Raspberry"),   S("Raw Raspberry pie"),   S("Cooked Raspberry pie"),   S("Slice of Raspberry pie"),   S("Basket with Raspberry pies"),   S("Raspberry Bush")},
	{S("Gooseberry"),  S("Raw Gooseberry pie"),  S("Cooked Gooseberry pie"),  S("Slice of Gooseberry pie"),  S("Basket with Gooseberry pies"),  S("Gooseberry Bush")},
	{S("Mixed Berry"), S("Raw Mixed Berry pie"), S("Cooked Mixed Berry pie"), S("Slice of Mixed Berry pie"), S("Basket with Mixed Berry pies"), S("Currently fruitless Bush")}
}

bushes_classic.spawn_list = {}

local modpath = minetest.get_modpath('bushes_classic')
dofile(modpath..'/cooking.lua')
dofile(modpath..'/nodes.lua')

biome_lib:spawn_on_surfaces({
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

minetest.log("action", S("[Bushes] Loaded.")) --MFF

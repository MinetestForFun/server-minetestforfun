
-- Spider by AspireMint (fishyWET (CC-BY-SA 3.0 license for texture)

mobs:register_mob("mobs:spider", {
	docile_by_day = true,
	type = "monster",
	-- agressive, does 6 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 4,
	-- health & armor
	hp_min = 25,
	hp_max = 35,
	armor = 200,
	-- textures and model
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	visual = "mesh",
	mesh = "mobs_spider.x",
	textures = {
		{"mobs_spider.png"},
	},
	visual_size = {x = 7, y = 7},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_spider",
		war_cry = "mobs_eerie",
		death = "mobs_howl",
		attack = "mobs_spider_attack",
	},
	-- speed and jump, sinks in water
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	view_range = 16,
	floats = 0,
	-- drops string with a chance of sandstone or crystal spike if Ethereal installed
	drops = {
		{name = "farming:string", chance = 2, min = 1, max = 3,},
		{name = "mobs:meat_raw", chance = 4, min = 1, max = 2,},
		{name = "maptools:silver_coin", chance = 3, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 50,
		punch_end = 90,
	},
})

-- spawn on jungleleaves/jungletree, between 0 and 5 light, 1 in 10000 chance, 1 in area up to 31000 in height
mobs:spawn_specific("mobs:spider", {"default:jungleleaves", "default:jungletree"}, {"air"}, -1, 20, 30, 10000, 1, -31000, 31000, false)

-- register spawn egg
mobs:register_egg("mobs:spider", "Spider", "mobs_spider_inv.png", 1)

-- ethereal crystal spike compatibility
if not minetest.get_modpath("ethereal") then
	minetest.register_alias("ethereal:crystal_spike", "default:sandstone")
end

-- spider cobweb
minetest.register_node("mobs:spider_cobweb", {
	description = "Spider Cobweb", --Description changé pour éviter conflit avec homedecor_modpack
	drawtype = "plantlike",
	visual_scale = 1.1,
	tiles = {"mobs_cobweb.png"},
	inventory_image = "mobs_cobweb.png",
	paramtype = "light",
	sunlight_propagates = true,
	liquid_viscosity = 11,
	liquidtype = "source",
	liquid_alternative_flowing = "mobs:spider_cobweb", --Modif MFF
	liquid_alternative_source = "mobs:spider_cobweb",  --Modif MFF
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	groups = {snappy = 1, liquid = 3},
	drop = "farming:cotton",
	sounds = default.node_sound_leaves_defaults(),
})

-- spider cobweb craft (MFF : indentation modifié)
minetest.register_craft( {
	output = "mobs:spider_cobweb",
	recipe = {
		{ "", 			"",	"farming:string"},
		{ "farming:string", 	"", 		""	},
		{ "",	 		"", 	"farming:string"}
	},
})

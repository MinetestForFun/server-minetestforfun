
-- Spider by fishyWET (borrowed from Lord of the Test [game])

mobs:register_mob("mobs:spider", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, does 4 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 6,
	-- health & armor
	hp_min = 30, hp_max = 40, armor = 100,
	-- textures and model
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	visual = "mesh",
	mesh = "mobs_spider.x",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"mobs_spider.png"},
	},
	visual_size = {x=7,y=7},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_spider",
		war_cry = "mobs_eerie",
		death = "mobs_howl",
		attack = "mobs_spider",
	},
	-- speed and jump, sinks in water
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	view_range = 16,
	floats = 0,
	-- drops string with a chance of sandstone or crystal spike if Ethereal installed
    drops = {
		{name = "farming:string",
		chance = 2, min = 1, max = 3,},
		{name = "mobs:meat_raw",
		chance = 4, min = 1, max = 2,},
		{name = "maptools:copper_coin",
		chance = 2, min = 2, max = 6,},
	},
	-- damaged by
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 1,		stand_end = 1,
		walk_start = 20,		walk_end = 40,
		run_start = 20,			run_end = 40,
		punch_start = 50,		punch_end = 90,
	},
})
-- spawn on desert stone/crystal dirt, between 0 and 5 light, 1 in 7000 chance, 1 in area up to 71 in height
mobs:register_spawn("mobs:spider", {"default:jungleleaves", "default:jungletree"}, 20, -1, 8000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:spider", "Spider", "mobs_cobweb.png", 1)

-- Ethereal crystal spike compatibility
if not minetest.get_modpath("ethereal") then
	minetest.register_alias("ethereal:crystal_spike", "default:sandstone")
end

-- Spider Cobweb
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
	liquid_alternative_flowing = "mobs:spider_cobweb",
	liquid_alternative_source = "mobs:spider_cobweb",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	groups = {snappy=1,liquid=3},
	drop = "farming:cotton",
	sounds = default.node_sound_leaves_defaults(),
})

-- Spider Cobweb craft (MFF : indentation modifié)
minetest.register_craft( {
	output = "mobs:spider_cobweb",
	recipe = {
		{ "farming:string", 	"", 			"farming:string" 	},
		{ "", 			"farming:string", 	"" 			},
		{ "farming:string", 	"", 			"farming:string" 	}
	},
})

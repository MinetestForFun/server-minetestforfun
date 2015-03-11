
-- Glowtest Spider

mobs:register_mob("mobs:spider", {
	type = "monster",
	hp_min = 30,
	hp_max = 35,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	--textures = {"mobs_spider.png"},
	available_textures = {
		total = 1,
		texture_1 = {"mobs_spider.png"},
	},
	visual_size = {x=7,y=7},
	visual = "mesh",
	mesh = "mobs_spider.x",
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
    armor = 100,
	damage = 4,
	drops = {
		{name = "farming:string",
		chance = 2,
		min = 2,
		max = 3,},
		{name = "mobs:meat_raw",
		chance = 4,
		min = 1,
		max = 2,},
		{name = "ethereal:crystal_spike",
		chance = 15,
		min = 1,
		max = 2,},
		{name = "maptools:copper_coin",
		chance = 2,
		min = 2,
		max = 6,},
	},
    light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
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
	sounds = {
		random = "mobs_spider",
		war_cry = "mobs_eerie",
		death = "mobs_howl",
		attack = "mobs_oerkki_attack",
	},
	jump = true,
	sounds = {},
	step = 1,
	blood_texture = "mobs_blood.png",
	floats = 0,
})
mobs:register_spawn("mobs:spider", {"default:junglegrass", "default:jungleleaves", "default:jungletree"}, 20, -1, 8000, 1, 31000)
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

-- Spider Cobweb craft
minetest.register_craft( {
	output = "mobs:spider_cobweb",
	recipe = {
		{ "farming:string", 	"", 			"farming:string" 	},
		{ "", 			"farming:string", 	"" 			},
		{ "farming:string", 	"", 			"farming:string" 	}
	},
})


--= Lava Flan by Zeg9

minetest.register_craftitem("mobs:lava_orb", {
	description = "Lava orb",
	inventory_image = "zmobs_lava_orb.png",
	on_place = function(itemstack, placer, pointed_thing)
	end,
})

minetest.register_alias("zmobs:lava_orb", "mobs:lava_orb")

mobs:register_mob("mobs:lava_flan", {
	type = "monster",
	hp_min = 20,
	hp_max = 35,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_lava_flan.x",
	--textures = {"zmobs_lava_flan.png"},
	available_textures = {
		total = 1,
		texture_1 = {"zmobs_lava_flan.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 0.5,
	run_velocity = 2,
	damage = 3,
	drops = {
		{name = "mobs:lava_orb",
		chance = 10,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 0,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 8,
		walk_start = 10,
		walk_end = 18,
		run_start = 20,
		run_end = 28,
		punch_start = 20,
		punch_end = 28,
	},
	sounds = {
		random = "mobs_lavaflan",
	},
	jump = true,
	step = 2,
	blood_texture = "fire_basic_flame.png",
})
mobs:register_spawn("mobs:lava_flan", {"default:lava_source"}, 15, -1, 1000, 3, 0)

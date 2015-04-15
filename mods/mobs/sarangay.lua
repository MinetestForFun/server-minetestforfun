mobs:register_mob("mobs:sarangay", {
	type = "monster",
	passive = false,
	damage = 5,
	hp_min = 40,
	hp_max = 60,
	armor = 90,
	collisionbox = {-0.9,-0.01,-0.9, 0.9,2.5,0.9},
	attack_type = "dogfight",
	visual = "mesh",
	mesh = "mobs_sarangay.b3d",
	textures = {
		{"mobs_sarangay.png"},
	},
	visual_size = {x=1,y=1},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = false, -- to be changed
	drops = {
		{name = "default:desert_sand",
		chance = 1, min = 3, max = 5,},
		{name = "maptools:copper_coin",
		chance = 2, min = 2, max = 4,},
		{name = "mobs:minotaur_eye",
		chance = 10, min = 1, max = 2,},
	},
	water_damage = 3,
	lava_damage = 4,
	light_damage = 0,
	walk_velocity = 3,
	run_velocity = 5,
	view_range = 16,
	jump = true,
	floats = 0,

	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start  = 0,		stand_end = 19,
		walk_start = 20,		walk_end  = 39,
		run_start  = 20,		run_end = 39,
		punch_start = 40,		punch_end = 50,
	},
})

minetest.register_craftitem("mobs:minotaur_eye", {
	description = "Minotaur eye",
	inventory_image = "mobs_minotaur_eye.png",
	groups = {magic = 1},
})

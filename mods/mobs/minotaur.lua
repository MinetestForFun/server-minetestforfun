
-- Minotaur Monster by ???

mobs:register_mob("mobs:minotaur", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 11 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 11,
	-- health & armor
	hp_min = 50,
	hp_max = 75,
	armor = 60,
	-- textures and model
	collisionbox = {-0.9,-0.01,-0.9, 0.9,2.5,0.9},
	visual = "mesh",
	mesh = "mobs_minotaur.b3d",
	textures = {
		{"mobs_minotaur.png"},
	},
	visual_size = {x=1, y=1},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	-- sounds = {
		-- random = "mobs_zombie",
		-- damage = "mobs_zombie_hit",
		-- attack = "mobs_zombie_attack",
		-- death = "mobs_zombie_death",
	-- },
	-- speed and jump
	walk_velocity = 2,
	run_velocity = 4,
	jump = true,
	floats = 1,
	view_range = 16,
	knock_back = 0,		--this is a test
	-- drops desert_sand and coins when dead
	drops = {
		{name = "maptools:gold_coin",
		chance = 40, min = 1, max = 1,},
		{name = "mobs:minotaur_eye",	 	-- NOT IMPLEMENTED YET - used for runes mod
		chance = 1, min = 1, max = 2,},
		{name = "mobs:minotaur_horn",	 	-- NOT IMPLEMENTED YET - used for 3d_armor/throwing_enhanced mod
		chance = 1, min = 1, max = 2,},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start  = 0,		stand_end = 19,
		walk_start = 20,		walk_end  = 39,
		run_start  = 20,		run_end = 39,
		punch_start = 40,		punch_end = 50,
	},
})
-- spawns on desert sand between -1 and 20 light, 1 in 20000 chance, 1 Minotaur in area up to 31000 in height
mobs:register_spawn("mobs:minotaur", {"default:desert_sand"}, 20, -1, 20000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:minotaur", "Minotaur", "default_desert_sand.png", 1)


minetest.register_craftitem("mobs:minotaur_eye", {
	description = "Minotaur Eye",
	inventory_image = "mobs_minotaur_eye.png",
	groups = {magic = 1},
})

minetest.register_craftitem("mobs:minotaur_horn", {
	description = "Minotaur Horn",
	inventory_image = "mobs_minotaur_horn.png",
	groups = {magic = 1},
})

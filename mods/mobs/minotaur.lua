
-- Minotaur Monster by ???

mobs:register_mob("mobs:minotaur", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 6 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 6,
	-- health & armor
	hp_min = 40,
	hp_max = 60,
	armor = 90,
	-- textures and model
	collisionbox = {-0.9,-0.01,-0.9, 0.9,2.5,0.9},
	visual = "mesh",
	mesh = "mobs_minotaur.b3d",
	textures = {
		{"mobs_minotaur.png"},
	},
	rotate = 1.5,
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
	-- drops desert_sand and coins when dead
	drops = {
		{name = "default:desert_sand",
		chance = 1, min = 3, max = 5,},
		{name = "maptools:copper_coin",
		chance = 5, min = 2, max = 4,},
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

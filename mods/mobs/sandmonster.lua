
-- Sand Monster by PilzAdam

mobs:register_mob("mobs:sand_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health & armor
	hp_min = 15,
	hp_max = 20,
	armor = 90,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.x",
	textures = {
		{"mobs_sand_monster.png"},
	},
	visual_size = {x=8,y=8},
	blood_texture = "default_sand.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sandmonster",
	},
	-- speed and jump, sinks in water
	walk_velocity = 3,
	run_velocity = 5,
	view_range = 16,
	jump = true,
	floats = 0,
	-- drops desert sand when dead
	drops = {
		{name = "default:desert_sand",
		chance = 1, min = 3, max = 5,},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 3,
	lava_damage = 4,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 39,
		walk_start = 41,		walk_end = 72,
		run_start = 74,			run_end = 105,
		punch_start = 74,		punch_end = 105,
	},
})
-- spawns on desert sand between -1 and 20 light, 1 in 15000 chance, 1 sand monster in area up to 31000 in height
mobs:register_spawn("mobs:sand_monster", {"default:desert_sand", "default:sand"}, 20, -1, 15000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:sand_monster", "Sand Monster", "default_desert_sand.png", 1)

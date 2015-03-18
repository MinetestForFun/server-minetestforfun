
-- Stone Monster by PilzAdam

mobs:register_mob("mobs:stone_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health & armor
	hp_min = 30, hp_max = 35, armor = 60,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"mobs_stone_monster.png"},
	},
	visual_size = {x=3, y=2.6},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster",
	},
	-- speed and jump, sinks in water
	walk_velocity = 2,
	run_velocity = 4,
	jump = true,
	step = 1,
	floats = 0,
	view_range = 16,
	-- chance of dropping torch, iron, lump and coins
	drops = {
		{name = "default:torch",
		chance = 10, min = 3, max = 5,},
		{name = "default:iron_lump",
		chance = 5, min = 1, max = 2,},
		{name = "default:coal_lump",
		chance = 3, min = 1, max = 3,},
		{name = "maptools:silver_coin",
		chance = 2, min = 2, max = 3,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 14,
		walk_start = 15,		walk_end = 38,
		run_start = 40,			run_end = 63,
		punch_start = 40,		punch_end = 63,
	},
})
-- spawns on stone between -1 and 5 light, 1 in 5500 chance, 1 in area below -5
mobs:register_spawn("mobs:stone_monster", {"default:stone", "nether:dirt_top"}, 5, -1, 5500, 1, -5)
-- register spawn egg
mobs:register_egg("mobs:stone_monster", "Stone Monster", "default_stone.png", 1)

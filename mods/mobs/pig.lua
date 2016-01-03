
-- Piggy by farfadet46

mobs:register_mob("mobs:pig", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	damage = 4,
	-- health & armor
	hp_min = 15,
	hp_max = 20,
	armor = 200,
	-- textures and model
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.1, 0.8},
	visual = "mesh",
	mesh = "mobs_pig.b3d",
	drawtype = "front",
	textures = {
		{"mobs_pig_pink.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1,y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
--		random = "mobs_pig", We don't have that yet
	},
	-- speed and jump
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = false,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 4},
		{name = "maptools:copper_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 55,
		walk_start = 60,		walk_end = 100,
		punch_start = 60,		punch_end = 100,
	},
	view_range = 10,
})
-- spawn on dirt_with_grass between -1 and 20 light, 1 in 20000 chance, 1 goat in area up to 31000 in height
mobs:spawn_specific("mobs:pig", {"default:dirt_with_grass"}, {"air"}, -1, 20, 30, 10000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("mobs:pig", "Pig", "mobs_pig_inv.png", 1)


-- Goat by DonBatman

mobs:register_mob("mobs:goat", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	-- health & armor
	hp_min = 10,
	hp_max = 20,
	armor = 200,
	-- textures and model
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
	visual = "mesh",
	mesh = "mobs_goat.b3d",
	drawtype = "front",
	textures = {
		{"mobs_goat_white.png"},
		{"mobs_goat_brown.png"},
		{"mobs_goat_grey.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2,y=2},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	-- speed and jump
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = true,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 4},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 1,		stand_end = 60, -- head down/up
		walk_start = 122,		walk_end = 182, -- walk
		run_start = 122,		run_end = 182, -- walk
		punch_start = 183,		punch_end = 267, -- attack
	},
	-- follows wheat
	follow = "farming:wheat",
	view_range = 10,
	-- replace grass/wheat with air (eat)
	replace_rate = 50,
	replace_what = {"group:flora"},
	replace_with = "air",
})
-- spawn on dirt_with_grass between -1 and 20 light, 1 in 20000 chance, 1 goat in area up to 31000 in height
mobs:spawn_specific("mobs:goat", {"default:dirt_with_grass"}, {"air"}, -1, 20, 30, 10000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("mobs:goat", "Goat", "mobs_goat_inv.png", 1)

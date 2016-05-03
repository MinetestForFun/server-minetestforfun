
-- Oerkki by PilzAdam

mobs:register_mob("mobs:oerkki", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 7 damage when player hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 5,
	-- health & armor
	hp_min = 30,
	hp_max = 40,
	armor = 100,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.b3d",
	textures = {
		{"mobs_oerkki.png"},
		{"mobs_oerkki2.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_oerkki",
		shoot_attack = "mobs_oerkki_attack",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 3,
	view_range = 16,
	jump = true,
	-- chance of dropping obsidian and coins
	drops = {
		{name = "default:obsidian", chance = 3, min = 1, max = 2,},
		{name = "maptools:silver_coin", chance = 1, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 2,
	lava_damage = 4,
	light_damage = 1,
	fear_height = 4,
	-- model animation
	animation = {
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 36,
		run_start = 37,
		run_end = 49,
		punch_start = 37,
		punch_end = 49,
		speed_normal = 15,
		speed_run = 15,
	},
	-- replace torch with air (remove)
	replace_rate = 50,
	replace_what = {"default:torch"},
	replace_with = "air",
	replace_offset = -1,
})
-- spawns on stone/sandstone between 5 and -1 light, 1 in 9000 chance, 1 in area starting at -10 and below
mobs:spawn_specific("mobs:oerkki", {"default:stone", "default:sandstone"}, {"air"}, -1, 5, 30, 9000, 1, -31000, -75, false)
-- register spawn egg
mobs:register_egg("mobs:oerkki", "Oerkki", "mobs_oerkki_inv.png", 1)

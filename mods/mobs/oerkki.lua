
-- Oerkki by PilzAdam

mobs:register_mob("mobs:oerkki", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage when player hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health & armor
	hp_min = 40, hp_max = 50, armor = 90,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.x",
	drawtype = "front",
	available_textures = {
		total = 2,
		texture_1 = {"mobs_oerkki.png"},
		texture_2 = {"mobs_oerkki2.png"},
	},
	visual_size = {x=5, y=5},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_oerkki",
		attack = "mobs_oerkki_attack",
	},
	-- speed and jump
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 16,
	jump = true,
	step = 1,
	-- chance of dropping obsidian and coins
	drops = {
		{name = "default:obsidian",
		chance = 3, min = 1, max = 2,},
		{name = "maptools:silver_coin",
		chance = 2, min = 2, max = 3,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	-- model animation
	animation = {
		stand_start = 0,		stand_end = 23,
		walk_start = 24,		walk_end = 36,
		run_start = 37,			run_end = 49,
		punch_start = 37,		punch_end = 49,
		speed_normal = 15,		speed_run = 15,
	},
	-- replace torch with air (remove)
	replace_rate = 50,
	replace_what = {"default:torch"},
	replace_with = "air",
	replace_offset = -1,
})
-- spawns on stone between 5 and -1 light, 1 in 7000 chance, 1 in area starting at -10 and below
mobs:register_spawn("mobs:oerkki", {"default:stone"}, 5, -1, 7000, 1, -10)
-- register spawn egg
mobs:register_egg("mobs:oerkki", "Oerkki", "default_obsidian.png", 1)

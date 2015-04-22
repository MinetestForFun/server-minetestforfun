
-- Wolf (from Mobs_plus)

mobs:register_mob("mobs:wolf", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, does 4 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health & armor
	hp_min = 15, hp_max = 20, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	drawtype = "front",
	textures = {
		{"mobs_wolf.png"},
	},
	--visual_size = {x=1,y=1}, --Quel valeur lui mettre ?
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_wolf",
	},
	-- speed and jump
	walk_velocity = 3,
	run_velocity = 5,
	jump = true,
	view_range = 16,
	-- drops mese or diamond when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
		{name = "maptools:copper_coin",
		chance = 2,
		min = 1,
		max = 4,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	-- model animation
	animation = {
		stand_start = 0,		stand_end = 14,
		walk_start = 15,		walk_end = 38,
		run_start = 40,			run_end = 63,
		punch_start = 40,		punch_end = 63,
		speed_normal = 15,		speed_run = 15,

	},
})
mobs:register_spawn("mobs:wolf", {"default:dirt_with_grass"}, 3, -1, 9500, 1, 31000)
mobs:register_egg("mobs:wolf", "Wolf", "mobs_wolf_inv.png", 1)
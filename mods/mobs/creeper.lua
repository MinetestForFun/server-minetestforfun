
-- Creeper by Davedevils (from his subgame MineClone)

mobs:register_mob("mobs:creeper", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, does 21 damage to player when explode
	passive = false,
	attack_type = "explode",
	pathfinding = false,
	damage = 21,
	-- health & armor
	hp_min = 30, hp_max = 40, armor = 100,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_tree_monster.b3d",
	drawtype = "front",
	textures = {
		{"mobs_creeper.png"},
	},
	blood_texture = "mobs_creeper_inv.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_treemonster",
		explode= "tnt_explode",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	view_range = 16,
	-- drops mese or diamond when dead
	drops = {
		{name = "default:torch",
		chance = 10, min = 3, max = 5,},
		{name = "default:iron_lump",
		chance = 5, min = 1, max = 2,},
		{name = "default:coal_lump",
		chance = 3, min = 1, max = 3,},
	},
	-- damaged by
	water_damage = 2,
	lava_damage = 15,
	light_damage = 0,
	-- model animation
	animation = {
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
		speed_normal = 15,
		speed_run = 15,
	},
})
mobs:spawn_specific("mobs:creeper", {"default:dirt_with_grass"}, {"air"}, 8, 20, 30, 25000, 1, -31000, 31000, false)
mobs:register_egg("mobs:creeper", "Creeper", "mobs_creeper_inv.png", 1)

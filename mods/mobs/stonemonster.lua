
-- Stone Monster by PilzAdam

mobs:register_mob("mobs:stone_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 8 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 4,
	-- health & armor
	hp_min = 20,
	hp_max = 25,
	armor = 80,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_stone_monster.png"},
		{"mobs_stone_monster2.png"}, -- by AMMOnym
	},
	blood_texture = "default_stone.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster",
		attack = "mobs_stonemonster_attack",
	},
	-- speed and jump, sinks in water
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	floats = 0,
	view_range = 16,
	-- chance of dropping torch, iron lump, coal lump and/or silver coins
	drops = {
		{name = "default:torch",
		chance = 10, min = 3, max = 5,},
		{name = "default:iron_lump", chance = 5, min = 1, max = 2,},
		{name = "default:coal_lump", chance = 3, min = 1, max = 3,},
		{name = "maptools:silver_coin", chance = 1, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
})

-- spawns on stone between -1 and 5 light, 1 in 7000 chance, 1 in area below -25
mobs:spawn_specific("mobs:stone_monster", {"default:stone", "default:desert_stone"}, {"air"}, -1, 5, 30, 7000, 1, -31000, -25, false)

-- register spawn egg
mobs:register_egg("mobs:stone_monster", "Stone Monster", "mobs_stone_monster_inv.png", 1)

minetest.register_craft({
	output = "mobs:stone_monster",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "default:nyancat_rainbow", "default:stone"},
		{"default:stone", "default:stone", "default:stone"}
	}
})


-- Sand Monster by PilzAdam

mobs:register_mob("mobs:sand_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 2,
	-- health & armor
	hp_min = 10,
	hp_max = 15,
	armor = 100,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.b3d",
	textures = {
		{"mobs_sand_monster.png"},
	},
	blood_texture = "default_sand.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sandmonster",
	},
	-- speed and jump, sinks in water
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 16,
	jump = true,
	floats = 0,
	-- drops desert sand when dead
	drops = {
		{name = "default:desert_sand", chance = 1, min = 3, max = 5,},
		{name = "maptools:silver_coin", chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 3,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
})

-- spawns on desert sand between -1 and 20 light, 1 in 15000 chance, 1 sand monster in area up to 31000 in height
mobs:spawn_specific("mobs:sand_monster", {"default:desert_sand", "default:sand"}, {"air"}, -1, 20, 30, 20000, 1, -31000, 31000, false)

-- register spawn egg
mobs:register_egg("mobs:sand_monster", "Sand Monster", "mobs_sand_monster_inv.png", 1)

minetest.register_craft({
	output = "mobs:sand_monster",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "default:nyancat_rainbow", "group:sand"},
		{"group:sand", "group:sand", "group:sand"}
	}
})

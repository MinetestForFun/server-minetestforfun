
-- Dirt Monster by PilzAdam

mobs:register_mob("mobs:dirt_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 6 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 5,
	-- health & armor
	hp_min = 25,
	hp_max = 30,
	armor = 100,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_dirt_monster.png"},
	},
	blood_texture = "default_dirt.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dirtmonster",
	},
	-- speed and jump
	view_range = 16,
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = true,
	-- drops dirt and coins when dead
	drops = {
		{name = "default:dirt", chance = 1, min = 3, max = 5,},
		{name = "maptools:silver_coin", chance = 2, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	fear_height = 4,
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

-- spawn on dirt_with_grass and drygrass between -1 and 5 light, 1 in 12500 change, 1 dirt monster in area up to 31000 in height
mobs:spawn_specific("mobs:dirt_monster", {"default:dirt_with_grass", "default:dirt_with_dry_grass"}, {"air"}, -1, 5, 30, 12500, 1, -31000, 31000, false, false)
-- register spawn egg
mobs:register_egg("mobs:dirt_monster", "Dirt Monster", "mobs_dirt_monster_inv.png", 1)

minetest.register_craft({
	output = "mobs:dirt_monster",
	recipe = {
		{"default:dirt", "default:dirt", "default:dirt"},
		{"default:dirt", "default:nyancat_rainbow", "default:dirt"},
		{"default:dirt", "default:dirt", "default:dirt"}
	}
})

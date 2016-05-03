
-- Zombie by BlockMen

mobs:register_mob("mobs:zombie", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 6 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	damage = 4,
	-- health & armor
	hp_min = 30,
	hp_max = 40,
	armor = 100,
	-- textures and model
	collisionbox = {-0.25, -1, -0.3, 0.25, 0.75, 0.3},
	visual = "mesh",
	mesh = "mobs_zombie.x",
	textures = {
		{"mobs_zombie.png"},
	},
	visual_size = {x=1, y=1},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie",
		damage = "mobs_zombie_hit",
		attack = "mobs_zombie_attack",
		death = "mobs_zombie_death",
	},
	-- speed and jump
	view_range = 16,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	floats = 0,
-- drops nether fruit and silver coin when dead
	drops = {
		{name = "nether:apple",
		chance = 2, min = 1, max = 2,},
		{name = "mobs:zombie_tibia",
		chance = 10, min = 1, max = 1,},
		{name = "maptools:silver_coin",
		chance = 1, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	-- model animation
	animation = {
		speed_normal = 10,		speed_run = 15,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 188,
		run_start = 168,		run_end = 188,
--		punch_start = 168,		punch_end = 188,
	},
})

-- spawn in nether forest between -1 and 5 light, 1 in 7000 change, 1 zombie in area up to 31000 in height
mobs:spawn_specific("mobs:zombie", {"nether:dirt_top"}, {"air"}, -1, 5, 30, 7000, 1, -31000, 31000, false)
-- register spawn egg
mobs:register_egg("mobs:zombie", "Zombie", "mobs_zombie_inv.png", 1)

minetest.register_craftitem("mobs:zombie_tibia", {
	description = "Zombie Tibia",
	inventory_image = "mobs_zombie_tibia.png",
	groups = {magic = 1},
})


-- Zombie by BlockMen

mobs:register_mob("mobs:zombie", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 6 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 6,
	-- health & armor
	hp_min = 30,
	hp_max = 40,
	armor = 100,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
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
-- drops dirt and coins when dead
	drops = {
		{name = "maptools:copper_coin",
		chance = 2, min = 2, max = 8,},
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

-- spawn in nether forest between -1 and 5 light, 1 in 6000 change, 1 zombie in area up to 31000 in height
mobs:register_spawn("mobs:zombie", {"nether:dirt_top"}, 5, -1, 6000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:zombie", "Zombie", "mobs_zombie_head.png", 1)


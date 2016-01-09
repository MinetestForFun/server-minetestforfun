-- Ent from https://github.com/Minetest-LOTT/Lord-of-the-Test
mobs:register_mob("mobs:ent", {
	type = "npc",
	hp_min = 50,
	hp_max = 70,
	collisionbox = {-0.5, 0, -0.5, 0.5, 5, 0.5},
	textures = {
		{"mobs_ent.png"},
	},
	visual_size = {x=3.5,y=3.5},
	visual = "mesh",
	mesh = "mobs_ent.x",
	view_range = 20,
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	armor = 100,
	damage = 5,
	drops = {
		{name = "default:sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:apple_tree_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:birch_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:beech_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:acacia_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:pine_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:fir_sapling",
		chance = 5,
		min = 1,
		max = 3,},
		{name = "moretrees:rubber_tree_sapling",
		chance = 5,
		min = 1,
		max = 3,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 60,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 17,
		stand_end = 17,
		walk_start = 10,
		walk_end = 80,
		run_start = 10,
		run_end = 80,
		punch_start = 1,
		punch_end = 1,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_die_yell",
		death = "mobs_yeti_death",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,

})

minetest.register_node("mobs:ent_spawner", {
	description = "Ent Spawner",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png^mobs_chicken_egg.png"},
	is_ground_content = false,
	groups = {unbreakable = 1, mob_spawner=1},
})

minetest.register_node("mobs:tree_monster_spawner", {
	description = "Tree Monster Spawner",
	tiles = {"default_wood.png^mobs_chicken_egg.png"},
	is_ground_content = false,
	groups = {unbreakable = 1, mob_spawner=1},
})

-- Boss
-- spawn on mobs:ent_spawner between 1 and 20 light, 4 interval, 1 chance, 1 ent in area up to 31000 in height
mobs:spawn_specific("mobs:ent", {"mobs:ent_spawner"}, {"air"}, 1, 20, 300, 1, 100, -31000, 31000, true)
mobs:register_egg("mobs:ent", "Ent", "mobs_ent_inv.png", 1)

-- Minions
-- spawn on mobs:pumpboom_spawner between 1 and 20 light, 4 interval, 1 chance, 1 pumpboom in area up to 31000 in height
mobs:spawn_specific("mobs:tree_monster", {"mobs:tree_monster_spawner"}, {"air"}, 1, 20, 10, 4, 100, -31000, 31000, true)


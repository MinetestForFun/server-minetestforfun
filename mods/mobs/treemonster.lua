
-- Tree Monster (or Tree Gollum) by PilzAdam

mobs:register_mob("mobs:tree_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 9 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	pathfinding = false,
	reach = 2,
	damage = 5,
	-- health & armor
	hp_min = 20,
	hp_max = 30,
	armor = 90,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_tree_monster.b3d",
	textures = {
		{"mobs_tree_monster.png"},
	},
	blood_texture = "default_wood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_treemonster",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	view_range = 16,
	-- drops saplings, junglesapling, apple and/or silver coin
	drops = {
		{name = "default:sapling", chance = 2, min = 1, max = 2},
		{name = "default:junglesapling", chance = 2, min = 1, max = 2},
		{name = "default:apple", chance = 2, min = 2, max = 3,},
		{name = "maptools:superapple", chance = 4, min = 1, max = 1,},
		{name = "maptools:silver_coin", chance = 3, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	fall_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
	},
})

-- spawn on leaves and beech_leaves, between 0 and 5 light, 1 in 8500 chance, 1 in area up to 31000 in height
mobs:spawn_specific("mobs:tree_monster", {"default:leaves", "moretrees:beech_leaves"}, {"air"}, 0, 5, 30, 8500, 1, -31000, 31000, false, false)

-- register spawn egg
mobs:register_egg("mobs:tree_monster", "Tree Monster", "mobs_tree_monster_inv.png", 1)

-- ethereal sapling compatibility
if not minetest.get_modpath("ethereal") then
	minetest.register_alias("ethereal:tree_sapling", "default:sapling")
	minetest.register_alias("ethereal:jungle_tree_sapling", "default:junglesapling")
end

minetest.register_craft({
	output = "mobs:tree_monster",
	recipe = {
		{"default:tree", "default:tree", "default:tree"},
		{"default:tree", "default:nyancat_rainbow", "default:tree"},
		{"default:tree", "default:tree", "default:tree"}
	}
})

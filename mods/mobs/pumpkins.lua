-- PumpKing by Blert2112
mobs:register_mob("mobs:pumpking", {
	type = "monster",
	visual = "mesh",
	mesh = "mobs_pumpking.x",
	textures = {
		{"mobs_pumpking.png"}
	},
	visual_size = {x=3, y=3},
	collisionbox = {-0.5, 0.00, -0.5, 0.5, 4.5, 0.5},
	animation = {
		speed_normal = 15,	speed_run = 30,
		stand_start = 165,	stand_end = 210,
		walk_start = 61,	walk_end = 110,
		run_start = 0,		run_end = 50,
		punch_start = 150,	punch_end = 165
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_king"
	},
	hp_min = 275,
	hp_max = 300,
	armor = 70,
	knock_back = 0,
	walk_velocity = 3,
	run_velocity = 4,
	light_damage = 0,
	water_damage = 0,
	lava_damage = 0,
	fall_damage = 0,
	damage = 9,
	pathfinding = false,
	reach = 5,
	attack_type = "dogfight",
	view_range = 25,
	stepheight = 1.1,
	drops = {
		-- Ressource & Decoration drops
		{name = "farming:jackolantern", chance = 1, min = 1, max = 1},
		{name = "default:diamondblock", chance = 2, min = 1, max = 2},
		-- Hunter drops
		{name = "3d_armor:helmet_hardenedleather", chance = 10, min = 1, max = 1},
		{name = "3d_armor:chestplate_hardenedleather", chance = 10, min = 1, max = 1},
		{name = "throwing:bow_minotaur_horn", chance = 33, min = 1, max = 1},
		-- Warrior drops
		{name = "3d_armor:helmet_mithril", chance = 10, min = 1, max = 1},
		{name = "3d_armor:chestplate_mithril", chance = 10, min = 1, max = 1},
		{name = "default:sword_mithril", chance = 33, min = 1, max = 1},
	},
	lifetimer = 300,		-- 5 minutes
	--shoot_interval = 1000,	-- (lifetimer - (lifetimer / 4)), borrowed for do_custom timer
	on_die = function(self)
		minetest.chat_send_all("A group of players killed a PumpKing!")
	end
})

mobs:register_mob("mobs:pumpboom", {
	type = "monster",
	visual = "mesh",
	mesh = "mobs_pumpboom.x",
	textures = {
		{"mobs_pumpboom.png"}
	},
	visual_size = {x=3, y=3},
	collisionbox = {-0.70, -0.3, -0.70, 0.70, 0.70, 0.70},
	rotate = 270,
	animation = {
		speed_normal = 15,	speed_run = 30,
		stand_start = 0,	stand_end = 30,
		walk_start = 81,	walk_end = 97,
		run_start = 81,		run_end = 97,
		punch_start = 100,	punch_end = 120
	},
	sounds = {
		random = "mobs_pump"
	},
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	light_damage = 0,
	water_damage = 0,
	lava_damage = 0,
	fall_damage = 0,
	damage = 8,
	attack_type = "explode",
	group_attack = true,
	do_not_project_items = true,
	view_range = 15,
	walk_velocity = 2,
	run_velocity = 4,
	drops = {
		{name = "farming:pumpkin_seed", chance = 8, min = 4, max = 8}
	}
})

minetest.register_node("mobs:pumpking_spawner", {
	description = "Pumpkin King Spawner",
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_on.png"
	},
	is_ground_content = false,
	groups = {unbreakable = 1, mob_spawner=1},
	sounds = default.node_sound_stone_defaults({
		dug = {name="mobs_king", gain=0.25}
	})
})

minetest.register_node("mobs:pumpboom_spawner", {
	description = "Pump Boom Spawner",
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_off.png"
	},
	is_ground_content = false,
	groups = {unbreakable = 1, mob_spawner=1},
	sounds = default.node_sound_stone_defaults({
		dug = {name="mobs_boom", gain=0.25}
	})
})

--(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, spawn_in_area)
-- spawn on mobs:pumpking_spawner between 1 and 20 light, interval 300, 1 chance, 1 pumpking_spawner in area up to 31000 in height
mobs:spawn_specific("mobs:pumpking", {"mobs:pumpking_spawner"}, {"air"}, 1, 20, 300, 1, 100, -31000, 31000, true)
mobs:register_egg("mobs:pumpking", "Pumpking", "mobs_pumpking_inv.png", 1)

-- spawn on mobs:pumpboom_spawner, 4 interval, 1 chance, 30 pumpboom in area
mobs:spawn_special("mobs:pumpboom", {"mobs:pumpboom_spawner"}, {"air"}, 10, 4, 30)
mobs:register_egg("mobs:pumpboom", "Pumpboom", "mobs_pumpboom_inv.png", 1)

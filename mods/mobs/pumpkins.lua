-- PumpKing by Blert2112
mobs:register_mob("mobs:pumpking", {
	type = "monster",
	visual = "mesh",
	mesh = "mobs_pumpking.x",
	textures = {
		{"mobs_pumpking.png"}
	},
	visual_size = {x=3, y=3},
	collisionbox = {-0.85, 0.00, -0.85, 0.85, 5.3, 0.85},
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
	hp_min = 190,
	hp_max = 200,
	armor = 70,
	knock_back = 0.1,
	light_damage = 0,
	water_damage = 0,
	lava_damage = 0,
	fall_damage = 0,
	damage = 8,
	reach = 4,
	attack_type = "dogfight",
	view_range = 25,
	stepheight = 1.1,
	drops = {
		-- Ressource & Decoration drops
		{name = "farming:jackolantern", chance = 1, min = 1, max = 1}
		{name = "default:diamond_block", chance = 2, min = 1, max = 3}
		-- Hunter drops
		{name = "3d_armor:helmet_hardenedleather", chance = 10, min = 1, max = 1}
		{name = "3d_armor:chestplate_hardenedleather", chance = 10, min = 1, max = 1}
		{name = "throwing:bow_minotaur_horn", chance = 33, min = 1, max = 1}
		-- Warrior drops
		{name = "3d_armor:helmet_mithril", chance = 10, min = 1, max = 1}
		{name = "3d_armor:chestplate_mithril", chance = 10, min = 1, max = 1}
		{name = "moreores:sword_mithril", chance = 33, min = 1, max = 1}
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
	damage = 4,
	attack_type = "explode",
	group_attack = true,
	view_range = 15,
	walk_velocity = 2,
	run_velocity = 4,
	drops = {
		{name = "farming:pumpkin_seed", chance = 1, min = 1, max = 4}
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
	groups = {cracky=3, stone=1, mob_spawner=1},
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
	groups = {cracky=3, stone=1, mob_spawner=1},
	sounds = default.node_sound_stone_defaults({
		dug = {name="mobs_boom", gain=0.25}
	})
})

minetest.register_abm({
	nodenames = {"mobs:pumpking_spawner"},
	interval = 600.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.add_entity(pos, "mobs:pumpking")
	end
})

minetest.register_abm({
	nodenames = {"mobs:pumpboom_spawner"},
	interval = 30.0,
	chance = 6,
	action = function(pos, node, active_object_count, active_object_count_wider)
		pos.y = pos.y + 1
		minetest.add_entity(pos, "mobs:pumpboom")
	end
})

-- Pumpking by Blert2112

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
	hp_min = 85,
	hp_max = 90,
	armor = 30,
	knock_back = 1,
	light_damage = 10,
	water_damage = 5,
	lava_damage = 5,
	fall_damage = 20,
	damage = 8,
	attack_type = "dogfight",
	view_range = 25,
	stepheight = 1.1,
	drops = {
		{name = "farming:jackolantern", chance = 1, min = 1, max = 1}
	},
	lifetimer = 180,		-- 3 minutes
	shoot_interval = 135,	-- (lifetimer - (lifetimer / 4)), borrowed for do_custom timer
	do_custom = function(self)
		if self.lifetimer <= self.shoot_interval then
			p = self.object:getpos()
			p.y = p.y + 1
			minetest.add_entity(p, "mobs:pumpboom")
			minetest.after(5.0, function(pos, str) minetest.add_entity(pos, str) end,
				p, "mobs:pumpboom")
			self.shoot_interval = self.shoot_interval - 45
		end
	end
})

mobs:register_egg("mobs:pumpking", "Pumpkin King", "mobs_pumpking_inv.png", 1)

mobs:register_mob("mobs:pumpboom", {
	type = "monster",
	visual = "mesh",
	mesh = "mobs_pumpboom.x",
	textures = {
		{"mobs_pumpboom.png"}
	},
	visual_size = {x=3, y=3},
	collisionbox = {-0.80, -0.3, -0.80, 0.80, 0.80, 0.80},
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
	hp_min = 2,
	hp_max = 5,
	armor = 200,
	light_damage = 2,
	water_damage = 2,
	lava_damage = 2,
	fall_damage = 3,
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
minetest.register_abm({
	nodenames = {"mobs:pumpking_spawner"},
	interval = 180.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.add_entity(pos, "mobs:pumpking")
	end
})


--= Mese Monster by Zeg9

-- 9 mese crystal fragments = 1 mese crystal
minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
	}
})

-- Mese Monster
mobs:register_mob("mobs:mese_monster", {
	type = "monster",
	hp_min = 30,
	hp_max = 40,
	collisionbox = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_mese_monster.x",
	--textures = {"zmobs_mese_monster.png"},
	available_textures = {
		total = 1,
		texture_1 = {"zmobs_mese_monster.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 6,
	drops = {
		{name = "default:mese_crystal",
		chance = 9,
		min = 1,
		max = 3,},
		{name = "default:mese_crystal_fragment",
		chance = 1,
		min = 1,
		max = 9,},
		{name = "maptools:silver_coin",
		chance = 2,
		min = 2,
		max = 5,},
	},
	light_resistant = true,
	armor = 70,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	attack_type = "shoot",
	arrow = "mobs:mese_arrow",
	shoot_interval = .5,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 15, -- 40
		punch_end = 38, -- 63
	},
	jump = true,
	step = 1,
	shoot_offset = 2,
	blood_texture = "default_mese_crystal_fragment.png",
})
mobs:register_spawn("mobs:mese_monster", {"default:stone", }, 3, -1, 5000, 1, -20)

-- Mese Monster Crystal Shards (weapon)

mobs:register_arrow("mobs:mese_arrow", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"default_mese_crystal_fragment.png"},
	velocity = 5,
	
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()

		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=7},
		}, 0) -- {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z})
	end,
	
	hit_node = function(self, pos, node)
	end
})

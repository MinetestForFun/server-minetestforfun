
-- Mese Monster by Zeg9

mobs:register_mob("mobs:mese_monster", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, deals 9 damage to player when hit
	passive = false,
	damage = 4,
	attack_type = "shoot",
	shoot_interval = 1.0,
	arrow = "mobs:mese_arrow",
	shoot_offset = 2,
	-- health & armor
	hp_min = 20,
	hp_max = 25,
	armor = 80,
	-- textures and model
	collisionbox = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_mese_monster.x",
	textures = {
		{"zmobs_mese_monster.png"},
	},
	visual_size = {x=1, y=1},
	blood_texture = "default_mese_crystal_fragment.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_mesemonster",
	},
	-- speed and jump
	view_range = 16,
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	jump_height = 8,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.1,
	-- drops mese when dead
	drops = {
		{name = "default:mese_crystal", chance = 9, min = 1, max = 3,},
		{name = "default:mese_crystal_fragment", chance = 1, min = 1, max = 9,},
		{name = "maptools:silver_coin", chance = 1, min = 1, max = 2,},
		{name = "returnmirror:mirror_inactive", chance = 50, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
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
-- spawn on stone between 20 and -1 light, 1 in 8000 chance, 1 in area below -25
mobs:spawn_specific("mobs:mese_monster", {"default:stone", "default:sandstone"}, {"air"}, -1, 20, 30, 8000, 1, -31000, -125, false)
-- register spawn egg
mobs:register_egg("mobs:mese_monster", "Mese Monster", "mobs_mese_monster_inv.png", 1)

-- mese arrow (weapon)
mobs:register_arrow("mobs:mese_arrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"default_mese_crystal_fragment.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},     --Modif MFF
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},     --Modif MFF
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})

-- 9x mese crystal fragments = 1x mese crystal
minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
	}
})

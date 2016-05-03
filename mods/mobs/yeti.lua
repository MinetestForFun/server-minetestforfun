
-- Yeti by TenPlus1

mobs:register_mob("mobs:yeti", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, deals 7 damage to player when hit
	passive = false,
	damage = 3,
	attack_type = "dogshoot",
	pathfinding = false,
	reach = 2,
	shoot_interval = .75,
	arrow = "mobs:snowball",
	shoot_offset = 2,
	-- health & armor
	hp_min = 20,
	hp_max = 25,
	armor = 100,
	-- textures and model
	collisionbox = {-0.42,-1.2,-0.42, 0.42,0.96,0.42},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"mobs_yeti.png"},
	},
	visual_size = {x=1.2, y=1.2},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dirtmonster",
		shoot_attack = "mobs_stonemonster_attack",
		death = "mobs_zombie_death",
	},
	-- speed and jump
	view_range = 16,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	floats = 1,
	-- drops ice when dead
	drops = {
		{name = "default:ice",
		chance = 1, min = 1, max = 3,},
		{name = "maptools:silver_coin",
		chance = 2, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
})
-- spawn on stone between 20 and -1 light, 1 in 7000 chance, 1 in area below 31000
mobs:spawn_specific("mobs:yeti", {"default:dirt_with_snow", "default:snow", "default:snowblock"}, {"air"}, -1, 20, 30, 30000, 1, -31000, 31000, false)
-- register spawn egg
mobs:register_egg("mobs:yeti", "Yeti", "mobs_yeti_inv.png", 1)

-- snowball (weapon)
mobs:register_arrow("mobs:snowball", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"default_snowball.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 6},
		}, 0)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 3},
		}, 0)
	end,

	hit_node = function(self, pos, node)
	end
})


-- Yeti by TenPlus1

mobs:register_mob("mobs:yeti", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, deals 7 damage to player when hit
	passive = false,
	damage = 7,
	attack_type = "shoot",
	shoot_interval = .75,
	arrow = "mobs:snowball",
	shoot_offset = 2,
	-- health & armor
	hp_min = 25,
	hp_max = 30,
	armor = 90,
	-- textures and model
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"mobs_yeti.png"},
	},
	visual_size = {x=1, y=1},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dirtmonster",
		attack = "mobs_stonemonster_attack",
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
		chance = 1,
		min = 1,
		max = 3,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 1,
	-- model animation
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
})
-- spawn on stone between 20 and -1 light, 1 in 7000 chance, 1 in area below -25
mobs:register_spawn("mobs:yeti", {"default:dirt_with_snow", "default:snowblock", "default:ice"}, 10, -1, 7000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:yeti", "Yeti", "default_snow.png", 1)

-- snowball (weapon)
mobs:register_arrow("mobs:snowball", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"default_snowball.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=7},
		}, 0)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=7},
		}, 0)
	end,

	hit_node = function(self, pos, node)
	end
})

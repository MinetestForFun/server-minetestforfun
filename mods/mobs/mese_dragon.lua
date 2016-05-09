mobs:register_mob("mobs:mese_dragon", {
	type = "monster",
	-- agressive, deals 13 damage to player when hit
	passive = false,
	damage = 13,
	attack_type = "dogshoot",
	reach = 3,
	shoot_interval = 2,
	arrow = "mobs:fireball_mese_dragon",
	shoot_offset = 2,
	-- health & armor
	hp_min = 175,
	hp_max = 225,
	armor = 70,
	-- textures and model
	collisionbox = {-0.8, 0, -0.8, 0.8, 4, 0.8}, --A VERIFIER/CORRIGER
	visual = "mesh",
	mesh = "mese_dragon.b3d",
	textures = {
		{"mese_dragon.png"},
	},
	visual_size = {x=8, y=8}, --default (x=10,y=10)
	blood_texture = "default_mese_crystal_fragment.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "mesed",
		attack = "mese_dragon",
		distance = 60,
	},
	-- speed and jump
	view_range = 20,
	knock_back = 0,
	walk_velocity = 1.5,
	run_velocity = 3.5,
	pathfinding = false,
	jump = true,
	jump_height = 4,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 1.5,
	-- drops returnmirror & mese & class items when dead
	drops = {
		-- Ressource & Decoration drops
		{name = "default:mese", chance = 2, min = 2, max = 4},
		{name = "returnmirror:mirror_inactive", chance = 10, min = 1, max = 1},
		-- Tools drops
		{name = "default:pick_mese", chance = 33, min = 1, max = 1},
		{name = "default:shovel_mese", chance = 33, min = 1, max = 1},
		{name = "default:axe_mese", chance = 33, min = 1, max = 1},
		{name = "farming:hoe_mese", chance = 33, min = 1, max = 1},
		-- Hunter drops
		{name = "3d_armor:leggings_hardenedleather", chance = 10, min = 1, max = 1},
		{name = "3d_armor:boots_hardenedleather", chance = 10, min = 1, max = 1},
		{name = "throwing:arbalest", chance = 33, min = 1, max = 1},
		-- Warrior drops
		{name = "3d_armor:leggings_mithril", chance = 10, min = 1, max = 1},
		{name = "3d_armor:boots_mithril", chance = 10, min = 1, max = 1},
		{name = "default:sword_mese", chance = 33, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	animation = { -- Ajouté avec valeurs farfadet, voir si crachat+griffe possible en une animation d'attaque
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 180,
		walk_end = 200,
		run_start = 180,
		run_end = 200,
		punch_start = 140,
		punch_end = 170,
	},
})

-- fireball_mese_dragon (weapon)
mobs:register_arrow("mobs:fireball_mese_dragon", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"mobs_fireball.png"},
	velocity = 8,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {		-- Mettre à 2.0 aussi ?
			full_punch_interval = 2.0,			-- Modif MFF
			damage_groups = {fleshy = 13},		-- Modif MFF
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {		-- Mettre à 2.0 aussi ?
			full_punch_interval = 2.0,			-- Modif MFF
			damage_groups = {fleshy = 13},		-- Modif MFF
		}, nil)
	end,

	-- node hit, bursts into flame
	hit_node = function(self, pos, node)
		mobs:explosion(pos, 1, 1, 0)
	end
})

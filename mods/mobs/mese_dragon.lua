mobs:register_mob("mobs:mese_dragon", {
	type = "monster",
	-- agressive, deals 4 damage to player when hit
	passive = false,
	damage = 12,
	attack_type = "dogshoot",
	reach = 3,
	shoot_interval = 2.5,
	arrow = "mobs:roar_of_the_dragon", --Remplacer par fireball du DM mais enlever son et mettre texture "mese flamme"
	shoot_offset = 2,
	-- health & armor
	hp_min = 175,
	hp_max = 225,
	armor = 70,
	-- textures and model
	collisionbox = {-1, 0, -1, 1, 5, 1}, --A VERIFIER/CORRIGER
	visual = "mesh",
	mesh = "mese_dragon.x",
	-- rotate = 270, => besoin ou pas avec le modèle de farfadet ?
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
	animation = { -- Bonne valeurs à mettre ici, voir avec farfadet
		speed_normal = 15,
		speed_run = 25,
		stand_start = 60,
		stand_end = 120,
		walk_start = 161,
		walk_end = 205,
		run_start = 206,
		run_end = 242,
		punch_start = 242,
		punch_end = 275,
		punch1_start = 330,
		punch1_end = 370,
    		dattack_start = 120,
    		dattack_end = 160,
	}

	--maxus = true, => C'est quoi ça ?!
	--putter = true, => C'est quoi ça ?!
	--drawtype = "front", => C'est quoi ça ?!
})

-- mese arrow (weapon) --Remplacer par fireball du DM mais enlever son et mettre texture "mese flamme"
mobs:register_arrow("mobs:mese_arrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"default_mese_crystal_fragment.png"},
	velocity = 8, --default 6

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 12},     --Modif MFF
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 12},     --Modif MFF
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})

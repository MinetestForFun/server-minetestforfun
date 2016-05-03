
-- Lava Flan by Zeg9

mobs:register_mob("mobs:lava_flan", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	damage = 4,
	-- health and armor
	hp_min = 20,
	hp_max = 25,
	armor = 80,
	-- textures and model
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_lava_flan.x",
	textures = {
		{"zmobs_lava_flan.png"},
	},
	blood_texture = "fire_basic_flame.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_lavaflan",
		war_cry = "mobs_lavaflan",
	},
	-- speed and jump, sinks in water
	walk_velocity = 0.5,
	run_velocity = 2,
	jump = true,
	-- step = 2, (was good with this value, but don't care now because Lava Slime remplace Lava Flan)
	view_range = 16,
	floats = 1,
	-- chance of dropping lava orb when dead
	drops = {
		{name = "mobs:lava_orb", chance = 15, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 5,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 8,
		walk_start = 10,
		walk_end = 18,
		run_start = 20,
		run_end = 28,
		punch_start = 20,
		punch_end = 28,
	},
	-- do things when die
	on_die = function(self, pos)
		minetest.set_node(pos, {name = "fire:basic_flame"})
	end,
})
-- spawns in lava between -1 and 20 light, 1 in 4000 chance, 3 in area below 31000 in height
--mobs:spawn_specific("mobs:lava_flan", {"default:lava_source"}, {"air"}, -1, 20, 30, 4000, 3, -31000, 31000, false) --DISABLE SPAWN MFF !
-- register spawn egg
mobs:register_egg("mobs:lava_flan", "Lava Flan", "default_lava.png", 1)

-- lava orb
minetest.register_craftitem("mobs:lava_orb", {
	description = "Lava orb",
	inventory_image = "zmobs_lava_orb.png",
})

minetest.register_alias("zmobs:lava_orb", "mobs:lava_orb")

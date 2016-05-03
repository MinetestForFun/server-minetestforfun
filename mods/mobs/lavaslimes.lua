
-- Lava Slimes by TomasJLuis & TenPlus1

-- sounds
local lava_sounds = {
	damage = "mobs_slimes_damage",
	death = "mobs_slimes_death",
	jump = "mobs_slimes_jump",
	attack = "mobs_slimes_attack",
}

-- lava slime textures
local lava_textures = {"mobs_lava_slime_sides.png", "mobs_lava_slime_sides.png", "mobs_lava_slime_sides.png", "mobs_lava_slime_sides.png", "mobs_lava_slime_front.png", "mobs_lava_slime_sides.png"}

-- register small lava slime
mobs:register_mob("mobs:lavasmall", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 2 damage to player when hit
	passive = false,
	pathfinding = false,
	reach = 2,
	damage = 2,
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health and armor
	hp_min = 4,
	hp_max = 8,
	armor = 200,
	-- textures and model
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	visual = "cube",
	textures = { lava_textures },
	blood_texture = "mobs_lava_slime_blood.png",
	visual_size = {x = 0.5, y = 0.5},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = lava_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 4,
	run_velocity = 4,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	replace_rate = 20,
	footstep = "fire:basic_flame",
	view_range = 16,
	floats = 1,
	-- chance of dropping lava orb and coins
	drops = {
		{name = "mobs:lava_orb", chance = 15, min = 1, max = 1,},
		{name = "maptools:silver_coin", chance = 4, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	-- no model animation
})
mobs:register_egg("mobs:lavasmall", "Small Lava Slime", "mobs_lava_slime_medium_inv.png", 1)

-- register medium lava slime
mobs:register_mob("mobs:lavamedium", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 4 damage to player when hit
	passive = false,
	reach = 2,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health and armor
	hp_min = 15,
	hp_max = 25,
	armor = 100,
	-- textures and model
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "cube",
	textures = { lava_textures },
	blood_texture = "mobs_lava_slime_blood.png",
	visual_size = {x = 1, y = 1},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = lava_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 3,
	run_velocity = 3,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	replace_rate = 20,
	footstep = "fire:basic_flame",
	view_range = 16,
	floats = 1,
	-- chance of dropping lava orb and coins
	drops = {
	},
	-- damaged by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	-- no model animation
	-- do things when die
	on_die = function(self, pos)
		local num = math.random(2, 4)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "mobs:lavasmall")
		end
	end,
})

mobs:register_egg("mobs:lavamedium", "Medium Lava Slime", "mobs_lava_slime_medium_inv.png", 1)

-- register big lava slime
mobs:register_mob("mobs:lavabig", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 6 damage to player when hit
	passive = false,
	reach = 2,
	damage = 5,
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health and armor
	hp_min = 30, hp_max = 50,
	armor = 100,
	-- textures and model
	collisionbox = {-1, -1, -1, 1, 1, 1},
	visual = "cube",
	textures = { lava_textures },
	blood_texture = "mobs_lava_slime_blood.png",
	visual_size = {x = 2, y = 2},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = lava_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 2.5,
	run_velocity = 2.5,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	replace_rate = 20,
	replace_offset = -1,
	footstep = "fire:basic_flame",
	view_range = 16,
	floats = 1,
	knock_back = 0, --this is a test
	-- chance of dropping lava orb and coins
	drops = {
	},
	-- damaged by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	-- no model animation
	-- do things when die
	on_die = function(self, pos)
		local num = math.random(1, 2)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "mobs:lavamedium")
		end
	end,
})

mobs:register_egg("mobs:lavabig", "Big Lava Slime", "mobs_lava_slime_big_inv.png", 1)

--mobs:spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)
mobs:spawn_specific("mobs:lavabig", {"default:lava_source"},{"default:lava_flowing"}, -1, 20, 30, 5000, 1, -32000, 32000, false)
mobs:spawn_specific("mobs:lavamedium", {"default:lava_source"},{"default:lava_flowing"}, -1, 20, 30, 5000, 2, -32000, 32000, false)
--mobs:spawn_specific("mobs:lavasmall", {"default:lava_source"},{"default:lava_flowing"}, -1, 20, 30, 10s000, 2, -32000, 32000, false)

-- lava orb
minetest.register_craftitem("mobs:lava_orb", {
	description = "Lava orb",
	inventory_image = "zmobs_lava_orb.png",
})

minetest.register_alias("zmobs:lava_orb", "mobs:lava_orb")


-- Green Slimes by TomasJLuis & TenPlus1

-- sounds
local green_sounds = {
	damage = "mobs_slimes_damage",
	death = "mobs_slimes_death",
	jump = "mobs_slimes_jump",
	attack = "mobs_slimes_attack",
}

-- green slime textures
local green_textures = {"mobs_green_slime_sides.png", "mobs_green_slime_sides.png", "mobs_green_slime_sides.png", "mobs_green_slime_sides.png", "mobs_green_slime_front.png", "mobs_green_slime_sides.png"}

-- register small green slime
mobs:register_mob("mobs:greensmall", {
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
	hp_min = 4, hp_max = 8,
	armor = 200,
	-- textures and model
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	visual = "cube",
	textures = { green_textures },
	blood_texture = "mobs_green_slime_blood.png",
	visual_size = {x = 0.5, y = 0.5},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = green_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 4,
	run_velocity = 4,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	view_range = 16,
	floats = 1,
	-- chance of dropping glue and coins
	drops = {
		{name = "mesecons_materials:glue", chance = 4, min = 1, max = 2},
		{name = "maptools:silver_coin", chance = 4, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	-- model animation
	-- no model animation
})
mobs:register_egg("mobs:greensmall", "Small Green Slime", "mobs_green_slime_medium_inv.png", 1)

-- register medium green slime
mobs:register_mob("mobs:greenmedium", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 4 damage to player when hit
	passive = false,
	reach = 2,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health and armor
	hp_min = 15, hp_max = 25,
	armor = 100,
	-- textures and model
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "cube",
	textures = { green_textures },
	blood_texture = "mobs_green_slime_blood.png",
	visual_size = {x = 1, y = 1},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = green_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 3,
	run_velocity = 3,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	view_range = 16,
	floats = 1,
	-- chance of dropping glue and coins
	drops = {
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	-- model animation
	-- no model animation
	-- do things when die
	on_die = function(self, pos)
		local num = math.random(2, 4)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "mobs:greensmall")
		end
	end,
})
mobs:register_egg("mobs:greenmedium", "Medium Green Slime", "mobs_green_slime_medium_inv.png", 1)

-- register big green slime
mobs:register_mob("mobs:greenbig", {
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
	textures = { green_textures },
	blood_texture = "mobs_green_slime_blood.png",
	visual_size = {x = 2, y = 2},
	-- sounds a bit here, but mainly define in the beginning
	makes_footstep_sound = false,
	sounds = green_sounds,
	-- speed and jump, sinks in water
	walk_velocity = 2.5,
	run_velocity = 2.5,
	walk_chance = 0,
	jump = true,
	jump_chance = 30,
	jump_height = 6,
	view_range = 16,
	floats = 1,
	knock_back = 0, --this is a test
	-- chance of dropping glue and coins
	drops = {
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	-- model animation
	-- no model animation
	-- do things when die
	on_die = function(self, pos)
		local num = math.random(1, 2)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "mobs:greenmedium")
		end
	end,
})
mobs:register_egg("mobs:greenbig", "Big Green Slime", "mobs_green_slime_big_inv.png", 1)

--mobs:spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)
mobs:spawn_specific("mobs:greenbig", {"default:acid_source"},{"default:acid_flowing"}, -1, 20, 30, 5000, 1, -32000, 32000, false)
mobs:spawn_specific("mobs:greenmedium", {"default:acid_source"},{"default:acid_flowing"},-1, 20, 30, 5000, 2, -32000, 32000, false)
--mobs:spawn_specific("mobs:greensmall", {"default:acid_source"},{"default:acid_flowing"},-1,  20, 30, 10000, 2, -32000, 32000)

--mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height)
--mobs:register_spawn("mobs:greenmedium", {"default:mossycobble"}, 20, 4, 10000, 8, 32000)
--mobs:register_spawn("mobs:greensmall", {"default:mossycobble"}, 20, 4, 10000, 8, 32000)

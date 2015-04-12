-- Green Slimes by TomasJLuis & TenPlus1

-- sounds
local green_sounds = {
	damage = "slimes_damage",
	death = "slimes_death",
	jump = "slimes_jump",
	attack = "slimes_attack",
}

-- green slime textures
local green_textures = {"green_slime_sides.png", "green_slime_sides.png", "green_slime_sides.png", "green_slime_sides.png", "green_slime_front.png", "green_slime_sides.png"}

-- register small green slime
mobs:register_mob("slimes:greensmall", {
	type = "monster",
	hp_min = 1,	hp_max = 2,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	visual = "cube",
	visual_size = {x = 0.5, y = 0.5},
	textures = { green_textures },
	blood_texture = "green_slime_blood.png",
	makes_footstep_sound = false,
	sounds = green_sounds,
	attack_type = "dogfight",
	attacks_monsters = true,
	damage = 1,
	passive = false,
	walk_velocity = 2,
	run_velocity = 2,
	walk_chance = 0,
	jump_chance = 30,
	jump_height = 6,
	armor = 100,
	view_range = 15,
	drops = {
		{name = "mesecons_materials:glue", chance = 4, min = 1, max = 2},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
})
mobs:register_egg("slimes:greensmall", "Small Green Slime", "green_slime_egg.png", 1)

-- register medium green slime
mobs:register_mob("slimes:greenmedium", {
	type = "monster",
	hp_min = 3,	hp_max = 4,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "cube",
	visual_size = {x = 1, y = 1},
	textures = { green_textures },
	blood_texture = "green_slime_blood.png",
	makes_footstep_sound = false,
	sounds = green_sounds,
	attack_type = "dogfight",
	attacks_monsters = true,
	damage = 1,
	passive = false,
	walk_velocity = 2,
	run_velocity = 2,
	walk_chance = 0,
	jump_chance = 30,
	jump_height = 6,
	armor = 100,
	view_range = 15,
	on_die = function(self, pos)
		local num = math.random(2, 4)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "slimes:greensmall")
		end
	end,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
})
mobs:register_egg("slimes:greenmedium", "Medium Green Slime", "green_slime_egg.png", 1)

-- register big green slime
mobs:register_mob("slimes:greenbig", {
	type = "monster",
	hp_min = 5,	hp_max = 6,
	collisionbox = {-1, -1, -1, 1, 1, 1},
	visual = "cube",
	visual_size = {x = 2, y = 2},
	textures = { green_textures },
	blood_texture = "green_slime_blood.png",
	makes_footstep_sound = false,
	sounds = green_sounds,
	attack_type = "dogfight",
	attacks_monsters = true,
	damage = 2,
	passive = false,
	walk_velocity = 2,
	run_velocity = 2,
	walk_chance = 0,
	jump_chance = 30,
	jump_height = 6,
	armor = 100,
	view_range = 15,
	on_die = function(self, pos)
		local num = math.random(1, 2)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "slimes:greenmedium")
		end
	end,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
})
mobs:register_egg("slimes:greenbig", "Big Green Slime", "green_slime_egg.png", 1)

--mobs:spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)
mobs:spawn_specific("slimes:greenbig", {"default:junglegrass"},{"air","default:junglegrass"}, 4, 20, 30, 5000, 8, 0, 32000)
mobs:spawn_specific("slimes:greenmedium", {"default:junglegrass"},{"air","default:junglegrass"}, 4, 20, 30, 10000, 8, 0, 32000)
mobs:spawn_specific("slimes:greensmall", {"default:junglegrass"},{"air","default:junglegrass"}, 4, 4, 30, 15000, 8, 0, 32000)

--mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height)
mobs:register_spawn("slimes:greenmedium", {"default:mossycobble"}, 20, 4, 10000, 8, 32000)
mobs:register_spawn("slimes:greensmall", {"default:mossycobble"}, 20, 4, 10000, 8, 32000)



-- Rat by PilzAdam

mobs:register_mob("mobs:rat", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- not aggressive
	passive = true,
	-- health & armor
	hp_min = 1,
	hp_max = 2,
	armor = 200,
	-- textures and model
	collisionbox = {-0.2, -1, -0.2, 0.2, -0.8, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.b3d",
	textures = {
		{"mobs_rat.png"},
		{"mobs_rat_brown.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	-- no drops
	drops = {},
	-- damaged by
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	-- right click to pick up rat
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
	end,
--[[
	do_custom = function(self)
		local pos = self.object:getpos()
		print("rat pos", pos.x, pos.y, pos.z)
	end,
--]]
})

-- spawn on stone between 1 and 20 light, 1 in 7000 chance, 1 per area up to 31000 in height
mobs:spawn_specific("mobs:rat", {"default:stone", "default:sandstone"}, {"air"}, 0, 20, 30, 10000, 1, -31000, 31000, true)

-- register spawn egg
mobs:register_egg("mobs:rat", "Rat", "mobs_rat_inv.png", 1)

-- cooked rat, yummy!
minetest.register_craftitem("mobs:rat_cooked", {
	description = "Cooked Rat",
	inventory_image = "mobs_cooked_rat.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:rat_cooked",
	recipe = "mobs:rat",
	cooktime = 5,
})

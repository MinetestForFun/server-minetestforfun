
-- Rat

mobs:register_mob("mobs:rat", {
	type = "animal",
	hp_min = 1,
	hp_max = 4, -- 1
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.x",
	--textures = {"mobs_rat.png"},
	available_textures = {
		total = 2,
		texture_1 = {"mobs_rat.png"},
		texture_2 = {"mobs_rat_brown.png"},
	},
	makes_footstep_sound = false,
	walk_velocity = 1,
	armor = 200,
	drops = {},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
jump = true,
step = 1,
passive = true,
	sounds = {
		random = "mobs_rat",
	},
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "mobs:rat")
			self.object:remove()
		end
	end,
})
mobs:register_spawn("mobs:rat", {"default:stone"}, 20, -1, 7000, 1, 31000)
mobs:register_egg("mobs:rat", "Rat", "mobs_rat_inventory.png", 0)
	
-- Cooked Rat, yummy!

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

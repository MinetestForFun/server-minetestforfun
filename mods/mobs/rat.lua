
-- Rat by PilzAdam

mobs:register_mob("mobs:rat", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- not aggressive
	passive = true,
	-- health & armor
	hp_min = 2, hp_max = 4, armor = 200,
	-- textures and model
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.x",
	drawtype = "front",
	available_textures = {
		total = 2,
		texture_1 = {"mobs_rat.png"},
		texture_2 = {"mobs_rat_brown.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	-- speed and jump
	walk_velocity = 1,
	jump = true,
	-- no drops
	drops = {},
	-- damaged by
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	-- right click to pick up rat
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() and clicker:get_inventory():room_for_item("main", "mobs:rat") then
			clicker:get_inventory():add_item("main", "mobs:rat")
			self.object:remove()
		end
	end,
})
-- spawn on stone between 1 and 20 light, 1 in 7000 chance, 1 per area up to 31000 in height
mobs:register_spawn("mobs:rat", {"default:stone"}, 20, 0, 9000, 1, 31000)
-- register spawn egg
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

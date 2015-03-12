
--= Chicken (thanks to JK Murray for his chicken model)

mobs:register_mob("mobs:chicken", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	animaltype = "clucky",
	collisionbox = {-0.3, -0.75, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	mesh = "chicken.x",
	-- textures look repetative but they fix the wrapping bug
	available_textures = {
		total = 2,
		texture_1 = {"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png",
					"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png",
					"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png"},
		texture_2 = {"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png",
					"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png",
					"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png"},
	},
	--textures = {"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png",
	--			"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png"},
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs:chicken_raw", chance = 1, min = 2, max = 2,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	jump = false,
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 1, -- 20
		walk_start = 20,
		walk_end = 40,
	},
	follow = "farming:wheat",
	view_range = 8,	

	sounds = {
		random = "mobs_chicken",
	},
	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "farming:wheat"  then
			if not minetest.setting_getbool("creative_mode") then
				tool:take_item(1)
				clicker:set_wielded_item(tool)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 4 then
				-- I dont know what do you want she make
				self.food = 0 
				self.tamed = true
				minetest.sound_play("mobs_chicken", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return tool
		else
			if clicker:is_player() and clicker:get_inventory() then
				clicker:get_inventory():add_item("main", "mobs:chicken")
				self.object:remove()
			end
		end
		
	end,
	jump = true,
	step = 1,
	blood_texture = "mobs_blood.png",
	passive = true,
})

mobs:register_spawn("mobs:chicken", {"default:dirt_with_grass"}, 20, 0, 9000, 1, 31000)
mobs:register_egg("mobs:chicken", "Chicken", "mobs_chicken_inv.png", 0)

-- Egg (can be fried in furnace)

minetest.register_node("mobs:egg", 
	{
		description = "Chicken Egg",
		tiles = {"mobs_chicken_egg.png"},
		inventory_image  = "mobs_chicken_egg.png",
		on_use = minetest.item_eat(1),
		visual_scale = 0.7,
		drawtype = "plantlike",
		wield_image = "mobs_chicken_egg.png",
		paramtype = "light",
		walkable = false,
		is_ground_content = true,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
		},
		groups = {snappy=2, dig_immediate=3},
		after_place_node = function(pos, placer, itemstack)
			if placer:is_player() then
				minetest.set_node(pos, {name="mobs:egg", param2=1})
			end
		end
})

minetest.register_craftitem("mobs:chicken_egg_fried", {
description = "Fried Egg",
	inventory_image = "mobs_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:egg",
	output = "mobs:chicken_egg_fried",
})

-- Chicken (raw and cooked)

minetest.register_craftitem("mobs:chicken_raw", {
description = "Raw Chicken",
	inventory_image = "mobs_chicken_raw.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("mobs:chicken_cooked", {
description = "Cooked Chicken",
	inventory_image = "mobs_chicken_cooked.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:chicken_raw",
	output = "mobs:chicken_cooked",
})

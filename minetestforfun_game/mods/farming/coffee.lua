
--= Coffee

minetest.register_craftitem("farming:coffee_beans", {
	description = "Coffee Beans",
	inventory_image = "farming_coffee_beans.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:coffee_1")
	end,
})

--= Glass Cup
--minetest.register_craftitem("farming:drinking_cup", {
--	description = "Drinking Cup",
--	inventory_image = "vessels_drinking_cup.png",
--})

minetest.register_node("farming:drinking_cup", {
	description = "Drinking Cup (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_drinking_cup.png"},
	inventory_image = "vessels_drinking_cup.png",
	wield_image = "vessels_drinking_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "farming:drinking_cup 5",
	recipe = {
		{ "default:glass", "", "default:glass" },
		{"", "default:glass",""},
	}
})

--= Cold Cup of Coffee
--minetest.register_craftitem("farming:coffee_cup", {
--	description = "Cold Cup of Coffee",
--	inventory_image = "farming_coffee_cup.png",
--	on_use = minetest.item_eat(2, "farming:drinking_cup"),
--})

minetest.register_node("farming:coffee_cup", {
	description = "Cup of Coffee (cold)",
	drawtype = "plantlike",
	tiles = {"farming_coffee_cup.png"},
	inventory_image = "farming_coffee_cup.png",
	wield_image = "farming_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(2, "farming:drinking_cup"),
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "farming:coffee_cup",
	recipe = {
		{"farming:drinking_cup", "farming:coffee_beans","bucket:bucket_water"},
		{"","",""},
		{"","",""}
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "farming:coffee_cup_hot",
	recipe = "farming:coffee_cup"
})

--= Hot Cup of Coffee
--minetest.register_craftitem("farming:coffee_cup_hot", {
--	description = "Hot Cup of Coffee",
--	inventory_image = "farming_coffee_cup_hot.png",
--	on_use = minetest.item_eat(3, "farming:drinking_cup"),
--})

minetest.register_node("farming:coffee_cup_hot", {
	description = "Cup of Coffee (hot)",
	drawtype = "plantlike",
	tiles = {"farming_coffee_cup_hot.png"},
	inventory_image = "farming_coffee_cup_hot.png",
	wield_image = "farming_coffee_cup_hot.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(3, "farming:drinking_cup"),
	sounds = default.node_sound_glass_defaults(),
})

-- Define Coffee growth stages

minetest.register_node("farming:coffee_1", {
	drawtype = "plantlike",
	tiles = {"farming_coffee_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:coffee_2", {
	drawtype = "plantlike",
	tiles = {"farming_coffee_2.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:coffee_3", {
	drawtype = "plantlike",
	tiles = {"farming_coffee_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:coffee_4", {
	drawtype = "plantlike",
	tiles = {"farming_coffee_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of growth doesn not have growing group so abm never checks these

minetest.register_node("farming:coffee_5", {
	drawtype = "plantlike",
	tiles = {"farming_coffee_5.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:coffee_beans 2'}, rarity = 1},
			{items = {'farming:coffee_beans 2'}, rarity = 2},
			{items = {'farming:coffee_beans 2'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})
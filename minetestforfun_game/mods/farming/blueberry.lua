
--= Blueberries

minetest.register_craftitem("farming:blueberries", {
	description = "Blueberries",
	inventory_image = "farming_blueberries.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:blueberry_1")
	end,
	on_use = minetest.item_eat(1),
})

-- Blueberry Muffin (Thanks to sosogirl123 for muffin image in deviantart.com)

minetest.register_craftitem("farming:muffin_blueberry", {
	description = "Blueberry Muffin",
	inventory_image = "farming_blueberry_muffin.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "farming:muffin_blueberry 2",
	recipe = {
		{"farming:blueberries", "farming:bread", "farming:blueberries"},
	}
})

-- Define Blueberry growth stages

minetest.register_node("farming:blueberry_1", {
	drawtype = "plantlike",
	tiles = {"farming_blueberry_1.png"},
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

minetest.register_node("farming:blueberry_2", {
	drawtype = "plantlike",
	tiles = {"farming_blueberry_2.png"},
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

minetest.register_node("farming:blueberry_3", {
	drawtype = "plantlike",
	tiles = {"farming_blueberry_3.png"},
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

-- Last stage of growth does not have growing group so abm never checks these

minetest.register_node("farming:blueberry_4", {
	drawtype = "plantlike",
	tiles = {"farming_blueberry_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:blueberries 2'}, rarity = 1},
			{items = {'farming:blueberries'}, rarity = 2},
			{items = {'farming:blueberries'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})
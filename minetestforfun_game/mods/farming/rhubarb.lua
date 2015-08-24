
--= Rhubarb

minetest.register_craftitem("farming:rhubarb", {
	description = "Rhubarb",
	inventory_image = "farming_rhubarb.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:rhubarb_1")
	end,
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("farming:rhubarb_pie", {
	description = "Rhubarb Pie",
	inventory_image = "farming_rhubarb_pie.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	output = "farming:rhubarb_pie",
	recipe = {
		{"", "farming:sugar", ""},
		{"farming:rhubarb", "farming:rhubarb", "farming:rhubarb"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

-- Define Rhubarb growth stages

minetest.register_node("farming:rhubarb_1", {
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_1.png"},
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

minetest.register_node("farming:rhubarb_2", {
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_2.png"},
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

minetest.register_node("farming:rhubarb_3", {
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:rhubarb 2'}, rarity = 1},
			{items = {'farming:rhubarb'}, rarity = 2},
			{items = {'farming:rhubarb'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})
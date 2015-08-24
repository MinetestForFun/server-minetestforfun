
--= Melon

minetest.register_craftitem("farming:melon_slice", {
	description = "Melon Slice",
	inventory_image = "farming_melon_slice.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:melon_1")
	end,
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "farming:melon_8",
	recipe = {
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
	}
})

minetest.register_craft({
	output = "farming:melon_slice 9",
	recipe = {
		{"", "farming:melon_8", ""},
	}
})

-- Define Melon growth stages

minetest.register_node("farming:melon_1", {
	drawtype = "plantlike",
	tiles = {"farming_melon_1.png"},
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

minetest.register_node("farming:melon_2", {
	drawtype = "plantlike",
	tiles = {"farming_melon_2.png"},
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

minetest.register_node("farming:melon_3", {
	drawtype = "plantlike",
	tiles = {"farming_melon_3.png"},
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

minetest.register_node("farming:melon_4", {
	drawtype = "plantlike",
	tiles = {"farming_melon_4.png"},
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

minetest.register_node("farming:melon_5", {
	drawtype = "plantlike",
	tiles = {"farming_melon_5.png"},
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

minetest.register_node("farming:melon_6", {
	drawtype = "plantlike",
	tiles = {"farming_melon_6.png"},
	paramtype = "light",
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

minetest.register_node("farming:melon_7", {
	drawtype = "plantlike",
	tiles = {"farming_melon_7.png"},
	paramtype = "light",
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

minetest.register_node("farming:melon_8", {
	--drawtype = "nodebox",
	description = "Melon",
	tiles = {"farming_melon_top.png", "farming_melon_top.png", "farming_melon_side.png"},
	paramtype = "light",
	walkable = true,
	drop = {
		items = {
			{items = {'farming:melon_slice 9'}, rarity = 1},
		}
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

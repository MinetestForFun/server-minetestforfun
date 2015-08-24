
--= Potato (Original textures from DocFarming mod)
-- https://forum.minetest.net/viewtopic.php?id=3948

minetest.register_craftitem("farming:potato", {
	description = "Potato",
	inventory_image = "farming_potato.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:potato_1")
	end,
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("farming:baked_potato", {
	description = "Baked Potato",
	inventory_image = "farming_baked_potato.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:baked_potato",
	recipe = "farming:potato"
})

-- Define Potato growth stages

minetest.register_node("farming:potato_1", {
	drawtype = "plantlike",
	tiles = {"farming_potato_1.png"},
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

minetest.register_node("farming:potato_2", {
	drawtype = "plantlike",
	tiles = {"farming_potato_2.png"},
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

minetest.register_node("farming:potato_3", {
	drawtype = "plantlike",
	tiles = {"farming_potato_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:potato'}, rarity = 1},
			{items = {'farming:potato'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of growth does not have growing group so abm never checks these

minetest.register_node("farming:potato_4", {
	drawtype = "plantlike",
	tiles = {"farming_potato_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:potato 2'}, rarity = 1},
			{items = {'farming:potato 3'}, rarity = 2},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})

local S = farming.intllib

-- wheat seeds
minetest.register_node("farming:seed_wheat", {
	description = S("Wheat Seed"),
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end,
})

-- harvested wheat
minetest.register_craftitem("farming:wheat", {
	description = S("Wheat"),
	inventory_image = "farming_wheat.png",
})

-- straw
minetest.register_node("farming:straw", {
	description = S("Straw"),
	tiles = {"farming_straw.png"},
	is_ground_content = false,
	groups = {snappy = 3, flammable = 4},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})

-- flour
minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"}
})

-- bread
minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

-- wheat definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_wheat_1.png"},
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
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:wheat_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_wheat_2.png"}
minetest.register_node("farming:wheat_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_wheat_3.png"}
minetest.register_node("farming:wheat_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_wheat_4.png"}
minetest.register_node("farming:wheat_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_wheat_5.png"}
crop_def.drop = {
	items = {
		{items = {'farming:wheat'}, rarity = 2},
		{items = {'farming:seed_wheat'}, rarity = 2},
	}
}
minetest.register_node("farming:wheat_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_wheat_6.png"}
crop_def.drop = {
	items = {
		{items = {'farming:wheat'}, rarity = 2},
		{items = {'farming:seed_wheat'}, rarity = 1},
	}
}
minetest.register_node("farming:wheat_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_wheat_7.png"}
crop_def.drop = {
	items = {
		{items = {'farming:wheat'}, rarity = 1},
		{items = {'farming:wheat'}, rarity = 3},
		{items = {'farming:seed_wheat'}, rarity = 1},
		{items = {'farming:seed_wheat'}, rarity = 3},
	}
}
minetest.register_node("farming:wheat_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.tiles = {"farming_wheat_8.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:wheat'}, rarity = 1},
		{items = {'farming:wheat'}, rarity = 3},
		{items = {'farming:seed_wheat'}, rarity = 1},
		{items = {'farming:seed_wheat'}, rarity = 3},
	}
}
minetest.register_node("farming:wheat_8", table.copy(crop_def))

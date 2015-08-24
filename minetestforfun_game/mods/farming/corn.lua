
--= Corn (Original textures from GeMinecraft)
-- http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1440575-1-2-5-generation-minecraft-beta-1-2-farming-and

minetest.register_craftitem("farming:corn", {
	description = "Corn",
	inventory_image = "farming_corn.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:corn_1")
	end,
	on_use = minetest.item_eat(3),
})

--= Corn on the Cob (Texture by TenPlus1)

minetest.register_craftitem("farming:corn_cob", {
	description = "Corn on the Cob",
	inventory_image = "farming_corn_cob.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:corn_cob",
	recipe = "farming:corn"
})

--= Ethanol (Thanks to JKMurray for this idea)

minetest.register_craftitem("farming:bottle_ethanol", {
	description = "Bottle of Ethanol",
	inventory_image = "farming_bottle_ethanol.png",
})

minetest.register_craft( {
	output = "farming:bottle_ethanol",
	recipe = {
		{ "vessels:glass_bottle", "farming:corn", "farming:corn"},
		{ "farming:corn", "farming:corn", "farming:corn"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:bottle_ethanol",
	burntime = 240,
	replacements = {{ "farming:bottle_ethanol", "vessels:glass_bottle"}}
})

-- Define Corn growth stages

minetest.register_node("farming:corn_1", {
	drawtype = "plantlike",
	tiles = {"farming_corn_1.png"},
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

minetest.register_node("farming:corn_2", {
	drawtype = "plantlike",
	tiles = {"farming_corn_2.png"},
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

minetest.register_node("farming:corn_3", {
	drawtype = "plantlike",
	tiles = {"farming_corn_3.png"},
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

minetest.register_node("farming:corn_4", {
	drawtype = "plantlike",
	tiles = {"farming_corn_4.png"},
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

minetest.register_node("farming:corn_5", {
	drawtype = "plantlike",
	tiles = {"farming_corn_5.png"},
	paramtype = "light",
	waving = 1,
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

minetest.register_node("farming:corn_6", {
	drawtype = "plantlike",
	tiles = {"farming_corn_6.png"},
	visual_scale = 1.45,
	paramtype = "light",
	waving = 1,
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

minetest.register_node("farming:corn_7", {
	drawtype = "plantlike",
	tiles = {"farming_corn_7.png"},
	visual_scale = 1.45,
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:corn'}, rarity = 1},
			{items = {'farming:corn'}, rarity = 2},
			{items = {'farming:corn'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of growth doesn not have growing group so abm never checks these

minetest.register_node("farming:corn_8", {
	drawtype = "plantlike",
	tiles = {"farming_corn_8.png"},
	visual_scale = 1.45,
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:corn 2'}, rarity = 1},
			{items = {'farming:corn 2'}, rarity = 2},
			{items = {'farming:corn 2'}, rarity = 2},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})
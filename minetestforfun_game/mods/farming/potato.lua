
--[[
	Original textures from DocFarming mod
	https://forum.minetest.net/viewtopic.php?id=3948
]]

local S = farming.intllib

-- potato
minetest.register_craftitem("farming:potato", {
	description = S("Potato"),
	inventory_image = "farming_potato.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:potato_1")
	end,
	on_use = minetest.item_eat(1),
})

-- baked potato
minetest.register_craftitem("farming:baked_potato", {
	description = S("Baked Potato"),
	inventory_image = "farming_baked_potato.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:baked_potato",
	recipe = "farming:potato"
})

-- potato definition
local crop_def = {
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
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:potato_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_potato_2.png"}
minetest.register_node("farming:potato_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_potato_3.png"}
crop_def.drop = {
	items = {
		{items = {'farming:potato'}, rarity = 1},
		{items = {'farming:potato'}, rarity = 3},
	}
}
minetest.register_node("farming:potato_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_potato_4.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:potato 2'}, rarity = 1},
		{items = {'farming:potato 3'}, rarity = 2},
	}
}
minetest.register_node("farming:potato_4", table.copy(crop_def))

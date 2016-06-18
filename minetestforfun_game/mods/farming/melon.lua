
local S = farming.intllib

-- melon
minetest.register_craftitem("farming:melon_slice", {
	description = S("Melon Slice"),
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

-- melon definition
local crop_def = {
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
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:melon_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_melon_2.png"}
minetest.register_node("farming:melon_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_melon_3.png"}
minetest.register_node("farming:melon_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_melon_4.png"}
minetest.register_node("farming:melon_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_melon_5.png"}
minetest.register_node("farming:melon_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_melon_6.png"}
minetest.register_node("farming:melon_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_melon_7.png"}
minetest.register_node("farming:melon_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.drawtype = "nodebox"
crop_def.description = S("Melon")
crop_def.tiles = {"farming_melon_top.png", "farming_melon_top.png", "farming_melon_side.png"}
crop_def.selection_box = {-.5, -.5, -.5, .5, .5, .5}
crop_def.walkable = true
crop_def.groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 2, plant = 1}
crop_def.drop = "farming:melon_slice 9"
minetest.register_node("farming:melon_8", table.copy(crop_def))

minetest.register_node("pipeworks:trashcan", {
	description = "Trash Can", 
	drawtype = "normal", 
	tiles = {
		"pipeworks_trashcan_bottom.png",
		"pipeworks_trashcan_bottom.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
		"pipeworks_trashcan_side.png",
	}, 
	groups = {snappy = 3, tubedevice = 1, tubedevice_receiver = 1}, 
	tube = {
		insert_object = function(pos, node, stack, direction)
			return ItemStack("")
		end,
		connect_sides = {left = 1, right = 1, front = 1, back = 1, top = 1, bottom = 1},
		priority = 1, -- Lower than anything else
	}, 
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,7]"..
				"item_image[0,0;1,1;pipeworks:trashcan]"..
				"label[1,0;Trash Can]"..
				"list[context;trash;3.5,1;1,1;]"..
				default.gui_bg..
				default.gui_bg_img..
				default.gui_slots..
				default.get_hotbar_bg(0,3) ..
				"list[current_player;main;0,3;8,4;]")
		meta:set_string("infotext", "Trash Can")
		meta:get_inventory():set_size("trash", 1)
	end, 
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.get_meta(pos):get_inventory():set_stack(listname, index, ItemStack(""))
	end,
})

minetest.register_craft({
	output = "pipeworks:trashcan",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "default:steel_ingot", "", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
	},
})

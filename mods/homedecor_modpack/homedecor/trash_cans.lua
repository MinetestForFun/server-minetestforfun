local S = homedecor.gettext

local tg_cbox = {
	type = "fixed",
	fixed = { -0.35, -0.5, -0.35, 0.35, 0.4, 0.35 }
}

homedecor.register("trash_can_green", {
	drawtype = "mesh",
	mesh = "homedecor_trash_can_green.obj",
	tiles = { "homedecor_pool_table_baize.png" },
	inventory_image = "homedecor_trash_can_green_inv.png",
	description = "Trash Can (green)",
   	groups = {snappy=3},
	selection_box = tg_cbox,
	collision_box = tg_cbox,
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:trash_can_green_open", param2 = node.param2})
	end
})

homedecor.register("trash_can_green_open", {
	drawtype = "mesh",
	mesh = "homedecor_trash_can_green_open.obj",
	tiles = { "homedecor_pool_table_baize.png" },
   	groups = {snappy=3, not_in_creative_inventory=1},
	selection_box = tg_cbox,
	collision_box = tg_cbox,
	drop = "homedecor:trash_can_green",
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:trash_can_green", param2 = node.param2})
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
				"size[8,9]".. default.gui_bg .. default.gui_bg_img .. default.gui_slots ..
				"button[2.5,3.8;3,1;empty;Empty Trash]"..
				"list[current_name;main;2.5,0.5;3,3;]"..
				"list[current_player;main;0,5;8,4;]")
			meta:set_string("infotext", "Trash Can")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in trash can at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in trash can at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from trash can at "..minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.empty then
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
			inv:set_list("main", {})
			minetest.sound_play("homedecor_trash_all", {to_player=sender:get_player_name(), gain = 1.0})
		end
	end
})

local trash_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.125, 0.25 }
}

homedecor.register("trash_can", {
	drawtype = "mesh",
	mesh = "homedecor_trash_can.obj",
	tiles = { "homedecor_trash_can.png" },
	inventory_image = "homedecor_trash_can_inv.png",
	description = "Trash Can (small)",
	groups = {snappy=3},
	selection_box = trash_cbox,
	collision_box = trash_cbox,
})

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
	infotext="Trash Can",
	inventory= {
		size = 9,
		formspec = "size[8,9]" .. default.gui_bg .. default.gui_bg_img .. default.gui_slots ..
		"button[2.5,3.8;3,1;empty;Empty Trash]"..
		"list[context;main;2.5,0.5;3,3;]"..
		"list[current_player;main;0,5;8,4;]",
	},
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.empty then
			local meta = minetest.get_meta(pos)
			meta:get_inventory():set_list("main", {})
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

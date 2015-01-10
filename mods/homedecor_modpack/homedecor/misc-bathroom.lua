local S = homedecor.gettext

local bathroom_tile_colors = {
	{ "1", "white/grey" },
	{ "2", "white/dark grey" },
	{ "3", "white/black" },
	{ "4", "black/dark grey" },
	{ "red", "white/red" },
	{ "green", "white/green" },
	{ "blue", "white/blue" },
	{ "yellow", "white/yellow" },
	{ "tan", "white/tan" },
}

for i in ipairs(bathroom_tile_colors) do
	local color = bathroom_tile_colors[i][1]
	local shade = bathroom_tile_colors[i][2]
	minetest.register_node("homedecor:tiles_"..color, {
		description = "Bathroom/kitchen tiles ("..shade..")",
		tiles = {
			"homedecor_bathroom_tiles_"..color..".png",
			"homedecor_bathroom_tiles_"..color..".png",
			"homedecor_bathroom_tiles_"..color..".png",
			"homedecor_bathroom_tiles_"..color..".png",
			"homedecor_bathroom_tiles_"..color..".png^[transformR90",
			"homedecor_bathroom_tiles_"..color..".png^[transformR90"
		},
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

minetest.register_node("homedecor:towel_rod", {
	description = "Towel rod with towel",
	drawtype = "nodebox",
	tiles = {
		"homedecor_towel_rod_top.png",
		"homedecor_towel_rod_bottom.png",
		"homedecor_towel_rod_sides.png",
		"homedecor_towel_rod_sides.png^[transformFX",
		"homedecor_towel_rod_fb.png",
		"homedecor_towel_rod_fb.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.1875, 0.25, -0.3125, 0.375, 0.5},
			{ 0.3125, 0.1875, 0.25, 0.375, 0.375, 0.5},
			{-0.3125, 0.25, 0.3125, 0.3125, 0.375, 0.375},
			{-0.3125, 0, 0.375, 0.3125, 0.34375, 0.4375},
			{-0.3125, -0.3125, 0.25, 0.3125, 0.34375, 0.3125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.375, -0.3125, 0.25, 0.375, 0.375, 0.5 }
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
	sounds = default.node_sound_defaults(),
})

minetest.register_node('homedecor:medicine_cabinet', {
	drawtype = "nodebox",
	description = S("Medicine Cabinet"),
	tiles = {
		'homedecor_medicine_cabinet_tb.png',
		'homedecor_medicine_cabinet_tb.png',
		'homedecor_medicine_cabinet_sides.png',
		'homedecor_medicine_cabinet_sides.png',
		'homedecor_medicine_cabinet_back.png',
		'homedecor_medicine_cabinet_front.png'
	},
	inventory_image = "homedecor_medicine_cabinet_inv.png",
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
    selection_box = {
        type = "fixed",
		fixed = {-0.3125, -0.1875, 0.3125, 0.3125, 0.5, 0.5}
    },
    node_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, 0.3125, 0.3125, 0.5, 0.5}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:medicine_cabinet_open", param2 = fdir })
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,7]"..
				"list[current_name;main;1,0;6,1;]"..
				"list[current_player;main;0,3;8,4;]")
		meta:set_string("infotext", S("Medicine cabinet"))
		local inv = meta:get_inventory()
		inv:set_size("main", 16)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in medicine cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to medicine cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from medicine cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})

minetest.register_node("homedecor:medicine_cabinet_open", {
	tiles = {
		'homedecor_medicine_cabinet_tb.png',
		'homedecor_medicine_cabinet_tb.png',
		"homedecor_medicine_cabinet_open_right.png",
		'homedecor_medicine_cabinet_sides.png',
		'homedecor_medicine_cabinet_back.png',
		"homedecor_medicine_cabinet_open_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.1875, 0.375, 0.3125, 0.5, 0.5}, -- NodeBox1
			{0.28, -0.1875, -0.1875, 0.3125, 0.5, 0.375}, -- NodeBox2
		}
	},
	drop = "homedecor:medicine_cabinet",
	on_punch = function(pos, node, puncher, pointed_thing)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:medicine_cabinet", param2 = fdir })
	end,
})

minetest.register_node("homedecor:toilet_paper", {
	description = S("Toilet paper"),
	drawtype = "mesh",
	mesh = "homedecor_toilet_paper.obj",
	tiles = { "homedecor_toilet_paper.png" },
	inventory_image = "homedecor_toilet_paper_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = { 
		type = "fixed",
		fixed = { -0.1875, 0.125, 0.0625, 0.25, 0.4375, 0.5 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.1875, 0.125, 0.0625, 0.25, 0.4375, 0.5 }
	},
	groups = {snappy=2,oddly_breakable_by_hand=3,flammable=3},
	sounds = default.node_sound_defaults(),
})


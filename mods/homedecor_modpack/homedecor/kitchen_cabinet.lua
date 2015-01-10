-- This file supplies Kitchen cabinets and kitchen sink

local S = homedecor.gettext

local counter_materials = { "", "granite", "marble", "steel" }

for _, mat in ipairs(counter_materials) do

	local desc = S("Kitchen Cabinet")
	local material = ""

	if mat ~= "" then
		desc = S("Kitchen Cabinet ("..mat.." top)")
		material = "_"..mat
	end

	minetest.register_node('homedecor:kitchen_cabinet'..material, {
		description = desc,
		tiles = { 'homedecor_kitchen_cabinet_top'..material..'.png',
				'homedecor_kitchen_cabinet_bottom.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_front.png'},
		sunlight_propagates = false,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
					"size[8,8]"..
					"list[current_name;main;0,0;8,3;]"..
					"list[current_player;main;0,4;8,4;]")
			meta:set_string("infotext", S("Kitchen Cabinet"))
			local inv = meta:get_inventory()
			inv:set_size("main", 24)
		end,
		can_dig = function(pos,player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			return inv:is_empty("main")
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", S("%s moves stuff in kitchen cabinet at %s"):format(
				player:get_player_name(),
				minetest.pos_to_string(pos)
			))
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			minetest.log("action", S("%s moves stuff to kitchen cabinet at %s"):format(
				player:get_player_name(),
				minetest.pos_to_string(pos)
			))
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			minetest.log("action", S("%s takes stuff from kitchen cabinet at %s"):format(
				player:get_player_name(),
				minetest.pos_to_string(pos)
			))
		end,
	})
end

minetest.register_node('homedecor:kitchen_cabinet_half', {	
	drawtype="nodebox",
	description = S('Half-height Kitchen Cabinet (on ceiling)'),
	tiles = { 'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_bottom.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_front_half.png'},
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
        selection_box = {
                type = "fixed",
                fixed = { -0.5, 0, -0.5, 0.5, 0.5, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, 0, -0.5, 0.5, 0.5, 0.5 }
        },
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,7]"..
				"list[current_name;main;1,0;6,2;]"..
				"list[current_player;main;0,3;8,4;]")
		meta:set_string("infotext", S("Kitchen Cabinet"))
		local inv = meta:get_inventory()
		inv:set_size("main", 12)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})


minetest.register_node('homedecor:kitchen_cabinet_with_sink', {
	description = S("Kitchen Cabinet with sink"),
	drawtype = "mesh",
	mesh = "homedecor_kitchen_sink.obj",
	tiles = { "homedecor_kitchen_sink.png" },
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,7]"..
				"list[current_name;main;0,0;8,2;]"..
				"list[current_player;main;0,3;8,4;]")
		meta:set_string("infotext", S("Under-sink cabinet"))
		local inv = meta:get_inventory()
		inv:set_size("main", 16)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from kitchen cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})

-- This file supplies refrigerators

local S = homedecor.gettext

-- nodebox models

local fridge_model_bottom = {
	type = "fixed",
	fixed = {
		{0, -0.4375, -0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
		{-0.5, -0.5, -0.42, 0.5, 0.5, 0.5}, -- NodeBox2
		{-0.5, -0.4375, -0.4375, -0.0625, 0.5, 0.5}, -- NodeBox3
		{0, 0.25, -0.5, 0.0625, 0.3125, -0.4375}, -- NodeBox4
		{-0.125, 0.25, -0.5, -0.0625, 0.3125, -0.4375}, -- NodeBox5
		{0, 0.25, -0.5, 0.0625, 0.5, -0.473029}, -- NodeBox6
		{-0.125, 0.25, -0.5, -0.0625, 0.5, -0.473029}, -- NodeBox7
	}
}

local fridge_model_top = {
	type = "fixed",
	fixed = {
		{0, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
		{-0.0625, -0.5, -0.42, 0, 0.5, 0.5}, -- NodeBox2
		{-0.5, -0.5, -0.4375, -0.0625, -0.4375, 0.5}, -- NodeBox3
		{-0.5, -0.5, -0.4375, -0.4375, 0.5, 0.5}, -- NodeBox4
		{-0.5, -0.1875, -0.4375, -0.0625, 0.5, 0.5}, -- NodeBox5
		{-0.4375, -0.4375, -0.125, -0.0625, -0.1875, 0.5}, -- NodeBox6
		{-0.125, -0.4375, -0.4375, -0.0625, -0.1875, -0.125}, -- NodeBox7
		{-0.3125, -0.3125, -0.307054, -0.25, -0.1875, -0.286307}, -- NodeBox8
		{-0.125, 0, -0.5, -0.0625, 0.0625, -0.4375}, -- NodeBox9
		{0, 0, -0.5, 0.0625, 0.0625, -0.4375}, -- NodeBox10
		{0, -0.5, -0.5, 0.0625, 0.0625, -0.473029}, -- NodeBox11
		{-0.125, -0.5, -0.5, -0.0625, 0.0625, -0.473029}, -- NodeBox12
	}
}

-- steel-textured fridge

minetest.register_node("homedecor:refrigerator_steel_bottom", {
	tiles = {
		"default_steel_block.png",
		"homedecor_refrigerator_steel_bottom.png",
		"homedecor_refrigerator_steel_sides1.png",
		"homedecor_refrigerator_steel_sides1.png^[transformFX",
		"homedecor_refrigerator_steel_back1.png",
		"homedecor_refrigerator_steel_front2.png"
	},
	inventory_image = "homedecor_refrigerator_steel_inv.png",
    description = S("Refrigerator (stainless steel)"),
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy=3},
	node_box = fridge_model_bottom,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		local pnode = minetest.get_node(pointed_thing.under)
		local rnodedef = minetest.registered_nodes[pnode.name]

		if not rnodedef["buildable_to"] then
			pos = pointed_thing.above
		end

		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }

		local tnode = minetest.get_node(pos)
		local tnode2 = minetest.get_node(pos2)

		if homedecor.get_nodedef_field(tnode.name, "buildable_to")
		  and homedecor.get_nodedef_field(tnode2.name, "buildable_to")
		  and not minetest.is_protected(pos, placer:get_player_name())
		  and not minetest.is_protected(pos2, placer:get_player_name()) then
			local nodename = itemstack:get_name()
			minetest.add_node(pos, { name = nodename, param2 = fdir })
			minetest.add_node(pos2, { name = "homedecor:refrigerator_steel_top", param2 = fdir })

			if string.find(nodename, "_locked") then
		        local meta = minetest.get_meta(pos)
				meta:set_string("owner", placer:get_player_name() or "")
				meta:set_string("infotext", S("Locked Refrigerator (owned by %s)"):format(meta:get_string("owner")))
			end

			if not homedecor.expect_infinite_stacks then
				itemstack:take_item()
				return itemstack
			end
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:refrigerator_steel_top" then
			minetest.remove_node(pos2)
		end
	end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[10,10]"..
                "list[current_name;main;0,0;10,5;]"..
                "list[current_player;main;1,6;8,4;]")
        meta:set_string("infotext", S("Refrigerator"))
        local inv = meta:get_inventory()
        inv:set_size("main",50)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
})

minetest.register_node("homedecor:refrigerator_steel_top", {
	tiles = {
		"homedecor_refrigerator_steel_top.png",
		"default_steel_block.png",
		"homedecor_refrigerator_steel_sides1.png",
		"homedecor_refrigerator_steel_sides1.png^[transformFX",
		"homedecor_refrigerator_steel_back1.png",
		"homedecor_refrigerator_steel_front1.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy=3},
	node_box = fridge_model_top,
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

-- white, enameled fridge

minetest.register_node("homedecor:refrigerator_white_bottom", {
	tiles = {
		"default_steel_block.png",
		"homedecor_refrigerator_white_bottom.png",
		"homedecor_refrigerator_white_sides1.png",
		"homedecor_refrigerator_white_sides1.png^[transformFX",
		"homedecor_refrigerator_white_back1.png",
		"homedecor_refrigerator_white_front2.png"
	},
	inventory_image = "homedecor_refrigerator_white_inv.png",
    description = S("Refrigerator"),
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy=3},
	node_box = fridge_model_bottom,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		local pnode = minetest.get_node(pointed_thing.under)
		local rnodedef = minetest.registered_nodes[pnode.name]

		if not rnodedef["buildable_to"] then
			pos = pointed_thing.above
		end

		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }

		local tnode = minetest.get_node(pos)
		local tnode2 = minetest.get_node(pos2)

		if homedecor.get_nodedef_field(tnode.name, "buildable_to")
		  and homedecor.get_nodedef_field(tnode2.name, "buildable_to")
		  and not minetest.is_protected(pos, placer:get_player_name())
		  and not minetest.is_protected(pos2, placer:get_player_name()) then
			local nodename = itemstack:get_name()
			minetest.add_node(pos, { name = nodename, param2 = fdir })
			minetest.add_node(pos2, { name = "homedecor:refrigerator_white_top", param2 = fdir })

			if string.find(nodename, "_locked") then
		        local meta = minetest.get_meta(pos)
				meta:set_string("owner", placer:get_player_name() or "")
				meta:set_string("infotext", S("Locked Refrigerator (owned by %s)"):format(meta:get_string("owner")))
			end

			if not homedecor.expect_infinite_stacks then
				itemstack:take_item()
				return itemstack
			end
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:refrigerator_white_top" then
			minetest.remove_node(pos2)
		end
	end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[10,10]"..
                "list[current_name;main;0,0;10,5;]"..
                "list[current_player;main;1,6;8,4;]")
        meta:set_string("infotext", S("Refrigerator"))
        local inv = meta:get_inventory()
        inv:set_size("main",50)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from refrigerator at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
    end,
})

minetest.register_node("homedecor:refrigerator_white_top", {
	tiles = {
		"homedecor_refrigerator_white_top.png",
		"default_steel_block.png",
		"homedecor_refrigerator_white_sides1.png",
		"homedecor_refrigerator_white_sides1.png^[transformFX",
		"homedecor_refrigerator_white_back1.png",
		"homedecor_refrigerator_white_front1.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy=3},
	node_box = fridge_model_top,
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

-- convert the old single-node fridges to the new two-node models

minetest.register_abm({
	nodenames = { "homedecor:refrigerator" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_white_bottom", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_white_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_locked" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_white_bottom_locked", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_white_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_steel" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_steel_bottom", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_steel_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_steel_locked" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_steel_bottom_locked", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_steel_top", param2 = fdir })
	end
})


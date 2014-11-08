-- mods/default/nodes.lua


local function get_chest_neighborpos(pos, param2, side)
	if side == "right" then
		if param2 == 0 then
			return {x=pos.x-1, y=pos.y, z=pos.z}
		elseif param2 == 1 then
			return {x=pos.x, y=pos.y, z=pos.z+1}
		elseif param2 == 2 then
			return {x=pos.x+1, y=pos.y, z=pos.z}
		elseif param2 == 3 then
			return {x=pos.x, y=pos.y, z=pos.z-1}
		end
	else
		if param2 == 0 then
			return {x=pos.x+1, y=pos.y, z=pos.z}
		elseif param2 == 1 then
			return {x=pos.x, y=pos.y, z=pos.z-1}
		elseif param2 == 2 then
			return {x=pos.x-1, y=pos.y, z=pos.z}
		elseif param2 == 3 then
			return {x=pos.x, y=pos.y, z=pos.z+1}
		end
	end
end

local function hacky_swap_node(pos,name, param2)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	if node.name == name then
		return
	end
	node.name = name
	node.param2 = param2 or node.param2
	local meta0 = meta:to_table()
	minetest.set_node(pos,node)
	meta = minetest.get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_node(":default:chest", {
	description = "Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	stack_max = 64,
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local param2 = minetest.get_node(pos).param2
		local meta = minetest.get_meta(pos)
		if minetest.get_node(get_chest_neighborpos(pos, param2, "right")).name == "default:chest" then
			minetest.set_node(pos, {name="chest:chest_right",param2=param2})
			local p = get_chest_neighborpos(pos, param2, "right")
			meta:set_string("formspec",
					"size[9,11.5]"..
					"list[nodemeta:"..p.x..","..p.y..","..p.z..";main;0,0;9,3;]"..
					"list[current_name;main;0,3;9,3;]"..
					"list[current_player;main;0,7;9,3;9]"..
					"list[current_player;main;0,10.5;9,1;]")
			meta:set_string("infotext", "Large Chest")
			hacky_swap_node(p, "chest:chest_left", param2)
			local m = minetest.get_meta(p)
			m:set_string("formspec",
					"size[9,11.5]"..
					"list[current_name;main;0,0;9,3;]"..
					"list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;0,3;9,3;]"..
					"list[current_player;main;0,7;9,3;9]"..
					"list[current_player;main;0,10.5;9,1;]")
			m:set_string("infotext", "Large Chest")
		elseif minetest.get_node(get_chest_neighborpos(pos, param2, "left")).name == "default:chest" then
			minetest.set_node(pos, {name="chest:chest_left",param2=param2})
			local p = get_chest_neighborpos(pos, param2, "left")
			meta:set_string("formspec",
					"size[9,11.5]"..
					"list[current_name;main;0,0;9,3;]"..
					"list[nodemeta:"..p.x..","..p.y..","..p.z..";main;0,3;9,3;]"..
					"list[current_player;main;0,7;9,3;9]"..
					"list[current_player;main;0,10.5;9,1;]")
			meta:set_string("infotext", "Large Chest")
			hacky_swap_node(p, "chest:chest_right", param2)
			local m = minetest.get_meta(p)
			m:set_string("formspec",
					"size[9,11.5]"..
					"list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;0,0;9,3;]"..
					"list[current_name;main;0,3;9,3;]"..
					"list[current_player;main;0,7;9,3;9]"..
					"list[current_player;main;0,10.5;9,1;]")
			m:set_string("infotext", "Large Chest")
		else
			meta:set_string("formspec",
					"size[9,8.5]"..
					"list[current_name;main;0,0;9,3;]"..
					"list[current_player;main;0,4;9,3;9]"..
					"list[current_player;main;0,7.5.5;9,1;]")
			meta:set_string("infotext", "Chest")
		end
		local inv = meta:get_inventory()
		inv:set_size("main", 9*3)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_node("chest:chest_left", {
	tiles = {"default_chest_top_big.png", "default_chest_top_big.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side_big.png^[transformFX", "default_chest_front_big.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	drop = "default:chest",
	sounds = default.node_sound_wood_defaults(),
	on_destruct = function(pos)
		local m = minetest.get_meta(pos)
		if m:get_string("infotext") == "Chest" then
			return
		end
		local param2 = minetest.get_node(pos).param2
		local p = get_chest_neighborpos(pos, param2, "left")
		if not p or minetest.get_node(p).name ~= "chest:chest_right" then
			return
		end
		local meta = minetest.get_meta(p)
		meta:set_string("formspec",
				"size[9,8.5]"..
				"list[current_name;main;0,0;9,3;]"..
				"list[current_player;main;0,4;9,3;9]"..
				"list[current_player;main;0,7.5.5;9,1;]")
		meta:set_string("infotext", "Chest")
		hacky_swap_node(p, "default:chest")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_node("chest:chest_right", {
	tiles = {"default_chest_top_big.png^[transformFX", "default_chest_top_big.png^[transformFX", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side_big.png", "default_chest_front_big.png^[transformFX"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	drop = "default:chest",
	sounds = default.node_sound_wood_defaults(),
	on_destruct = function(pos)
		local m = minetest.get_meta(pos)
		if m:get_string("infotext") == "Chest" then
			return
		end
		local param2 = minetest.get_node(pos).param2
		local p = get_chest_neighborpos(pos, param2, "right")
		if not p or minetest.get_node(p).name ~= "chest:chest_left" then
			return
		end
		local meta = minetest.get_meta(p)
		meta:set_string("formspec",
				"size[9,8.5]"..
				"list[current_name;main;0,0;9,3;]"..
				"list[current_player;main;0,4;9,3;9]"..
				"list[current_player;main;0,7.5.5;9,1;]")
		meta:set_string("infotext", "Chest")
		hacky_swap_node(p, "default:chest")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})


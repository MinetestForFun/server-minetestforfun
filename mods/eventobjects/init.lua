minetest.register_tool("eventobjects:spleef_shovel", {
	description = "Golden Spleef Shovel",
	inventory_image = "eventobjects_spleef_shovel.png",
	wield_image = "eventobjects_spleef_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.40}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_node("eventobjects:surprise_node", {
	description = "'?' block",
	inventory_image = minetest.inventorycube("eventobjects_surprise_node.png"),
	tiles = {
		"eventobjects_surprise_node_top.png", "eventobjects_surprise_node_top.png", {name = "eventobjects_surprise_node_animated.png", animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5}}
	},
	special_tiles = {
		{
			image = "eventobjects_surprise_node_animated.png",
			backface_culling=false,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
		{
			image = "eventobjects_surprise_node_animated.png",
			backface_culling=true,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		}
	},
	groups = {oddly_breakable_by_hand = 2},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		meta:set_string("infotext","?")
		meta:set_string("formspec",
				"size[11,12]" ..
				"list[current_name;main;0.45,0.45;10,7;]" ..
				"list[current_player;main;1.45,8;8,4;]"
		)
		inv:set_size("main",70)
	end,
	allow_metadata_inventory_put = function(pos, to_list, to_index, stack, player)
		if player and minetest.check_player_privs(player:get_player_name(),{server=true}) then
			return stack:get_count()
		else
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, from_list, from_index, stack, player)
		print(from_list)
		print(from_index)
		if player and minetest.check_player_privs(player:get_player_name(),{server=true}) then
			return stack:get_count()
		else
			return 0
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

	end,
	on_punch = function(pos, node, puncher, pointed_things)
		-- Spawn betweek 5 and 20 random nodes
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		if inv:is_empty("main") then
			minetest.chat_send_player(puncher:get_player_name(),"Cannot spread items, inventory empty")
			return
		end
		for cnt = 1,70 do
			local stack = inv:get_stack("main",cnt)
			if stack:get_name() ~= "" then
				local obj = minetest.spawn_item({x=pos.x, y = pos.y + 1,z=pos.z},stack)
				inv:remove_item("main",stack)
				if obj then
					obj:setvelocity({x = math.random(-0.4,0.4), y = math.random(2,9), z = math.random(-0.4,0.4)})
				end
			end
		end
		minetest.remove_node(pos)
	end,
})

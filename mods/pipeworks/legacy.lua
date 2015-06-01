
if not minetest.get_modpath("auto_tree_tap") and 
  minetest.get_modpath("technic") then

	minetest.register_abm({
		nodenames = { "auto_tree_tap:off", "auto_tree_tap:on" },
		chance = 1,
		interval = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("pick", 1)
			inv:set_size("ghost_pick", 1)
			inv:set_size("main", 100)
			minetest.set_node(pos, {name = "pipeworks:nodebreaker_off", param2 = fdir})
			minetest.registered_nodes["pipeworks:nodebreaker_off"].on_punch(pos, node)
			inv:set_stack("pick", 1, ItemStack("technic:treetap"))
		end
	})

	minetest.register_node(":auto_tree_tap:off", {
		description = "Auto-Tap",
		tiles = {"pipeworks_nodebreaker_top_off.png","pipeworks_nodebreaker_bottom_off.png","pipeworks_nodebreaker_side2_off.png","pipeworks_nodebreaker_side1_off.png",
			"pipeworks_nodebreaker_back.png","pipeworks_nodebreaker_front_off.png"},
		is_ground_content = true,
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2, mesecon = 2,tubedevice=1, not_in_creative_inventory=1 },
		sounds = default.node_sound_stone_defaults(),
		tube = {connect_sides={back=1}},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("pick", 1)
			inv:set_stack("pick", 1, ItemStack("default:pick_mese"))
		end,
		after_place_node = function (pos, placer)
			pipeworks.scan_for_tube_objects(pos, placer)
			local placer_pos = placer:getpos()
		
			--correct for the player's height
			if placer:is_player() then placer_pos.y = placer_pos.y + 1.5 end
		
			--correct for 6d facedir
			if placer_pos then
				local dir = {
					x = pos.x - placer_pos.x,
					y = pos.y - placer_pos.y,
					z = pos.z - placer_pos.z
				}
				local node = minetest.get_node(pos)
				node.param2 = minetest.dir_to_facedir(dir, true)
				minetest.set_node(pos, node)
				minetest.log("action", "real (6d) facedir: " .. node.param2)
			end
		end,
		after_dig_node = pipeworks.scan_for_tube_objects,
	})
end

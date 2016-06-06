minetest.register_node("more_chests:wifi", {
	description = "Wifi Chest",
	tiles = {"wifi_top.png", "wifi_top.png", "wifi_side.png",
		"wifi_side.png", "wifi_side.png",
{name="wifi_front_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_player;more_chests:wifi;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]"..
				"listring[current_player;more_chests:wifi]" ..
				"listring[current_player;main]")
		meta:set_string("infotext", "Wifi Chest")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in wifi chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to wifi chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from wifi chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_craft({
	output = 'more_chests:wifi',
	recipe = {
		{'default:wood','default:mese','default:wood'},
		{'default:wood','default:steel_ingot','default:wood'},
		{'default:wood','default:wood','default:wood'}
	}
})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("more_chests:wifi", 8*4)
end)


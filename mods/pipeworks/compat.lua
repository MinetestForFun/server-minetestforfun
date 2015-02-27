-- this bit of code modifies the default chests and furnaces to be compatible
-- with pipeworks.

minetest.override_item("default:furnace", {
	tiles = {
		"default_furnace_top.png^pipeworks_tube_connection_stony.png",
		"default_furnace_bottom.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		"default_furnace_front.png"
	},
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1},
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:add_item("fuel",stack)
			else
				return inv:add_item("src",stack)
			end
		end,
		can_insert = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:room_for_item("fuel", stack)
			else
				return inv:room_for_item("src", stack)
			end
		end,
		input_inventory = "dst",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.override_item("default:furnace_active", {
	tiles = {
		"default_furnace_top.png^pipeworks_tube_connection_stony.png",
		"default_furnace_bottom.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		"default_furnace_side.png^pipeworks_tube_connection_stony.png",
		{
			image = "default_furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1, not_in_creative_inventory = 1},
	tube = {
		insert_object = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:add_item("fuel", stack)
			else
				return inv:add_item("src", stack)
			end
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if direction.y == 1 then
				return inv:room_for_item("fuel", stack)
			else
				return inv:room_for_item("src", stack)
			end
		end,
		input_inventory = "dst",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.override_item("default:chest", {
	tiles = {
		"default_chest_top.png^pipeworks_tube_connection_wooden.png",
		"default_chest_top.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_front.png"
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1, tubedevice_receiver = 1},
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.override_item("default:chest_locked", {
	tiles = {
		"default_chest_top.png^pipeworks_tube_connection_wooden.png",
		"default_chest_top.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_side.png^pipeworks_tube_connection_wooden.png",
		"default_chest_lock.png"
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1, tubedevice_receiver = 1},
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("main", stack)
		end,
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	after_place_node = function (pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Chest (owned by "..
		meta:get_string("owner")..")")
		pipeworks.after_place(pos)
	end,
	after_dig_node = pipeworks.after_dig
})


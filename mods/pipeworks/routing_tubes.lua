-- the default tube and default textures
pipeworks.register_tube("pipeworks:tube", "Pneumatic tube segment")
minetest.register_craft( {
	output = "pipeworks:tube_1 6",
	recipe = {
	        { "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
	        { "", "", "" },
	        { "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
	},
})

-- the high priority tube is a low-cpu replacement for sorting tubes in situations
-- where players would use them for simple routing (turning off paths)
-- without doing actual sorting, like at outputs of tubedevices that might both accept and eject items
if pipeworks.enable_priority_tube then
	local color = "#ff3030:128"
	pipeworks.register_tube("pipeworks:priority_tube", {
			description = "High Priority Tube Segment",
			inventory_image = "pipeworks_tube_inv.png^[colorize:" .. color,
			plain = { "pipeworks_tube_plain.png^[colorize:" .. color },
			noctr = { "pipeworks_tube_noctr.png^[colorize:" .. color },
			ends = { "pipeworks_tube_end.png^[colorize:" .. color },
			short = "pipeworks_tube_short.png^[colorize:" .. color,
			node_def = {
				tube = { priority = 150 } -- higher than tubedevices (100)
			},
	})
	minetest.register_craft( {
		output = "pipeworks:priority_tube_1 6",
		recipe = {
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
			{ "default:gold_ingot", "", "default:gold_ingot" },
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
		},
	})
end

if pipeworks.enable_accelerator_tube then
	pipeworks.register_tube("pipeworks:accelerator_tube", {
			description = "Accelerating Pneumatic Tube Segment",
			inventory_image = "pipeworks_accelerator_tube_inv.png",
			plain = { "pipeworks_accelerator_tube_plain.png" },
			noctr = { "pipeworks_accelerator_tube_noctr.png" },
			ends = { "pipeworks_accelerator_tube_end.png" },
			short = "pipeworks_accelerator_tube_short.png",
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						 velocity.speed = velocity.speed+1
						 return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end}
			},
	})
	minetest.register_craft( {
		output = "pipeworks:accelerator_tube_1 2",
		recipe = {
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
			{ "default:mese_crystal_fragment", "default:steel_ingot", "default:mese_crystal_fragment" },
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
		},
	})
end

if pipeworks.enable_crossing_tube then
	pipeworks.register_tube("pipeworks:crossing_tube", {
			description = "Crossing Pneumatic Tube Segment",
			inventory_image = "pipeworks_crossing_tube_inv.png",
			plain = { "pipeworks_crossing_tube_plain.png" },
			noctr = { "pipeworks_crossing_tube_noctr.png" },
			ends = { "pipeworks_crossing_tube_end.png" },
			short = "pipeworks_crossing_tube_short.png",
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack) return {velocity} end }
			},
	})
	minetest.register_craft( {
		output = "pipeworks:crossing_tube_1 5",
		recipe = {
			{ "", "pipeworks:tube_1", "" },
			{ "pipeworks:tube_1", "pipeworks:tube_1", "pipeworks:tube_1" },
			{ "", "pipeworks:tube_1", "" }
		},
	})
end

if pipeworks.enable_one_way_tube then
	minetest.register_node("pipeworks:one_way_tube", {
		description = "One way tube",
		tiles = {"pipeworks_one_way_tube_top.png", "pipeworks_one_way_tube_top.png", "pipeworks_one_way_tube_output.png",
			"pipeworks_one_way_tube_input.png", "pipeworks_one_way_tube_side.png", "pipeworks_one_way_tube_top.png"},
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {type = "fixed",
			fixed = {{-1/2, -9/64, -9/64, 1/2, 9/64, 9/64}}},
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1},
		sounds = default.node_sound_wood_defaults(),
		tube = {
			connect_sides = {left = 1, right = 1},
			can_go = function(pos, node, velocity, stack)
				return {velocity}
			end,
			can_insert = function(pos, node, stack, direction)
				local dir = minetest.facedir_to_right_dir(node.param2)
				return vector.equals(dir, direction)
			end,
			priority = 75 -- Higher than normal tubes, but lower than receivers
		},
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig,
	})
	minetest.register_craft({
		output = "pipeworks:one_way_tube 2",
		recipe = {
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
			{ "group:stick", "default:mese_crystal", "homedecor:plastic_sheeting" },
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
		},
	})
end

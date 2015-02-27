if pipeworks.enable_detector_tube then
	local detector_tube_step = 2 * tonumber(minetest.setting_get("dedicated_server_step"))
	pipeworks.register_tube("pipeworks:detector_tube_on", {
			description = "Detecting Pneumatic Tube Segment on (you hacker you)",
			inventory_image = "pipeworks_detector_tube_inv.png",
			plain = { "pipeworks_detector_tube_plain.png" },
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						 local meta = minetest.get_meta(pos)
						 local name = minetest.get_node(pos).name
						 local nitems = meta:get_int("nitems")+1
						 meta:set_int("nitems", nitems)
						 local saved_pos = vector.new(pos)
						 minetest.after(detector_tube_step, minetest.registered_nodes[name].item_exit, saved_pos)
						 return pipeworks.notvel(pipeworks.meseadjlist,velocity)
					end},
				groups = {mesecon = 2, not_in_creative_inventory = 1},
				drop = "pipeworks:detector_tube_off_1",
				mesecons = {receptor = {state = "on", rules = pipeworks.mesecons_rules}},
				item_exit = function(pos)
					local meta = minetest.get_meta(pos)
					local nitems = meta:get_int("nitems")-1
					local node = minetest.get_node(pos)
					local name = node.name
					local fdir = node.param2
					if nitems == 0 then
						 minetest.set_node(pos, {name = string.gsub(name, "on", "off"), param2 = fdir})
						 mesecon.receptor_off(pos, pipeworks.mesecons_rules)
					else
						 meta:set_int("nitems", nitems)
					end
				end,
				on_construct = function(pos)
					 local meta = minetest.get_meta(pos)
					 meta:set_int("nitems", 1)
					 local name = minetest.get_node(pos).name
					 local saved_pos = vector.new(pos)
					 minetest.after(detector_tube_step, minetest.registered_nodes[name].item_exit, saved_pos)
				end,
			},
	})
	pipeworks.register_tube("pipeworks:detector_tube_off", {
			description = "Detecting Pneumatic Tube Segment",
			inventory_image = "pipeworks_detector_tube_inv.png",
			plain = { "pipeworks_detector_tube_plain.png" },
			node_def = {
				tube = {can_go = function(pos, node, velocity, stack)
						local node = minetest.get_node(pos)
						local name = node.name
						local fdir = node.param2
						minetest.set_node(pos,{name = string.gsub(name, "off", "on"), param2 = fdir})
						mesecon.receptor_on(pos, pipeworks.mesecons_rules)
						return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end},
				groups = {mesecon = 2},
				mesecons = {receptor = {state = "off", rules = pipeworks.mesecons_rules }},
			},
	})

	minetest.register_craft( {
		output = "pipeworks:conductor_tube_off_1 6",
		recipe = {
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
			{ "mesecons:mesecon", "mesecons:mesecon", "mesecons:mesecon" },
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
		},
	})
end

if pipeworks.enable_conductor_tube then
	pipeworks.register_tube("pipeworks:conductor_tube_off", {
			description = "Conducting Pneumatic Tube Segment",
			inventory_image = "pipeworks_conductor_tube_inv.png",
			short = "pipeworks_conductor_tube_short.png",
			plain = { "pipeworks_conductor_tube_plain.png" },
			noctr = { "pipeworks_conductor_tube_noctr.png" },
			ends = { "pipeworks_conductor_tube_end.png" },
			node_def = {
				groups = {mesecon = 2},
				mesecons = {conductor = {state = "off",
							  rules = pipeworks.mesecons_rules,
							  onstate = "pipeworks:conductor_tube_on_#id"}}
			},
	})
	pipeworks.register_tube("pipeworks:conductor_tube_on", {
			description = "Conducting Pneumatic Tube Segment on (you hacker you)",
			inventory_image = "pipeworks_conductor_tube_inv.png",
			short = "pipeworks_conductor_tube_short.png",
			plain = { "pipeworks_conductor_tube_on_plain.png" },
			noctr = { "pipeworks_conductor_tube_on_noctr.png" },
			ends = { "pipeworks_conductor_tube_on_end.png" },
			node_def = {
				groups = {mesecon = 2, not_in_creative_inventory = 1},
				drop = "pipeworks:conductor_tube_off_1",
				mesecons = {conductor = {state = "on",
							  rules = pipeworks.mesecons_rules,
							  offstate = "pipeworks:conductor_tube_off_#id"}}
			},
	})

	minetest.register_craft( {
		output = "pipeworks:detector_tube_off_1 2",
		recipe = {
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
			{ "mesecons:mesecon", "mesecons_materials:silicon", "mesecons:mesecon" },
			{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
		},
	})
end



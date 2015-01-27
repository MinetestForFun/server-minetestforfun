-- This file supplies the various kinds of pneumatic tubes

pipeworks.tubenodes = {}

minetest.register_alias("pipeworks:tube", "pipeworks:tube_000000")

-- now, a function to define the tubes

local REGISTER_COMPATIBILITY = true

local vti = {4, 3, 2, 1, 6, 5}

local register_one_tube = function(name, tname, dropname, desc, plain, noctrs, ends, short, inv, special, connects, style)
	local outboxes = {}
	local outsel = {}
	local outimgs = {}
	
	for i = 1, 6 do
		outimgs[vti[i]] = plain[i]
	end
	
	for _, v in ipairs(connects) do
		table.extend(outboxes, pipeworks.tube_boxes[v])
		table.insert(outsel, pipeworks.tube_selectboxes[v])
		outimgs[vti[v]] = noctrs[v]
	end

	if #connects == 1 then
		local v = connects[1]
		v = v-1 + 2*(v%2) -- Opposite side
		outimgs[vti[v]] = ends[v]
	end

	local tgroups = {snappy = 3, tube = 1, tubedevice = 1, not_in_creative_inventory = 1}
	local tubedesc = desc.." "..dump(connects).."... You hacker, you."
	local iimg = plain[1]
	local wscale = {x = 1, y = 1, z = 1}

	if #connects == 0 then
		tgroups = {snappy = 3, tube = 1, tubedevice = 1}
		tubedesc = desc
		iimg=inv
		outimgs = {
			short, short,
			ends[3],ends[4],
			short, short
		}
		outboxes = { -24/64, -9/64, -9/64, 24/64, 9/64, 9/64 }
		outsel = { -24/64, -10/64, -10/64, 24/64, 10/64, 10/64 }
		wscale = {x = 1, y = 1, z = 0.01}
	end
	
	local rname = name.."_"..tname
	table.insert(pipeworks.tubenodes, rname)
	
	local nodedef = {
		description = tubedesc,
		drawtype = "nodebox",
		tiles = outimgs,
		sunlight_propagates = true,
		inventory_image = iimg,
		wield_image = iimg,
		wield_scale = wscale,
		paramtype = "light",
		selection_box = {
			type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = tgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		stack_max = 99,
		basename = name,
		style = style,
		drop = name.."_"..dropname,
		tubelike = 1,
		tube = {
			connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1},
			priority = 50
		},
		--[[after_place_node = function(pos)
			pipeworks.scan_for_tube_objects(pos)
			if minetest.registered_nodes[rname].after_place_node_ then
				minetest.registered_nodes[rname].after_place_node_(pos)
			end
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_tube_objects(pos)
			if minetest.registered_nodes[rname].after_dig_node_ then
				minetest.registered_nodes[rname].after_dig_node_(pos)
			end
		end]]
	}
	if style == "6d" then
		nodedef.paramtype2 = "facedir"
	end
	
	if special == nil then special = {} end

	for key, value in pairs(special) do
		--if key == "after_dig_node" or key == "after_place_node" then
		--	nodedef[key.."_"] = value
		if key == "groups" then
			for group, val in pairs(value) do
				nodedef.groups[group] = val
			end
		elseif key == "tube" then
			for key, val in pairs(value) do
				nodedef.tube[key] = val
			end
		else
			nodedef[key] = table.recursive_replace(value, "#id", tname)
		end
	end

	minetest.register_node(rname, nodedef)
end

pipeworks.register_tube = function(name, desc, plain, noctrs, ends, short, inv, special, old_registration)
	if old_registration then
		for xm = 0, 1 do
		for xp = 0, 1 do
		for ym = 0, 1 do
		for yp = 0, 1 do
		for zm = 0, 1 do
		for zp = 0, 1 do
			local connects = {}
			if xm == 1 then
				connects[#connects+1] = 1
			end
			if xp == 1 then
				connects[#connects+1] = 2
			end
			if ym == 1 then
				connects[#connects+1] = 3
			end
			if yp == 1 then
				connects[#connects+1] = 4
			end
			if zm == 1 then
				connects[#connects+1] = 5
			end
			if zp == 1 then
				connects[#connects+1] = 6
			end
			local tname = xm..xp..ym..yp..zm..zp
			register_one_tube(name, tname, "000000", desc, plain, noctrs, ends, short, inv, special, connects, "old")
		end
		end
		end
		end
		end
		end
	else
		-- 6d tubes: uses only 10 nodes instead of 64, but the textures must be rotated
		local cconnects = {{}, {1}, {1, 2}, {1, 3}, {1, 3, 5}, {1, 2, 3}, {1, 2, 3, 5}, {1, 2, 3, 4}, {1, 2, 3, 4, 5}, {1, 2, 3, 4, 5, 6}}
		for index, connects in ipairs(cconnects) do
			register_one_tube(name, tostring(index), "1", desc, plain, noctrs, ends, short, inv, special, connects, "6d")
		end
		if REGISTER_COMPATIBILITY then
			local cname = name.."_compatibility"
			minetest.register_node(cname, {
				drawtype = "airlike",
				style = "6d",
				basename = name,
				inventory_image = inv,
				wield_image = inv,
				paramtype = "light",
				sunlight_propagates = true,
				description = "Pneumatic tube segment (legacy)",
				--[[after_place_node = function(pos)
					pipeworks.scan_for_tube_objects(pos)
					if minetest.registered_nodes[name.."_1"].after_place_node_ then
						minetest.registered_nodes[name.."_1"].after_place_node_(pos)
					end
				end,]]
				groups = {not_in_creative_inventory = 1, tube_to_update = 1, tube = 1},
				tube = {connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1}},
				drop = name.."_1",
			})
			table.insert(pipeworks.tubenodes, cname)
			for xm = 0, 1 do
			for xp = 0, 1 do
			for ym = 0, 1 do
			for yp = 0, 1 do
			for zm = 0, 1 do
			for zp = 0, 1 do
				local tname = xm..xp..ym..yp..zm..zp
				minetest.register_alias(name.."_"..tname, cname)
			end
			end
			end
			end
			end
			end
		end
	end
end

if REGISTER_COMPATIBILITY then
	minetest.register_abm({
		nodenames = {"group:tube_to_update"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local minp = vector.subtract(pos, 1)
			local maxp = vector.add(pos, 1)
			if table.getn(minetest.find_nodes_in_area(minp, maxp, "ignore")) == 0 then
				pipeworks.scan_for_tube_objects(pos)
			end
		end
	})
end

-- now let's actually call that function to get the real work done!

local noctr_textures = {"pipeworks_tube_noctr.png", "pipeworks_tube_noctr.png", "pipeworks_tube_noctr.png",
			"pipeworks_tube_noctr.png", "pipeworks_tube_noctr.png", "pipeworks_tube_noctr.png"}
local plain_textures = {"pipeworks_tube_plain.png", "pipeworks_tube_plain.png", "pipeworks_tube_plain.png",
			"pipeworks_tube_plain.png", "pipeworks_tube_plain.png", "pipeworks_tube_plain.png"}
local end_textures = {"pipeworks_tube_end.png", "pipeworks_tube_end.png", "pipeworks_tube_end.png",
		      "pipeworks_tube_end.png", "pipeworks_tube_end.png", "pipeworks_tube_end.png"}
local short_texture = "pipeworks_tube_short.png"
local inv_texture = "pipeworks_tube_inv.png"

pipeworks.register_tube("pipeworks:tube", "Pneumatic tube segment", plain_textures, noctr_textures, end_textures, short_texture, inv_texture)

if pipeworks.enable_mese_tube then
	local mese_noctr_textures = {"pipeworks_mese_tube_noctr_1.png", "pipeworks_mese_tube_noctr_2.png", "pipeworks_mese_tube_noctr_3.png",
				     "pipeworks_mese_tube_noctr_4.png", "pipeworks_mese_tube_noctr_5.png", "pipeworks_mese_tube_noctr_6.png"}
	local mese_plain_textures = {"pipeworks_mese_tube_plain_1.png", "pipeworks_mese_tube_plain_2.png", "pipeworks_mese_tube_plain_3.png",
				     "pipeworks_mese_tube_plain_4.png", "pipeworks_mese_tube_plain_5.png", "pipeworks_mese_tube_plain_6.png"}
	local mese_end_textures = {"pipeworks_mese_tube_end.png", "pipeworks_mese_tube_end.png", "pipeworks_mese_tube_end.png",
				   "pipeworks_mese_tube_end.png", "pipeworks_mese_tube_end.png", "pipeworks_mese_tube_end.png"}
	local mese_short_texture = "pipeworks_mese_tube_short.png"
	local mese_inv_texture = "pipeworks_mese_tube_inv.png"
	local function update_formspec(pos)
		local meta = minetest.get_meta(pos)
		local old_formspec = meta:get_string("formspec")
		if string.find(old_formspec, "button1") then -- Old version
			local inv = meta:get_inventory()
			for i = 1, 6 do
				for _, stack in ipairs(inv:get_list("line"..i)) do
					minetest.item_drop(stack, "", pos)
				end
			end
		end
		local buttons_formspec = ""
		for i = 0, 5 do
			buttons_formspec = buttons_formspec .. fs_helpers.cycling_button(meta,
				"image_button[7,"..(i)..";1,1", "l"..(i+1).."s",
				{{text="",texture="pipeworks_button_off.png"}, {text="",texture="pipeworks_button_on.png"}})
		end
		meta:set_string("formspec",
			"size[8,11]"..
			"list[current_name;line1;1,0;6,1;]"..
			"list[current_name;line2;1,1;6,1;]"..
			"list[current_name;line3;1,2;6,1;]"..
			"list[current_name;line4;1,3;6,1;]"..
			"list[current_name;line5;1,4;6,1;]"..
			"list[current_name;line6;1,5;6,1;]"..
			"image[0,0;1,1;pipeworks_white.png]"..
			"image[0,1;1,1;pipeworks_black.png]"..
			"image[0,2;1,1;pipeworks_green.png]"..
			"image[0,3;1,1;pipeworks_yellow.png]"..
			"image[0,4;1,1;pipeworks_blue.png]"..
			"image[0,5;1,1;pipeworks_red.png]"..
			buttons_formspec..
			"list[current_player;main;0,7;8,4;]")
	end
	pipeworks.register_tube("pipeworks:mese_tube", "Sorting Pneumatic Tube Segment", mese_plain_textures, mese_noctr_textures,
				mese_end_textures, mese_short_texture, mese_inv_texture,
				{tube = {can_go = function(pos, node, velocity, stack)
						 local tbl, tbln = {}, 0
						 local found, foundn = {}, 0
						 local meta = minetest.get_meta(pos)
						 local inv = meta:get_inventory()
						 local name = stack:get_name()
						 for i, vect in ipairs(pipeworks.meseadjlist) do
							 if meta:get_int("l"..i.."s") == 1 then
								 local invname = "line"..i
								 local is_empty = true
								 for _, st in ipairs(inv:get_list(invname)) do
									 if not st:is_empty() then
										 is_empty = false
										 if st:get_name() == name then
											 foundn = foundn + 1
											 found[foundn] = vect
										 end
									 end
								 end
								 if is_empty then
									 tbln = tbln + 1
									 tbl[tbln] = vect
								 end
							 end
						 end
						 return (foundn > 0) and found or tbl
					end},
				 on_construct = function(pos)
					 local meta = minetest.get_meta(pos)
					 local inv = meta:get_inventory()
					 for i = 1, 6 do
						 meta:set_int("l"..tostring(i).."s", 1)
						 inv:set_size("line"..tostring(i), 6*1)
					 end
				 	 update_formspec(pos)
					 meta:set_string("infotext", "Mese pneumatic tube")
				 end,
				 on_punch = update_formspec,
				 on_receive_fields = function(pos, formname, fields, sender)
					 fs_helpers.on_receive_fields(pos, fields)
					 update_formspec(pos)
				 end,
				 can_dig = function(pos, player)
					update_formspec(pos) -- so non-virtual items would be dropped for old tubes
					return true
				 end,
				 allow_metadata_inventory_put = function(pos, listname, index, stack, player)
				 	update_formspec(pos) -- For old tubes
				 	local inv = minetest.get_meta(pos):get_inventory()
				 	local stack_copy = ItemStack(stack)
				 	stack_copy:set_count(1)
				 	inv:set_stack(listname, index, stack_copy)
				 	return 0
				 end,
				 allow_metadata_inventory_take = function(pos, listname, index, stack, player)
				 	update_formspec(pos) -- For old tubes
				 	local inv = minetest.get_meta(pos):get_inventory()
				 	inv:set_stack(listname, index, ItemStack(""))
				 	return 0
				 end,
				 allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
				 	update_formspec(pos) -- For old tubes
				 	local inv = minetest.get_meta(pos):get_inventory()
				 	inv:set_stack(from_list, from_index, ItemStack(""))
				 	return 0
				 end,
				}, true) -- Must use old tubes, since the textures are rotated with 6d ones
end

if pipeworks.enable_detector_tube then
	local detector_plain_textures = {"pipeworks_detector_tube_plain.png", "pipeworks_detector_tube_plain.png", "pipeworks_detector_tube_plain.png",
					 "pipeworks_detector_tube_plain.png", "pipeworks_detector_tube_plain.png", "pipeworks_detector_tube_plain.png"}
	local detector_inv_texture = "pipeworks_detector_tube_inv.png"
	local detector_tube_step = 2 * tonumber(minetest.setting_get("dedicated_server_step"))
	pipeworks.register_tube("pipeworks:detector_tube_on", "Detecting Pneumatic Tube Segment on (you hacker you)", detector_plain_textures, noctr_textures,
				end_textures, short_texture, detector_inv_texture,
				{tube = {can_go = function(pos, node, velocity, stack)
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
				 mesecons = {receptor = {state = "on",
							 rules = pipeworks.mesecons_rules}},
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
				
				end
	})
	pipeworks.register_tube("pipeworks:detector_tube_off", "Detecting Pneumatic Tube Segment", detector_plain_textures, noctr_textures,
				end_textures, short_texture, detector_inv_texture,
				{tube = {can_go = function(pos, node, velocity, stack)
						local node = minetest.get_node(pos)
						local name = node.name
						local fdir = node.param2
						minetest.set_node(pos,{name = string.gsub(name, "off", "on"), param2 = fdir})
						mesecon.receptor_on(pos, pipeworks.mesecons_rules)
						return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end},
				 groups = {mesecon = 2},
				 mesecons = {receptor = {state = "off",
							 rules = pipeworks.mesecons_rules}}
	})
end

if pipeworks.enable_conductor_tube then
	local conductor_plain_textures = {"pipeworks_conductor_tube_plain.png", "pipeworks_conductor_tube_plain.png", "pipeworks_conductor_tube_plain.png",
					  "pipeworks_conductor_tube_plain.png", "pipeworks_conductor_tube_plain.png", "pipeworks_conductor_tube_plain.png"}
	local conductor_noctr_textures = {"pipeworks_conductor_tube_noctr.png", "pipeworks_conductor_tube_noctr.png", "pipeworks_conductor_tube_noctr.png",
					  "pipeworks_conductor_tube_noctr.png", "pipeworks_conductor_tube_noctr.png", "pipeworks_conductor_tube_noctr.png"}
	local conductor_end_textures = {"pipeworks_conductor_tube_end.png", "pipeworks_conductor_tube_end.png", "pipeworks_conductor_tube_end.png",
					"pipeworks_conductor_tube_end.png", "pipeworks_conductor_tube_end.png", "pipeworks_conductor_tube_end.png"}
	local conductor_short_texture = "pipeworks_conductor_tube_short.png"
	local conductor_inv_texture = "pipeworks_conductor_tube_inv.png"

	local conductor_on_plain_textures = {"pipeworks_conductor_tube_on_plain.png", "pipeworks_conductor_tube_on_plain.png", "pipeworks_conductor_tube_on_plain.png",
					     "pipeworks_conductor_tube_on_plain.png", "pipeworks_conductor_tube_on_plain.png", "pipeworks_conductor_tube_on_plain.png"}
	local conductor_on_noctr_textures = {"pipeworks_conductor_tube_on_noctr.png", "pipeworks_conductor_tube_on_noctr.png", "pipeworks_conductor_tube_on_noctr.png",
					     "pipeworks_conductor_tube_on_noctr.png", "pipeworks_conductor_tube_on_noctr.png", "pipeworks_conductor_tube_on_noctr.png"}
	local conductor_on_end_textures = {"pipeworks_conductor_tube_on_end.png", "pipeworks_conductor_tube_on_end.png", "pipeworks_conductor_tube_on_end.png",
					   "pipeworks_conductor_tube_on_end.png", "pipeworks_conductor_tube_on_end.png", "pipeworks_conductor_tube_on_end.png"}

	pipeworks.register_tube("pipeworks:conductor_tube_off", "Conducting Pneumatic Tube Segment", conductor_plain_textures, conductor_noctr_textures,
				conductor_end_textures, conductor_short_texture, conductor_inv_texture,
				{groups = {mesecon = 2},
				 mesecons = {conductor = {state = "off",
							  rules = pipeworks.mesecons_rules,
							  onstate = "pipeworks:conductor_tube_on_#id"}}
	})

	pipeworks.register_tube("pipeworks:conductor_tube_on", "Conducting Pneumatic Tube Segment on (you hacker you)", conductor_on_plain_textures, conductor_on_noctr_textures,
				conductor_on_end_textures, conductor_short_texture, conductor_inv_texture,
				{groups = {mesecon = 2, not_in_creative_inventory = 1},
				 drop = "pipeworks:conductor_tube_off_1",
				 mesecons = {conductor = {state = "on",
							  rules = pipeworks.mesecons_rules,
							  offstate = "pipeworks:conductor_tube_off_#id"}}
	})
end

if pipeworks.enable_accelerator_tube then
	local accelerator_noctr_textures = {"pipeworks_accelerator_tube_noctr.png", "pipeworks_accelerator_tube_noctr.png", "pipeworks_accelerator_tube_noctr.png",
					    "pipeworks_accelerator_tube_noctr.png", "pipeworks_accelerator_tube_noctr.png", "pipeworks_accelerator_tube_noctr.png"}
	local accelerator_plain_textures = {"pipeworks_accelerator_tube_plain.png" ,"pipeworks_accelerator_tube_plain.png", "pipeworks_accelerator_tube_plain.png",
					    "pipeworks_accelerator_tube_plain.png", "pipeworks_accelerator_tube_plain.png", "pipeworks_accelerator_tube_plain.png"}
	local accelerator_end_textures = {"pipeworks_accelerator_tube_end.png", "pipeworks_accelerator_tube_end.png", "pipeworks_accelerator_tube_end.png",
					  "pipeworks_accelerator_tube_end.png", "pipeworks_accelerator_tube_end.png", "pipeworks_accelerator_tube_end.png"}
	local accelerator_short_texture = "pipeworks_accelerator_tube_short.png"
	local accelerator_inv_texture = "pipeworks_accelerator_tube_inv.png"

	pipeworks.register_tube("pipeworks:accelerator_tube", "Accelerating Pneumatic Tube Segment", accelerator_plain_textures,
				accelerator_noctr_textures, accelerator_end_textures, accelerator_short_texture, accelerator_inv_texture,
				{tube = {can_go = function(pos, node, velocity, stack)
						 velocity.speed = velocity.speed+1
						 return pipeworks.notvel(pipeworks.meseadjlist, velocity)
					end}
	})
end

if pipeworks.enable_crossing_tube then
	local crossing_noctr_textures = {"pipeworks_crossing_tube_noctr.png", "pipeworks_crossing_tube_noctr.png", "pipeworks_crossing_tube_noctr.png",
					 "pipeworks_crossing_tube_noctr.png", "pipeworks_crossing_tube_noctr.png", "pipeworks_crossing_tube_noctr.png"}
	local crossing_plain_textures = {"pipeworks_crossing_tube_plain.png" ,"pipeworks_crossing_tube_plain.png", "pipeworks_crossing_tube_plain.png",
					 "pipeworks_crossing_tube_plain.png", "pipeworks_crossing_tube_plain.png", "pipeworks_crossing_tube_plain.png"}
	local crossing_end_textures = {"pipeworks_crossing_tube_end.png", "pipeworks_crossing_tube_end.png", "pipeworks_crossing_tube_end.png",
				       "pipeworks_crossing_tube_end.png", "pipeworks_crossing_tube_end.png", "pipeworks_crossing_tube_end.png"}
	local crossing_short_texture = "pipeworks_crossing_tube_short.png"
	local crossing_inv_texture = "pipeworks_crossing_tube_inv.png"

	pipeworks.register_tube("pipeworks:crossing_tube", "Crossing Pneumatic Tube Segment", crossing_plain_textures,
				crossing_noctr_textures, crossing_end_textures, crossing_short_texture, crossing_inv_texture,
				{tube = {can_go = function(pos, node, velocity, stack)
						 return {velocity}
					end}
	})
end

if pipeworks.enable_sand_tube then
	local sand_noctr_textures = {"pipeworks_sand_tube_noctr.png", "pipeworks_sand_tube_noctr.png", "pipeworks_sand_tube_noctr.png",
				     "pipeworks_sand_tube_noctr.png", "pipeworks_sand_tube_noctr.png", "pipeworks_sand_tube_noctr.png"}
	local sand_plain_textures = {"pipeworks_sand_tube_plain.png", "pipeworks_sand_tube_plain.png", "pipeworks_sand_tube_plain.png",
				     "pipeworks_sand_tube_plain.png", "pipeworks_sand_tube_plain.png", "pipeworks_sand_tube_plain.png"}
	local sand_end_textures = {"pipeworks_sand_tube_end.png", "pipeworks_sand_tube_end.png", "pipeworks_sand_tube_end.png",
				   "pipeworks_sand_tube_end.png", "pipeworks_sand_tube_end.png", "pipeworks_sand_tube_end.png"}
	local sand_short_texture = "pipeworks_sand_tube_short.png"
	local sand_inv_texture = "pipeworks_sand_tube_inv.png"

	pipeworks.register_tube("pipeworks:sand_tube", "Vacuuming Pneumatic Tube Segment", sand_plain_textures, sand_noctr_textures, sand_end_textures,
				sand_short_texture, sand_inv_texture,
				{groups = {sand_tube = 1}})

	minetest.register_abm({nodenames = {"group:sand_tube"},
			       interval = 1,
			       chance = 1,
			       action = function(pos, node, active_object_count, active_object_count_wider)
				       for _, object in ipairs(minetest.get_objects_inside_radius(pos, 2)) do
					       if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
						       if object:get_luaentity().itemstring ~= "" then
							       pipeworks.tube_inject_item(pos, pos, vector.new(0, 0, 0), object:get_luaentity().itemstring)
						       end
						       object:get_luaentity().itemstring = ""
						       object:remove()
					       end
				       end
			       end
	})
end

if pipeworks.enable_mese_sand_tube then
	local mese_sand_noctr_textures = {"pipeworks_mese_sand_tube_noctr.png", "pipeworks_mese_sand_tube_noctr.png", "pipeworks_mese_sand_tube_noctr.png",
					  "pipeworks_mese_sand_tube_noctr.png", "pipeworks_mese_sand_tube_noctr.png", "pipeworks_mese_sand_tube_noctr.png"}
	local mese_sand_plain_textures = {"pipeworks_mese_sand_tube_plain.png", "pipeworks_mese_sand_tube_plain.png", "pipeworks_mese_sand_tube_plain.png",
					  "pipeworks_mese_sand_tube_plain.png", "pipeworks_mese_sand_tube_plain.png", "pipeworks_mese_sand_tube_plain.png"}
	local mese_sand_end_textures = {"pipeworks_mese_sand_tube_end.png", "pipeworks_mese_sand_tube_end.png", "pipeworks_mese_sand_tube_end.png",
					"pipeworks_mese_sand_tube_end.png", "pipeworks_mese_sand_tube_end.png", "pipeworks_mese_sand_tube_end.png"}
	local mese_sand_short_texture = "pipeworks_mese_sand_tube_short.png"
	local mese_sand_inv_texture = "pipeworks_mese_sand_tube_inv.png"

	pipeworks.register_tube("pipeworks:mese_sand_tube", "Adjustable Vacuuming Pneumatic Tube Segment", mese_sand_plain_textures, mese_sand_noctr_textures,
				mese_sand_end_textures, mese_sand_short_texture,mese_sand_inv_texture,
				{groups = {mese_sand_tube = 1},
				 on_construct = function(pos)
					 local meta = minetest.get_meta(pos)
					 meta:set_int("dist", 0)
					 meta:set_string("formspec",
							 "size[2,1]"..
								 "field[.5,.5;1.5,1;dist;distance;${dist}]")
					 meta:set_string("infotext", "Adjustable Vacuuming Pneumatic Tube Segment")
				 end,
				 on_receive_fields = function(pos,formname,fields,sender)
					 local meta = minetest.get_meta(pos)
					 local dist
					 _, dist = pcall(tonumber, fields.dist)
					 if dist and 0 <= dist and dist <= 8 then meta:set_int("dist", dist) end
				 end,
	})

	local function get_objects_with_square_radius(pos, rad)
		rad = rad + .5;
		local objs = {}
		for _,object in ipairs(minetest.get_objects_inside_radius(pos, math.sqrt(3)*rad)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
				local opos = object:getpos()
				if pos.x - rad <= opos.x and opos.x <= pos.x + rad and pos.y - rad <= opos.y and opos.y <= pos.y + rad and pos.z - rad <= opos.z and opos.z <= pos.z + rad then
					objs[#objs + 1] = object
				end
			end
		end
		return objs
	end

	minetest.register_abm({nodenames = {"group:mese_sand_tube"},
			       interval = 1,
			       chance = 1,
			       action = function(pos, node, active_object_count, active_object_count_wider)
				       for _,object in ipairs(get_objects_with_square_radius(pos, minetest.get_meta(pos):get_int("dist"))) do
					       if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
						       if object:get_luaentity().itemstring ~= "" then
							       pipeworks.tube_inject_item(pos, pos, vector.new(0, 0, 0), object:get_luaentity().itemstring)
						       end
						       object:get_luaentity().itemstring = ""
						       object:remove()
					       end
				       end
			       end
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
		legacy_facedir_simple = true,
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
	})
end

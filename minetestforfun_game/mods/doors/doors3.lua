doors3 = {}


function doors3.get_pos(pos, dir, p1, b)
	local pos2 = {x=pos.x, y=pos.y, z=pos.z}
	if b == 0 then
		if p1 == 1 then
			if dir == 1 then
				pos2.z=pos2.z-1
			elseif dir == 2 then
				pos2.x=pos2.x-1
			elseif dir == 3 then
				pos2.z=pos2.z+1
			else
				pos2.x=pos2.x+1
			end
		else
			if dir == 1 then
				pos2.x=pos2.x+1
			elseif dir == 2 then
				pos2.z=pos2.z-1
			elseif dir == 3 then
				pos2.x=pos2.x-1
			else
				pos2.z=pos2.z+1
			end
		end
	else
		if p1 == 1 then
			if dir == 1 then
				pos2.x=pos2.x+1
			elseif dir == 2 then
				pos2.z=pos2.z-1
			elseif dir == 3 then
				pos2.x=pos2.x-1
			else
				pos2.z=pos2.z+1
			end
		else
			if dir == 1 then
				pos2.z=pos2.z+1
			elseif dir == 2 then
				pos2.x=pos2.x+1
			elseif dir == 3 then
				pos2.z=pos2.z-1
			else
				pos2.x=pos2.x-1
			end
		end
	end
	return pos2
end



-- Registers a door
function doors3.register_door(name, def)
	def.groups.not_in_creative_inventory = 1

	local box = {{-0.5, -0.5, -0.5, 0.5, 0.5, -0.5+1.5/16}}

	if not def.node_box_bottom then
		def.node_box_bottom = box
	end
	if not def.node_box_middle then
		def.node_box_middle = box
	end
	if not def.node_box_top then
		def.node_box_top = box
	end
	if not def.selection_box_bottom then
		def.selection_box_bottom= box
	end
	if not def.selection_box_middle then
		def.selection_box_middle = box
	end
	if not def.selection_box_top then
		def.selection_box_top = box
	end

	if not def.sound_close_door then
		def.sound_close_door = "doors_door_close"
	end
	if not def.sound_open_door then
		def.sound_open_door = "doors_door_open"
	end


	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,

		on_place = function(itemstack, placer, pointed_thing)
			if not pointed_thing.type == "node" then
				return itemstack
			end

			local ptu = pointed_thing.under
			local nu = minetest.get_node(ptu)
			if minetest.registered_nodes[nu.name].on_rightclick then
				return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
			end

			local pt = pointed_thing.above
			local pt1 = {x=pt.x, y=pt.y+1, z=pt.z}
			local pt2 = {x=pt.x, y=pt.y+2, z=pt.z}
			if
				not minetest.registered_nodes[minetest.get_node(pt).name].buildable_to or
				not minetest.registered_nodes[minetest.get_node(pt1).name].buildable_to or
				not minetest.registered_nodes[minetest.get_node(pt2).name].buildable_to or
				not placer or
				not placer:is_player()
			then
				return itemstack
			end

			if minetest.is_protected(pt, placer:get_player_name()) or minetest.is_protected(pt2, placer:get_player_name()) then
				minetest.record_protection_violation(pt, placer:get_player_name())
				return itemstack
			end

			local p2 = minetest.dir_to_facedir(placer:get_look_dir())
			local pt3 = {x=pt.x, y=pt.y, z=pt.z}
			if p2 == 0 then
				pt3.x = pt3.x-1
			elseif p2 == 1 then
				pt3.z = pt3.z+1
			elseif p2 == 2 then
				pt3.x = pt3.x+1
			elseif p2 == 3 then
				pt3.z = pt3.z-1
			end
			if minetest.get_item_group(minetest.get_node(pt3).name, "door") == 0 then
				minetest.set_node(pt, {name=name.."_b_1", param2=p2})
				minetest.set_node(pt1, {name=name.."_m_1", param2=p2})
				minetest.set_node(pt2, {name=name.."_t_1", param2=p2})
			else
				minetest.set_node(pt, {name=name.."_b_2", param2=p2})
				minetest.set_node(pt1, {name=name.."_m_2", param2=p2})
				minetest.set_node(pt2, {name=name.."_t_2", param2=p2})
				minetest.get_meta(pt):set_int("right", 1)
				minetest.get_meta(pt1):set_int("right", 1)
				minetest.get_meta(pt2):set_int("right", 1)
			end

			if def.only_placer_can_open then
				local pn = placer:get_player_name()
				local meta = minetest.get_meta(pt)
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by "..pn)
				meta = minetest.get_meta(pt1)
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by "..pn)
				meta = minetest.get_meta(pt2)
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by "..pn)
			end

			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
	})

	local tt = def.tiles_top
	local tm = def.tiles_middle
	local tb = def.tiles_bottom

	local function after_dig_node(pos, letter, name, num, digger)
		local p
		if letter == "b" then -- bottom
			p = { {y=1, l="m"}, {y=2, l="t"} }
		elseif letter == "m" then -- middle
			p = { {y=-1, l="b"}, {y=1, l="t"} }
		else -- top
			p = { {y=-2, l="b"}, {y=-1, l="m"} }
		end
		for _,t in pairs(p) do
			local pos1 = {x=pos.x, y=pos.y+t["y"], z=pos.z}
			local node = minetest.get_node(pos1)
			if node.name == name.."_"..t["l"].."_"..num then
				minetest.node_dig(pos1, node, digger)
			end
		end
	end

	local function check_and_blast(pos, name)
		local node = minetest.get_node(pos)
		if node.name == name then
			minetest.remove_node(pos)
		end
	end

	local function make_on_blast(base_name, letter, num)
		if def.only_placer_can_open then
			return function() end
		else
			return function(pos, intensity)
				local p
				if letter == "b" then -- bottom
					p = { {y=1, l="m"}, {y=2, l="t"} }
				elseif letter == "m" then -- middle
					p = { {y=-1, l="b"}, {y=1, l="t"} }
				else -- top
					p = { {y=-2, l="b"}, {y=-1, l="m"} }
				end
				for _,t in pairs(p) do
					check_and_blast({x=pos.x, y=pos.y+t["y"], z=pos.z}, base_name.."_"..t["l"].."_"..num)
				end
			end
		end
	end


	local function on_rightclick(pos, letter, name, oldnum, params, clicker, oldparam2)
		local p
		if letter == "b" then -- bottom
			p = { {y=0, l="b"}, {y=1, l="m"}, {y=2, l="t"} }
		elseif letter == "m" then -- middle
			p = { {y=-1, l="b"}, {y=0, l="m"}, {y=1, l="t"} }
		else -- top
			p = { {y=-2, l="b"}, {y=-1, l="m"}, {y=0, l="t"} }
		end

		local newnum
		if oldnum == 1 then
			newnum = 2
		else
			newnum = 1
		end

		for _,t in pairs(p) do
			local pos1 = {x=pos.x, y=pos.y+t["y"], z=pos.z}
			if minetest.get_node(pos1).name == name.."_"..t["l"].."_"..oldnum then
				local p2 = minetest.get_node(pos1).param2
				p2 = params[p2+1]
				minetest.swap_node(pos1, {name=name.."_"..t["l"].."_"..newnum, param2=p2})
			end
		end

		local snd_1 = def.sound_close_door
		local snd_2 = def.sound_open_door
		if params[1] == 3 then
			snd_1 = def.sound_open_door
			snd_2 = def.sound_close_door
		end
		local b = minetest.get_meta(pos):get_int("right")

		local pos2 = doors3.get_pos(pos, oldparam2, params[1], b)
		local node = minetest.get_node_or_nil(pos2)
		if node and node.name and node.name == name.."_"..letter.."_"..newnum then
			if minetest.get_meta(pos2):get_int("right") ~= b then
				if minetest.registered_nodes[node.name].on_rightclick then
					return minetest.registered_nodes[node.name].on_rightclick(pos2, node, clicker)
				end
			end
		end

		--if double doors, only 2eme play sound
		if b ~= 0 then
			minetest.sound_play(snd_1, {pos = pos, gain = 0.3, max_hear_distance = 10})
		else
			minetest.sound_play(snd_2, {pos = pos, gain = 0.3, max_hear_distance = 10})
		end
	end


	local function check_player_priv(pos, player)
		if not def.only_placer_can_open then
			return true
		end
		local meta = minetest.get_meta(pos)
		local pn = player:get_player_name()
		return meta:get_string("doors_owner") == pn
	end


	local function on_rotate(pos, node, dir, user, name, num, mode, new_param2)
		if not check_player_priv(pos, user) then
			return false
		end
		if mode ~= screwdriver.ROTATE_FACE then
			return false
		end

		local p
		if dir == 0 then -- bottom
			p = { {y=0, l="b"}, {y=1, l="m"}, {y=2, l="t"} }
		elseif dir == 1 then -- middle
			p = { {y=-1, l="b"}, {y=0, l="m"}, {y=1, l="t"} }
		else -- top
			p = { {y=-2, l="b"}, {y=-1, l="m"}, {y=0, l="t"} }
		end

		for _,t in pairs(p) do
			local pos1 = {x=pos.x, y=pos.y+t["y"], z=pos.z}
			if not minetest.get_node(pos1).name == name.."_"..t["l"].."_"..num then
				return false
			end
			if minetest.is_protected(pos1, user:get_player_name()) then
				minetest.record_protection_violation(pos4, user:get_player_name())
				return false
			end
		end

		for _,t in pairs(p) do
			local pos1 = {x=pos.x, y=pos.y+t["y"], z=pos.z}
			local node2 = minetest.get_node(pos1)
			node2.param2 = (node2.param2 + 1) % 4
			minetest.swap_node(pos1, node2)
		end
		return true
	end


	minetest.register_node(name.."_b_1", {
		tiles = {tb[2], tb[2], tb[2], tb[2], tb[1], tb[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = name,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "b", name, 1, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "b", name, 1, {1,2,3,0}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 0, user, name, 1, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "b", 1)
	})


	minetest.register_node(name.."_m_1", {
		tiles = {tm[2], tm[2], tm[2], tm[2], tm[1], tm[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_middle
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_middle
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "m", name, 1, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "m", name, 1, {1,2,3,0}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 1, user, name, 1, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "m", 1)
	})



	minetest.register_node(name.."_t_1", {
		tiles = {tt[2], tt[2], tt[2], tt[2], tt[1], tt[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "t", name, 1, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "t", name, 1, {1,2,3,0}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 2, user, name, 1, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "t", 1)
	})



	minetest.register_node(name.."_b_2", {
		tiles = {tb[2], tb[2], tb[2], tb[2], tb[1].."^[transformfx", tb[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = name,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "b", name, 2, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "b", name, 2, {3,0,1,2}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 0, user, name, 2, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "b", 2)
	})


	minetest.register_node(name.."_m_2", {
		tiles = {tm[2], tm[2], tm[2], tm[2], tm[1].."^[transformfx", tm[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_middle
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_middle
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "m", name, 2, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "m", name, 2, {3,0,1,2}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 1, user, name, 2, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "m", 2)
	})



	minetest.register_node(name.."_t_2", {
		tiles = {tt[2], tt[2], tt[2], tt[2], tt[1].."^[transformfx", tt[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
		groups = def.groups,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			after_dig_node(pos, "t", name, 2, digger)
		end,

		on_rightclick = function(pos, node, clicker)
			if check_player_priv(pos, clicker) then
				on_rightclick(pos, "t", name, 2, {3,0,1,2}, clicker, node.param2)
			end
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			return on_rotate(pos, node, 2, user, name, 2, mode)
		end,

		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
		on_blast = make_on_blast(name, "t", 2)
	})

end

doors3.register_door("doors:door3_wood", {
	description = "Wooden Door 3",
	inventory_image = "doors3_wood.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
	tiles_bottom = {"doors3_wood_b.png", "doors3_brown.png"},
	tiles_middle = {"doors3_wood_m.png", "doors3_brown.png"},
	tiles_top = {"doors3_wood_t.png", "doors3_brown.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

minetest.register_craft({
	output = "doors:door3_wood",
	recipe = {
		{"", "", ""},
		{"", "doors:door_wood", ""},
		{"", "doors:door_wood", ""}
	}
})

doors3.register_door("doors:door3_steel", {
	description = "Steel Door 3",
	inventory_image = "doors3_steel_inv.png",
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1},
	tiles_bottom = {"doors3_steel_b.png", "doors_grey.png"},
	tiles_middle = {"doors3_steel_m.png", "doors_grey.png"},
	tiles_top = {"doors3_steel_t.png", "doors_grey.png"},
	only_placer_can_open = true,
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

minetest.register_craft({
	output = "doors:door3_steel",
	recipe = {
		{"", "", ""},
		{"", "doors:door_steel", ""},
		{"", "doors:door_steel", ""}
	}
})

doors3.register_door("doors:door3_glass", {
	description = "Glass Door 3",
	inventory_image = "doors3_glass_inv.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_glass_b.png", "doors_glass_side.png"},
	tiles_middle = {"doors_glass_a.png", "doors_glass_side.png"},
	tiles_top = {"doors_glass_a.png", "doors_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door3_glass",
	recipe = {
		{"", "", ""},
		{"", "doors:door_glass", ""},
		{"", "doors:door_glass", ""}
	}
})


doors3.register_door("doors:door3_obsidian_glass", {
	description = "Obsidian Glass Door 3",
	inventory_image = "doors3_obsidian_glass_inv.png",
	groups = {snappy=1,cracky=1,oddly_breakable_by_hand=3,door=1},
	tiles_bottom = {"doors_obsidian_glass_b.png", "doors_obsidian_glass_side.png"},
	tiles_middle = {"doors_obsidian_glass_a.png", "doors_obsidian_glass_side.png"},
	tiles_top = {"doors_obsidian_glass_a.png", "doors_obsidian_glass_side.png"},
	sounds = default.node_sound_glass_defaults(),
	sunlight = true,
})

minetest.register_craft({
	output = "doors:door3_obsidian_glass",
	recipe = {
		{"", "", ""},
		{"", "doors:door_obsidian_glass", ""},
		{"", "doors:door_obsidian_glass", ""}
	}
})

-- From BFD: Cherry planks doors
doors3.register_door("doors:door3_cherry", {
	description = "Cherry Door 3",
	inventory_image = "doors3_wood_cherry_inv.png",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
	tiles_bottom = {"doors_wood_cherry_b.png", "default_wood_cherry_planks.png"},
	tiles_middle = {"doors_wood_cherry_a.png", "default_wood_cherry_planks.png"},
	tiles_top = {"doors_wood_cherry_a.png", "default_wood_cherry_planks.png"},
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

minetest.register_craft({
	output = "doors:door3_cherry",
	recipe = {
		{"", "", ""},
		{"", "doors:door_cherry", ""},
		{"", "doors:door_cherry", ""}
	}
})

doors3.register_door("doors:door3_prison", {
	description = "Prison Door 3",
	inventory_image = "doors3_prison_inv.png",
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1},
	tiles_bottom = {"doors_prison_b.png", "doors_black.png"},
	tiles_middle = {"doors_prison_t.png", "doors_black.png"},
	tiles_top = {"doors_prison_t.png", "doors_black.png"},
	only_placer_can_open = true,
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

minetest.register_craft({
	output = "doors:door3_prison",
	recipe = {
		{"", "", ""},
		{"", "doors:door_prison", ""},
		{"", "doors:door_prison", ""}
	}
})

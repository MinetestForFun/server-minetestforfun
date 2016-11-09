local _doors = {}

_doors.registered_doors3 = {} --MFF doors3

-- door 3 nodes
function doors.register3(name, def)
	if not name:find(":") then
		name = "doors:" .. name
	end

	-- replace old doors of this type automatically
	minetest.register_lbm({
		name = ":doors:replace_" .. name:gsub(":", "_"),
		nodenames = {name.."_b_1", name.."_b_2"},
		action = function(pos, node)
			local l = tonumber(node.name:sub(-1))
			local meta = minetest.get_meta(pos)
			local h = meta:get_int("right") + 1
			local p2 = node.param2
			local replace = {
				{ { type = "a", state = 0 }, { type = "a", state = 3 } },
				{ { type = "b", state = 1 }, { type = "b", state = 2 } }
			}
			local new = replace[l][h]
			-- retain infotext and doors_owner fields
			minetest.swap_node(pos, {name = name .. "_" .. new.type, param2 = p2})
			meta:set_int("state", new.state)
			-- properly place doors:hidden at the right spot
			local p3 = p2
			if new.state >= 2 then
				p3 = (p3 + 3) % 4
			end
			if new.state % 2 == 1 then
				if new.state >= 2 then
					p3 = (p3 + 1) % 4
				else
					p3 = (p3 + 3) % 4
				end
			end
			-- wipe meta on top node as it's unused
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},
				{name = "doors:hidden", param2 = p3})
			minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},
				{name = "doors:hidden", param2 = p3})
		end
	})

	minetest.register_craftitem(":" .. name, {
		description = def.description,
		inventory_image = def.inventory_image,

		on_place = function(itemstack, placer, pointed_thing)
			local pos = nil

			if not pointed_thing.type == "node" then
				return itemstack
			end

			local node = minetest.get_node(pointed_thing.under)
			local pdef = minetest.registered_nodes[node.name]
			if pdef and pdef.on_rightclick then
				return pdef.on_rightclick(pointed_thing.under,
						node, placer, itemstack, pointed_thing)
			end

			if pdef and pdef.buildable_to then
				pos = pointed_thing.under
			else
				pos = pointed_thing.above
				node = minetest.get_node(pos)
				pdef = minetest.registered_nodes[node.name]
				if not pdef or not pdef.buildable_to then
					return itemstack
				end
			end

			local above = { x = pos.x, y = pos.y + 1, z = pos.z }
			if not minetest.registered_nodes[minetest.get_node(above).name].buildable_to then
				return itemstack
			end

			local above2 = { x = pos.x, y = pos.y + 2, z = pos.z }
			if not minetest.registered_nodes[minetest.get_node(above2).name].buildable_to then
				return itemstack
			end

			local pn = placer:get_player_name()
			if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) or minetest.is_protected(above2, pn) then
				return itemstack
			end

			local dir = minetest.dir_to_facedir(placer:get_look_dir())

			local ref = {
				{ x = -1, y = 0, z = 0 },
				{ x = 0, y = 0, z = 1 },
				{ x = 1, y = 0, z = 0 },
				{ x = 0, y = 0, z = -1 },
			}

			local aside = {
				x = pos.x + ref[dir + 1].x,
				y = pos.y + ref[dir + 1].y,
				z = pos.z + ref[dir + 1].z,
			}

			local state = 0
			if minetest.get_item_group(minetest.get_node(aside).name, "door") == 1 then
				state = state + 2
				minetest.set_node(pos, {name = name .. "_b", param2 = dir})
			else
				minetest.set_node(pos, {name = name .. "_a", param2 = dir})
			end
			minetest.set_node(above, { name = "doors:hidden" })
			minetest.set_node(above2, { name = "doors:hidden" })

			local meta = minetest.get_meta(pos)
			meta:set_int("state", state)

			if def.protected then
				local pn = placer:get_player_name()
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by " .. pn)
			end

			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end

			on_place_node(pos, minetest.get_node(pos), placer, node, itemstack, pointed_thing)

			return itemstack
		end
	})

	local can_dig = function(pos, digger)
		if not def.protected then
			return true
		end
		if minetest.check_player_privs(digger:get_player_name(), {protection_bypass = true}) then
			return true
		end
		local meta = minetest.get_meta(pos)
		local name = ""
		if digger then
			name = digger:get_player_name()
		end
		return meta:get_string("doors_owner") == name
	end

	if not def.sounds then
		def.sounds = default.node_sound_wood_defaults()
	end

	if not def.sound_open then
		def.sound_open = "doors_door_open"
	end

	if not def.sound_close then
		def.sound_close = "doors_door_close"
	end

	def.groups.not_in_creative_inventory = 1
	def.groups.door = 1
	def.drop = name
	def.door = {
		name = name,
		sounds = { def.sound_close, def.sound_open },
	}

	def.on_rightclick = function(pos, node, clicker)
		_doors.door_toggle(pos, clicker)
	end
	def.after_dig_node = function(pos, node, meta, digger)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
		nodeupdate({x = pos.x, y = pos.y + 2, z = pos.z})
	end
	def.can_dig = function(pos, player)
		return can_dig(pos, player)
	end
	def.on_rotate = function(pos, node, user, mode, new_param2)
		return false
	end

	if def.protected then
		def.on_blast = function() end
	else
		def.on_blast = function(pos, intensity)
			minetest.remove_node(pos)
			-- hidden node doesn't get blasted away.
			minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
			minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
			return {name}
		end
	end

	def.on_destruct = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
	end

	minetest.register_node(":" .. name .. "_a", {
		description = def.description,
		visual = "mesh",
		mesh = "door3_a.obj",
		tiles = def.tiles,
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = true,
		is_ground_content = false,
		buildable_to = false,
		drop = def.drop,
		groups = def.groups,
		sounds = def.sounds,
		door = def.door,
		on_rightclick = def.on_rightclick,
		after_dig_node = def.after_dig_node,
		can_dig = def.can_dig,
		on_rotate = def.on_rotate,
		on_blast = def.on_blast,
		on_destruct = def.on_destruct,
		selection_box = {
			type = "fixed",
			fixed = { -1/2,-1/2,-1/2,1/2,2.5,-6/16}
		},
		collision_box = {
			type = "fixed",
			fixed = { -1/2,-1/2,-1/2,1/2,2.5,-6/16}
		},
	})

	minetest.register_node(":" .. name .. "_b", {
		description = def.description,
		visual = "mesh",
		mesh = "door3_b.obj",
		tiles = def.tiles,
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = true,
		is_ground_content = false,
		buildable_to = false,
		drop = def.drop,
		groups = def.groups,
		sounds = def.sounds,
		door = def.door,
		on_rightclick = def.on_rightclick,
		after_dig_node = def.after_dig_node,
		can_dig = def.can_dig,
		on_rotate = def.on_rotate,
		on_blast = def.on_blast,
		on_destruct = def.on_destruct,
		selection_box = {
			type = "fixed",
			fixed = { -1/2,-1/2,-1/2,1/2,2.5,-6/16}
		},
		collision_box = {
			type = "fixed",
			fixed = { -1/2,-1/2,-1/2,1/2,2.5,-6/16}
		},
	})

	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe,
		})
	end

	_doors.registered_doors3[name .. "_a"] = true
	_doors.registered_doors3[name .. "_b"] = true
end

doors.register3("door3_wood", {
	tiles = {{ name = "doors_door3_wood.png", backface_culling = true }},
	description = "Wooden Door 3 Nodes",
	inventory_image = "doors3_item_wood.png",
	groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{"", "", ""},
		{"", "doors:door_wood", ""},
		{"", "doors:door_wood", ""},
	}
})

doors.register3("door3_steel", {
	tiles = {{ name = "doors_door3_steel.png", backface_culling = true }},
	description = "Steel Door 3 Nodes",
	inventory_image = "doors3_item_steel.png",
	protected = true,
	groups = { snappy = 1, bendy = 2, cracky = 1, melty = 2, level = 2 },
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{"", "", ""},
		{"", "doors:door_steel", ""},
		{"", "doors:door_steel", ""},
	}
})

doors.register3("door3_glass", {
	tiles = { "doors_door3_glass.png"},
	description = "Glass Door 3 Nodes",
	inventory_image = "doors3_item_glass.png",
	groups = { snappy=1, cracky=1, oddly_breakable_by_hand=3 },
	sounds = default.node_sound_glass_defaults(),
	recipe = {
		{"", "", ""},
		{"", "doors:door_glass", ""},
		{"", "doors:door_glass", ""},
	}
})

doors.register3("door3_obsidian_glass", {
	tiles = { "doors_door3_obsidian_glass.png" },
	description = "Obsidian Glass Door 3 Nodes",
	inventory_image = "doors3_item_obsidian_glass.png",
	groups = { snappy=1, cracky=1, oddly_breakable_by_hand=3 },
	sounds = default.node_sound_glass_defaults(),
	recipe = {
		{"", "", ""},
		{"", "doors:door_obsidian_glass", ""},
		{"", "doors:door_obsidian_glass", ""},
	},
})


-- From BFD: Cherry planks doors
doors.register3("door3_cherry", {
	tiles = { "doors_door3_cherry.png" },
	description = "Cherry Door 3 Nodes",
	inventory_image = "doors3_item_cherry.png",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"", "", ""},
		{"", "doors:door_cherry", ""},
		{"", "doors:door_cherry", ""},
	},
})

-- doors prison MFF
doors.register3("door3_prison", {
	tiles = { "doors_door3_prison.png" },
	description = "Prison Door 3 Nodes",
	inventory_image = "doors3_item_prison.png",
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1},
	protected = true,
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{"", "", ""},
		{"", "doors:door_prison", ""},
		{"", "doors:door_prison", ""},
	}
})

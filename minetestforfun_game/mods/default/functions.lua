-- mods/default/functions.lua

--
-- Sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.6}
	table.dig = table.dig or
			{name = "default_hard_footstep", gain = 0.7}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_hard_footstep", gain = 0.8}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.6}
	table.dig = table.dig or
			{name = "default_hard_footstep", gain = 0.7}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_hard_footstep", gain = 0.8}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_metal_footstep", gain = 0.575}
	table.dig = table.dig or
			{name = "default_metal_footstep", gain = 0.65}
	table.dug = table.dug or
			{name = "default_metal_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_metal_footstep", gain = 0.8}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_dirt_footstep", gain = 0.8}
	table.dig = table.dig or
			{name = "default_dirt_footstep", gain = 0.9}
	table.dug = table.dug or
			{name = "default_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_dirt_footstep", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_gravel_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_dirt_footstep", gain = 0.8}
	table.dig = table.dig or
			{name = "default_dirt_footstep", gain = 0.9}
	table.dug = table.dug or
			{name = "default_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_dirt_footstep", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_sand_footstep", gain = 0.6}
	table.dig = table.dig or
			{name = "default_sand_footstep", gain = 0.7}
	table.dug = table.dug or
			{name = "default_sand_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_sand_footstep", gain = 0.8}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_wood_footstep", gain = 0.625}
	table.dig = table.dig or
			{name = "default_wood_footstep", gain = 0.7}
	table.dug = table.dug or
			{name = "default_wood_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_wood_footstep", gain = 0.8}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_grass_footstep", gain = 0.6}
	table.dig = table.dig or
			{name = "default_grass_footstep", gain = 0.7}
	table.dug = table.dug or
			{name = "default_snow_footstep", gain = 0.8}
	table.place = table.place or
			{name = "default_snow_footstep", gain = 0.8}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.55}
	table.dig = table.dig or
			{name = "default_hard_footstep", gain = 0.65}
	table.dug = table.dug or
			{name = "default_break_glass", gain = 0.8}
	table.place = table.place or
			{name = "default_hard_footstep", gain = 0.75}
	default.node_sound_defaults(table)
	return table
end


--
-- Lavacooling
--

local function cool_wf_vm(pos, node1, node2)
	local t1 = os.clock()
	local minp = vector.subtract(pos, 10)
	local maxp = vector.add(pos, 10)
	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map(minp, maxp)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()

	local stone = minetest.get_content_id(node2)
	local lava = minetest.get_content_id(node1)

	for i in area:iterp(minp, maxp) do
		local p = area:position(i)
		if nodes[i] == lava and minetest.find_node_near(p, 1, {"group:water"}) then
			nodes[i] = stone
		end
	end

	manip:set_data(nodes)
	manip:write_to_map()
	-- minetest.log("action", "Lava cooling happened at (" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ").")
	local t1 = os.clock()
	manip:update_map()
	-- minetest.log("action", string.format("Lava cooling updated the map after ca. %.2fs.", os.clock() - t1))
end

local del1 = 0
local count = 0

default.cool_lava_source = function(pos)
	local del2 = tonumber(os.clock())
	if del2-del1 < 0.1
	and count > 1 then
		cool_wf_vm(pos, "default:lava_source", "default:obsidian_cooled")
		count = 0
	else
		minetest.set_node(pos, {name = "default:obsidian_cooled"})
		minetest.sound_play("default_cool_lava", {pos = pos, gain = 0.2})
		if del2-del1 < 0.1 then
			count = count + 1
		end
	end
	del1 = del2
end

default.cool_lava_flowing = function(pos)
	local del2 = tonumber(os.clock())
	if del2-del1 < 0.1
	and count > 1 then
		cool_wf_vm(pos, "default:lava_flowing", "default:cobble_cooled")
		count = 0
	else
		minetest.set_node(pos, {name = "default:cobble_cooled"})
		minetest.sound_play("default_cool_lava", {pos = pos, gain = 0.2})
		if del2-del1 < 0.1 then
			count = count + 1
		end
	end
	del1 = del2
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 2,
	chance = 1,
	action = function(...)
		default.cool_lava_flowing(...)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water"},
	interval = 2,
	chance = 1,
	action = function(...)
		default.cool_lava_source(...)
	end,
})


--
-- Papyrus and cactus growing
--

-- wrapping the functions in abm action is necessary to make overriding them possible

function default.grow_cactus(pos, node)
	if node.param2 >= 4 then
		return
	end
	pos.y = pos.y - 1
	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "default:cactus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "default:cactus"})
	return true
end

function default.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	if name ~= "default:dirt_with_grass" and name ~= "default:dirt" then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "default:papyrus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	minetest.set_node(pos, {name = "default:papyrus"})
	return true
end

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 60,
	chance = 25,
	action = function(...)
		default.grow_cactus(...)
	end
})

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_snow", "default:sand", "default:desert_sand"},
	interval = 60,
	chance = 25,
	action = function(...)
		default.grow_papyrus(...)
	end
})


--
-- dig upwards
--

function default.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end


--
-- Leafdecay
--

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
	local finds_per_second = 5000
	default.leafdecay_trunk_find_allow_accumulator =
			math.floor(dtime * finds_per_second)
end)

default.after_place_leaves = function(pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node(pos)
	node.param2 = 1
	minetest.set_node(pos, node)
end

minetest.register_abm({
	nodenames = {"group:leafdecay"},
	neighbors = {"air", "group:liquid"},
	-- A low interval and a high inverse chance spreads the load
	interval = 1,
	chance = 2,

	action = function(p0, node, _, _)
		--print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
		local do_preserve = false
		local d = minetest.registered_nodes[node.name].groups.leafdecay
		if not d or d == 0 then
			--print("not groups.leafdecay")
			return
		end
		local n0 = minetest.get_node(p0)
		if n0.param2 ~= 0 then
			--print("param2 ~= 0")
			return
		end
		local p0_hash = nil
		if default.leafdecay_enable_cache then
			p0_hash = minetest.hash_node_position(p0)
			local trunkp = default.leafdecay_trunk_cache[p0_hash]
			if trunkp then
				local n = minetest.get_node(trunkp)
				local reg = minetest.registered_nodes[n.name]
				-- Assume ignore is a trunk, to make the thing
				-- work at the border of the active area
				if n.name == "ignore" or (reg and reg.groups.tree and
						reg.groups.tree ~= 0) then
					--print("cached trunk still exists")
					return
				end
				--print("cached trunk is invalid")
				-- Cache is invalid
				table.remove(default.leafdecay_trunk_cache, p0_hash)
			end
		end
		if default.leafdecay_trunk_find_allow_accumulator <= 0 then
			return
		end
		default.leafdecay_trunk_find_allow_accumulator =
				default.leafdecay_trunk_find_allow_accumulator - 1
		-- Assume ignore is a trunk, to make the thing
		-- work at the border of the active area
		local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
		if p1 then
			do_preserve = true
			if default.leafdecay_enable_cache then
				--print("caching trunk")
				-- Cache the trunk
				default.leafdecay_trunk_cache[p0_hash] = p1
			end
		end
		if not do_preserve then
			-- Drop stuff other than the node itself
			local itemstacks = minetest.get_node_drops(n0.name)
			for _, itemname in ipairs(itemstacks) do
				if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0 or
						itemname ~= n0.name then
					local p_drop = {
						x = p0.x - 0.5 + math.random(),
						y = p0.y - 0.5 + math.random(),
						z = p0.z - 0.5 + math.random(),
					}
					minetest.add_item(p_drop, itemname)
				end
			end
			-- Remove node
			minetest.remove_node(p0)
			nodeupdate(p0)
		end
	end
})


minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if newnode.name ~= "default:torch" or minetest.get_item_group(oldnode.name, "water") == 0 then
		return
	end
	minetest.remove_node(pos, newnode)
	minetest.set_node(pos, oldnode)
	minetest.add_item(pos, "default:torch")
end)

--
-- Grass growing
--

minetest.register_abm({
	nodenames = {"default:dirt"},
	interval = 30,
	chance = 5,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light") and
				nodedef.liquidtype == "none" and
				pos.y >= 0 and
				(minetest.get_node_light(above) or 0) >= 12 then
			if name == "default:snow" or name == "default:snowblock" then
				minetest.set_node(pos, {name = "default:dirt_with_snow"})
			else
				minetest.set_node(pos, {name = "default:dirt_with_grass"})
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 30,
	chance = 2,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})


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

-- Legacy:
function default.spawn_falling_node(p, nodename)
	spawn_falling_node(p, nodename)
end

-- Horrible crap to support old code,
-- don't use this and never do what this does, it's completely wrong!
-- (more specifically, the client and the C++ code doesn't get the group).
function default.register_falling_node(nodename, texture)
	minetest.log("error", debug.traceback())
	minetest.log("error", "WARNING: default.register_falling_node is deprecated.")
	if minetest.registered_nodes[nodename] then
		minetest.registered_nodes[nodename].groups.falling_node = 1
	end
end

--
-- Global callbacks
--

-- Global environment step function
function on_step(dtime)
	-- print("on_step, " .. p .. ", " .. node)
end
minetest.register_globalstep(on_step)

function on_placenode(p, node)
	-- print("on_placenode, " .. p .. ", " .. node)
end
minetest.register_on_placenode(on_placenode)

function on_dignode(p, node)
	-- print("on_dignode, " .. p .. ", " .. node)
end
minetest.register_on_dignode(on_dignode)

function on_punchnode(p, node)
	-- print("on_punchnode, " .. p .. ", " .. node)
end
minetest.register_on_punchnode(on_punchnode)

--
-- Lava cooling
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
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_flowing(pos, node, active_object_count, active_object_count_wider)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water"},
	interval = 2,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_source(pos, node, active_object_count, active_object_count_wider)
	end,
})

--
-- Papyrus and cactus growing
--

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 30,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y - 1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "sand") ~= 0 then
			pos.y = pos.y + 1
			local height = 0
			while minetest.get_node(pos).name == "default:cactus" and height < 4 do
				height = height + 1
				pos.y = pos.y + 1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name = "default:cactus"})
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_snow", "default:sand", "default:desert_sand"},
	interval = 30,
	chance = 30,
	action = function(pos, node)
		pos.y = pos.y - 1
		local name = minetest.get_node(pos).name
		if name == "default:dirt"
		or name == "default:dirt_with_grass"
		or name == "default:dirt_with_snow"
		or name == "default:sand"
		or name == "default:desert_sand" then
			if minetest.find_node_near(pos, 3, {"group:water"}) == nil then
				return
			end
			pos.y = pos.y + 1
			local height = 0
			while minetest.get_node(pos).name == "default:papyrus" and height < 4 do
				height = height + 1
				pos.y = pos.y + 1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name = "default:papyrus"})
				end
			end
		end
	end,
})

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

-- To enable leaf decay for a node, add it to the "leafdecay" group.
--
-- The rating of the group determines how far from a node in the group "tree"
-- the node can be without decaying.
--
-- If param2 of the node is ~= 0, the node will always be preserved. Thus, if
-- the player places a node of that kind, you will want to set param2= 1 or so.
--
-- If the node is in the leafdecay_drop group then the it will always be dropped
-- as an item

if minetest.setting_getbool("leaf_decay") ~= false then -- “If not defined or set to true then”

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
	local finds_per_second = 5000
	default.leafdecay_trunk_find_allow_accumulator =
			math.floor(dtime * finds_per_second)
end)

minetest.register_abm({
	nodenames = {"group:leafdecay"},
	neighbors = {"air", "group:liquid"},
	interval = 1, -- A low interval and a high inverse chance spreads the load.
	chance = 2,

	action = function(p0, node, _, _)
		-- print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
		local do_preserve = false
		local d = minetest.registered_nodes[node.name].groups.leafdecay
		if not d or d == 0 then
			-- print("not groups.leafdecay")
			return
		end
		local n0 = minetest.get_node(p0)
		if n0.param2 ~= 0 then
			-- print("param2 ~= 0")
			return
		end
		local p0_hash = nil
		if default.leafdecay_enable_cache then
			p0_hash = minetest.hash_node_position(p0)
			local trunkp = default.leafdecay_trunk_cache[p0_hash]
			if trunkp then
				local n = minetest.get_node(trunkp)
				local reg = minetest.registered_nodes[n.name]
				-- Assume ignore is a trunk, to make the thing work at the border of the active area:
				if n.name == "ignore" or (reg and reg.groups.tree and reg.groups.tree ~= 0) then
					-- print("Cached trunk still exists.")
					return
				end
				-- print("Cached trunk is invalid.")
				-- Cache is invalid:
				table.remove(default.leafdecay_trunk_cache, p0_hash)
			end
		end
		if default.leafdecay_trunk_find_allow_accumulator <= 0 then
			return
		end
		default.leafdecay_trunk_find_allow_accumulator =
				default.leafdecay_trunk_find_allow_accumulator - 1
		-- Assume ignore is a trunk, to make the thing work at the border of the active area:
		local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
		if p1 then
			do_preserve = true
			if default.leafdecay_enable_cache then
				-- print("Caching trunk.")
				-- Cache the trunk:
				default.leafdecay_trunk_cache[p0_hash] = p1
			end
		end
		if not do_preserve then
			-- Drop stuff other than the node itself:
			itemstacks = minetest.get_node_drops(n0.name)
			for _, itemname in ipairs(itemstacks) do
				if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0
				or itemname ~= n0.name then
					minetest.add_item(p0, itemname)
				end
			end
			minetest.remove_node(p0)
			-- minetest.log("action", n0.name .. " decayed at " .. minetest.pos_to_string(p0) .. ".")
			nodeupdate(p0)
		end
	end
})

end -- Ends: if minetest.setting_getbool("leaf_decay") ~= false

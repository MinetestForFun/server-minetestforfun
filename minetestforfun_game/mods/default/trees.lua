local random = math.random

--
-- Grow trees from saplings
--

-- 'can grow' function

function default.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	local name_under = node_under.name
	local is_soil = minetest.get_item_group(name_under, "soil")
	if is_soil == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end


-- 'is snow nearby' function

local function is_snow_nearby(pos)
	return #minetest.find_nodes_in_area(
		{x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"default:snow", "default:snowblock", "default:dirt_with_snow"}) > 0
end


-- Sapling ABM

function default.grow_sapling(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end

	--local mg_name = minetest.get_mapgen_setting("mg_name") --new function in > 0.4.14 stable ???
	local mg_name = minetest.get_mapgen_params().mgname
	local node = minetest.get_node(pos)
	if node.name == "default:sapling" then
		minetest.log("action", "A sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_tree(pos, random(1, 4) == 1)
		else
			default.grow_new_apple_tree(pos)
		end
	elseif node.name == "default:junglesapling" then
		minetest.log("action", "A jungle sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_jungle_tree(pos)
		else
			default.grow_new_jungle_tree(pos)
		end
	elseif node.name == "default:pine_sapling" then
		minetest.log("action", "A pine sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		local snow = is_snow_nearby(pos)
		if mg_name == "v6" then
			default.grow_pine_tree(pos, snow)
		elseif snow then
			default.grow_new_snowy_pine_tree(pos)
		else
			default.grow_new_pine_tree(pos)
		end
	elseif node.name == "default:acacia_sapling" then
		minetest.log("action", "An acacia sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_acacia_tree(pos)
	elseif node.name == "default:aspen_sapling" then
		minetest.log("action", "An aspen sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_aspen_tree(pos)
	end
end

minetest.register_lbm({
	name = "default:convert_saplings_to_node_timer",
	nodenames = {"default:sapling", "default:junglesapling",
			"default:pine_sapling", "default:acacia_sapling",
			"default:aspen_sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

--
-- Tree generation
--

-- Apple tree and jungle tree trunk and leaves function

local function add_trunk_and_leaves(data, a, pos, tree_cid, leaves_cid,
		height, size, iters, is_apple_tree)
	local x, y, z = pos.x, pos.y, pos.z
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_apple = minetest.get_content_id("default:apple")

	-- Trunk
	data[a:index(x, y, z)] = tree_cid -- Force-place lowest trunk node to replace sapling
	for yy = y + 1, y + height - 1 do
		local vi = a:index(x, yy, z)
		local node_id = data[vi]
		if node_id == c_air or node_id == c_ignore or node_id == leaves_cid then
			data[vi] = tree_cid
		end
	end

	-- Force leaves near the trunk
	for z_dist = -1, 1 do
	for y_dist = -size, 1 do
		local vi = a:index(x - 1, y + height + y_dist, z + z_dist)
		for x_dist = -1, 1 do
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
			vi = vi + 1
		end
	end
	end

	-- Randomly add leaves in 2x2x2 clusters.
	for i = 1, iters do
		local clust_x = x + random(-size, size - 1)
		local clust_y = y + height + random(-size, 0)
		local clust_z = z + random(-size, size - 1)

		for xi = 0, 1 do
		for yi = 0, 1 do
		for zi = 0, 1 do
			local vi = a:index(clust_x + xi, clust_y + yi, clust_z + zi)
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
		end
		end
		end
	end
end

default.add_trunk_and_leaves = add_trunk_and_leaves -- MFF edit 2016-08-21

-- Apple tree

function default.grow_tree(pos, is_apple_tree, bad)
	--[[
		NOTE: Tree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	if bad then
		error("Deprecated use of default.grow_tree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(4, 5)
	local c_tree = minetest.get_content_id("default:tree")
	local c_leaves = minetest.get_content_id("default:leaves")

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - 2, y = y, z = z - 2},
		{x = x + 2, y = y + height + 1, z = z + 2}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_tree, c_leaves, height, 2, 8, is_apple_tree)

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end


-- Jungle tree

function default.grow_jungle_tree(pos, bad)
	--[[
		NOTE: Jungletree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	if bad then
		error("Deprecated use of default.grow_jungle_tree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(8, 12)
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_jungletree = minetest.get_content_id("default:jungletree")
	local c_jungleleaves = minetest.get_content_id("default:jungleleaves")

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - 3, y = y - 1, z = z - 3},
		{x = x + 3, y = y + height + 1, z = z + 3}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_jungletree, c_jungleleaves,
		height, 3, 30, false)

	-- Roots
	for z_dist = -1, 1 do
		local vi_1 = a:index(x - 1, y - 1, z + z_dist)
		local vi_2 = a:index(x - 1, y, z + z_dist)
		for x_dist = -1, 1 do
			if random(1, 3) >= 2 then
				if data[vi_1] == c_air or data[vi_1] == c_ignore then
					data[vi_1] = c_jungletree
				elseif data[vi_2] == c_air or data[vi_2] == c_ignore then
					data[vi_2] = c_jungletree
				end
			end
			vi_1 = vi_1 + 1
			vi_2 = vi_2 + 1
		end
	end

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end


-- Pine tree from mg mapgen mod, design by sfan5, pointy top added by paramat

local function add_pine_needles(data, vi, c_air, c_ignore, c_snow, c_pine_needles)
	local node_id = data[vi]
	if node_id == c_air or node_id == c_ignore or node_id == c_snow then
		data[vi] = c_pine_needles
	end
end

local function add_snow(data, vi, c_air, c_ignore, c_snow)
	local node_id = data[vi]
	if node_id == c_air or node_id == c_ignore then
		data[vi] = c_snow
	end
end

function default.grow_pine_tree(pos, snow)
	local x, y, z = pos.x, pos.y, pos.z
	local maxy = y + random(9, 13) -- Trunk top

	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_pine_tree = minetest.get_content_id("default:pine_tree")
	local c_pine_needles  = minetest.get_content_id("default:pine_needles")
	local c_snow = minetest.get_content_id("default:snow")

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - 3, y = y, z = z - 3},
		{x = x + 3, y = maxy + 3, z = z + 3}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	-- Upper branches layer
	local dev = 3
	for yy = maxy - 1, maxy + 1 do
		for zz = z - dev, z + dev do
			local vi = a:index(x - dev, yy, zz)
			local via = a:index(x - dev, yy + 1, zz)
			for xx = x - dev, x + dev do
				if random() < 0.95 - dev * 0.05 then
					add_pine_needles(data, vi, c_air, c_ignore, c_snow,
						c_pine_needles)
					if snow then
						add_snow(data, via, c_air, c_ignore, c_snow)
					end
				end
				vi  = vi + 1
				via = via + 1
			end
		end
		dev = dev - 1
	end

	-- Centre top nodes
	add_pine_needles(data, a:index(x, maxy + 1, z), c_air, c_ignore, c_snow,
		c_pine_needles)
	add_pine_needles(data, a:index(x, maxy + 2, z), c_air, c_ignore, c_snow,
		c_pine_needles) -- Paramat added a pointy top node
	if snow then
		add_snow(data, a:index(x, maxy + 3, z), c_air, c_ignore, c_snow)
	end

	-- Lower branches layer
	local my = 0
	for i = 1, 20 do -- Random 2x2 squares of needles
		local xi = x + random(-3, 2)
		local yy = maxy + random(-6, -5)
		local zi = z + random(-3, 2)
		if yy > my then
			my = yy
		end
		for zz = zi, zi+1 do
			local vi = a:index(xi, yy, zz)
			local via = a:index(xi, yy + 1, zz)
			for xx = xi, xi + 1 do
				add_pine_needles(data, vi, c_air, c_ignore, c_snow,
					c_pine_needles)
				if snow then
					add_snow(data, via, c_air, c_ignore, c_snow)
				end
				vi  = vi + 1
				via = via + 1
			end
		end
	end

	local dev = 2
	for yy = my + 1, my + 2 do
		for zz = z - dev, z + dev do
			local vi = a:index(x - dev, yy, zz)
			local via = a:index(x - dev, yy + 1, zz)
			for xx = x - dev, x + dev do
				if random() < 0.95 - dev * 0.05 then
					add_pine_needles(data, vi, c_air, c_ignore, c_snow,
						c_pine_needles)
					if snow then
						add_snow(data, via, c_air, c_ignore, c_snow)
					end
				end
				vi  = vi + 1
				via = via + 1
			end
		end
		dev = dev - 1
	end

	-- Trunk
	-- Force-place lowest trunk node to replace sapling
	data[a:index(x, y, z)] = c_pine_tree
	for yy = y + 1, maxy do
		local vi = a:index(x, yy, z)
		local node_id = data[vi]
		if node_id == c_air or node_id == c_ignore or
				node_id == c_pine_needles or node_id == c_snow then
			data[vi] = c_pine_tree
		end
	end

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end


-- New apple tree

function default.grow_new_apple_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/apple_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end


-- New jungle tree

function default.grow_new_jungle_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/jungle_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end


-- New pine tree

function default.grow_new_pine_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/pine_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end


-- New snowy pine tree

function default.grow_new_snowy_pine_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/snowy_pine_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end


-- New acacia tree

function default.grow_new_acacia_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/acacia_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 1, z = pos.z - 4},
		path, "random", nil, false)
end


-- New aspen tree

function default.grow_new_aspen_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/aspen_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end


--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function default.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node(pos)
	local pdef = minetest.registered_nodes[node.name]
	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node(pos)
		pdef = minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer:get_player_name()
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if not default.intersects_protection(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.set_node(pos, {name = sapling_name})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
	else
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
		minetest.chat_send_player(player_name, "Tree will intersect protection")
	end

	return itemstack
end

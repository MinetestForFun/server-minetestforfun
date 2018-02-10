--[[ MFF: Prevent trees from destroying existing blocks
     This is the list of "safe" blocks in which a tree can grow
     They were moved outside the local safety function for speed (I hope)
--]]
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")

-- MFF: The local function to do safety checks
local function safely_set_block(t, k, v)
	if t[k] == c_air or t[k] == c_ignore then
		t[k] = v
	end
end

function watershed_appletree(x, y, z, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_apple = minetest.get_content_id("default:apple")
	local c_wsappleaf = minetest.get_content_id("watershed:appleleaf")

	-- MFF: Higher default tree with a bit of randomness
	local tree_top = 5 + math.random(0, 1)
	local leaves_height =  tree_top - 1
	local branches_height = leaves_height - 1

	for j = 0, tree_top do	-- MFF: Higher tree, same design
		if j >= leaves_height then
			for i = -2, 2 do
			for k = -2, 2 do
				local vil = area:index(x + i, y + j, z + k)
				if math.random(64) == 2 then
					-- MFF: Prevent trees from destroying existing blocks
					safely_set_block(data, vil, c_apple)
				elseif math.random(5) ~= 2 then
					-- MFF: Prevent trees from destroying existing blocks
					safely_set_block(data, vil, c_wsappleaf)
				end
			end
			end
		elseif j == branches_height then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					local vit = area:index(x + i, y + j, z + k)
					-- MFF: Prevent trees from destroying existing blocks
					safely_set_block(data, vit, c_tree)
				end
			end
			end
		else
			local vit = area:index(x, y + j, z)
			-- MFF: Prevent trees from destroying existing blocks
			if j == 0 then
				-- MFF: the position of the sapling itself, replace it without checking.
				data[vit] = c_tree
			else
				safely_set_block(data, vit, c_tree)
			end
		end
	end
end

function watershed_pinetree(x, y, z, area, data)
	local c_wspitree = minetest.get_content_id("watershed:pinetree")
	local c_wsneedles = minetest.get_content_id("watershed:needles")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	for j = 0, 14 do
		if j == 3 or j == 6 or j == 9 or j == 12 then
			for i = -2, 2 do
			for k = -2, 2 do
				if math.abs(i) == 2 or math.abs(k) == 2 then
					if math.random(7) ~= 2 then
						-- MFF: Prevent trees from destroying existing blocks
						local vil = area:index(x + i, y + j, z + k)
						safely_set_block(data, vil, c_wsneedles)
						local vila = area:index(x + i, y + j + 1, z + k)
						safely_set_block(data, vila, c_snowblock)
					end
				end
			end
			end
		elseif j == 4 or j == 7 or j == 10 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					if math.random(11) ~= 2 then
						-- MFF: Prevent trees from destroying existing blocks
						local vil = area:index(x + i, y + j, z + k)
						safely_set_block(data, vil, c_wsneedles)
						local vila = area:index(x + i, y + j + 1, z + k)
						safely_set_block(data, vila, c_snowblock)
					end
				end
			end
			end
		elseif j == 13 then
			for i = -1, 1 do
			for k = -1, 1 do
				if not (i == 0 and j == 0) then
					-- MFF: Prevent trees from destroying existing blocks
					local vil = area:index(x + i, y + j, z + k)
					safely_set_block(data, vil,c_wsneedles)
					local vila = area:index(x + i, y + j + 1, z + k)
					safely_set_block(data, vila, c_wsneedles)
					local vilaa = area:index(x + i, y + j + 2, z + k)
					safely_set_block(data, vilaa, c_snowblock)
				end
			end
			end
		end
		-- MFF: Prevent trees from destroying existing blocks
		local vit = area:index(x, y + j, z)
		if j == 0 then
			data[vit] = c_wspitree	-- No safety check for the sapling itself
		else
			safely_set_block(data, vit, c_wspitree)
		end
	end
	local vil = area:index(x, y + 15, z)
	local vila = area:index(x, y + 16, z)
	local vilaa = area:index(x, y + 17, z)
	-- MFF: Prevent trees from destroying existing blocks
	safely_set_block(data, vil, c_wsneedles)
	safely_set_block(data, vila, c_wsneedles)
	safely_set_block(data, vilaa, c_snowblock)
end

function watershed_jungletree(x, y, z, area, data)
	local c_juntree = minetest.get_content_id("default:jungletree")
	local c_wsjunleaf = minetest.get_content_id("watershed:jungleleaf")
	local c_vine = minetest.get_content_id("watershed:vine")
	local top = math.random(17,23)
	local branch = math.floor(top * 0.6)
	for j = -5, top do
		if j == top or j == top - 1 or j == branch + 1 or j == branch + 2 then
			for i = -2, 2 do -- leaves
			for k = -2, 2 do
				local vi = area:index(x + i, y + j, z + k)
				if math.random(5) ~= 2 then
					-- MFF: Prevent trees from destroying existing blocks
					safely_set_block(data, vi, c_wsjunleaf)
				end
			end
			end
		elseif j == top - 2 or j == branch then -- branches
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					local vi = area:index(x + i, y + j, z + k)
					-- MFF: Prevent trees from destroying existing blocks
					safely_set_block(data, vi, c_juntree)
				end
			end
			end
		end
		if j >= 0 and j <= top - 3 then -- climbable nodes
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 1 then
					local vi = area:index(x + i, y + j, z + k)
					data[vi] = c_vine
				end
			end
			end
		end
		if j <= top - 3 then -- trunk
			local vi = area:index(x, y + j, z)
			-- MFF: Prevent trees from destroying existing blocks
			if j == 0 then
				data[vi] = c_juntree	-- No safety check for the sapling itself
			else
				safely_set_block(data, vi, c_juntree)
			end
		end
	end
end

function watershed_acaciatree(x, y, z, area, data)
	local c_wsactree = minetest.get_content_id("watershed:acaciatree")
	local c_wsacleaf = minetest.get_content_id("watershed:acacialeaf")
	for j = -3, 6 do
		if j == 6 then
			for i = -4, 4 do
			for k = -4, 4 do
				if not (i == 0 or k == 0) then
					if math.random(7) ~= 2 then
						local vil = area:index(x + i, y + j, z + k)
						data[vil] = c_wsacleaf
					end
				end
			end
			end
		elseif j == 5 then
			for i = -2, 2, 4 do
			for k = -2, 2, 4 do
				local vit = area:index(x + i, y + j, z + k)
				data[vit] = c_wsactree
			end
			end
		elseif j == 4 then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					local vit = area:index(x + i, y + j, z + k)
					data[vit] = c_wsactree
				end
			end
			end
		else
			local vit = area:index(x, y + j, z)
			data[vit] = c_wsactree
		end
	end
end

function watershed_flower(data, vi, noise)
	local c_danwhi = minetest.get_content_id("flowers:dandelion_white")
	local c_danyel = minetest.get_content_id("flowers:dandelion_yellow")
	local c_rose = minetest.get_content_id("flowers:rose")
	local c_tulip = minetest.get_content_id("flowers:tulip")
	local c_geranium = minetest.get_content_id("flowers:geranium")
	local c_viola = minetest.get_content_id("flowers:viola")
	if noise > 0.8 then
		data[vi] = c_danwhi
	elseif noise > 0.4 then
		data[vi] = c_rose
	elseif noise > 0 then
		data[vi] = c_tulip
	elseif noise > -0.4 then
		data[vi] = c_danyel
	elseif noise > -0.8 then
		data[vi] = c_geranium
	else
		data[vi] = c_viola
	end
end

function watershed_cactus(x, y, z, area, data)
	local c_wscactus = minetest.get_content_id("watershed:cactus")
	for j = -2, 4 do
	for i = -2, 2 do
		if i == 0 or j == 2 or (j == 3 and math.abs(i) == 2) then
			local vic = area:index(x + i, y + j, z)
			data[vic] = c_wscactus
		end
	end
	end
end

function watershed_papyrus(x, y, z, area, data)
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local ph = math.random(1, 4)
	for j = 0, ph do
		local vip = area:index(x, y + j, z)
		data[vip] = c_papyrus
	end
end


-- ABM

-- Lava-water cooling

minetest.register_abm({
	nodenames = {"group:lava"},
	neighbors = {"group:water"},
	interval = 11,
	chance = 64,
	action = function(pos)
		minetest.add_node(pos, {name = "default:obsidian"})
		minetest.sound_play("default_cool_lava", {pos = pos, gain = 0.25})
	end,
})

-- Appletree sapling

minetest.register_abm({
	nodenames = {"watershed:appling"},
	interval = 57,
	chance = 3,
	action = function(pos, node)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x - 2, y = y - 2, z = z - 2}
		local pos2 = {x = x + 2, y = y + 4, z = z + 2}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local data = vm:get_data()
		watershed_appletree(x, y, z, area, data)
		vm:set_data(data)
		vm:write_to_map()
		vm:update_map()
	end,
})

-- Pine sapling

minetest.register_abm({
	nodenames = {"watershed:pineling"},
	interval = 59,
	chance = 3,
	action = function(pos)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x - 2, y = y - 4, z = z - 2}
		local pos2 = {x = x + 2, y = y + 17, z = z + 2}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local data = vm:get_data()
		watershed_pinetree(x, y, z, area, data)
		vm:set_data(data)
		vm:write_to_map()
		vm:update_map()
	end,
})

-- Acacia sapling

minetest.register_abm({
	nodenames = {"watershed:acacialing"},
	interval = 61,
	chance = 3,
	action = function(pos)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x - 4, y = y - 3, z = z - 4}
		local pos2 = {x = x + 4, y = y + 6, z = z + 4}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local data = vm:get_data()
		watershed_acaciatree(x, y, z, area, data)
		vm:set_data(data)
		vm:write_to_map()
		vm:update_map()
	end,
})

-- Jungletree sapling

minetest.register_abm({
	nodenames = {"watershed:jungling"},
	interval = 63,
	chance = 3,
	action = function(pos)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x - 2, y = y - 5, z = z - 2}
		local pos2 = {x = x + 2, y = y + 23, z = z + 2}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local data = vm:get_data()
		watershed_jungletree(x, y, z, area, data)
		vm:set_data(data)
		vm:write_to_map()
		vm:update_map()
	end,
})

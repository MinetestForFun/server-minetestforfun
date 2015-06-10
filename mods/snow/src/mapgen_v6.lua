-- 2D noise for coldness

local np_cold = {
	offset = 0,
	scale = 1,
	spread = {x=150, y=150, z=150},
	seed = 112,
	octaves = 3,
	persist = 0.5
}

-- 2D noise for icetype

local np_ice = {
	offset = 0,
	scale = 1,
	spread = {x=80, y=80, z=80},
	seed = 322345,
	octaves = 3,
	persist = 0.5
}

-- Debugging function

local biome_strings = {
	{"snowy", "plain", "alpine", "normal", "normal"},
	{"cool", "icebergs", "icesheet", "icecave", "icehole"}
}
local function biome_to_string(num,num2)
	local biome = biome_strings[1][num] or "unknown "..num
	return biome
end

local function do_ws_func(a, x)
	local n = x/(16000)
	local y = 0
	for k=1,1000 do
		y = y + 1000*(math.sin(math.pi * k^a * n)/(math.pi * k^a))
	end
	return y
end

local ws_lists = {}
local function get_ws_list(a,x)
        ws_lists[a] = ws_lists[a] or {}
        local v = ws_lists[a][x]
        if v then
                return v
        end
        v = {}
        for x=x,x + (80 - 1) do
		local y = do_ws_func(a, x)
                v[x] = y
        end
        ws_lists[a][x] = v
        return v
end

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	local t1 = os.clock()

	local x0 = minp.x
	local z0 = minp.z
	local x1 = maxp.x
	local z1 = maxp.z

	local spawn_pine = snow.voxelmanip_pine
	local smooth = snow.smooth_biomes

	local c_dirt_with_grass = minetest.get_content_id("default:dirt_with_grass")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_tree = minetest.get_content_id("default:tree")
	local c_apple = minetest.get_content_id("default:apple")
	local c_snow = minetest.get_content_id("default:snow")
	local c_snow_block = minetest.get_content_id("default:snowblock")
	local c_dirt_with_snow = minetest.get_content_id("default:dirt_with_snow")
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_stone = minetest.get_content_id("default:stone")
	local c_dry_shrub = minetest.get_content_id("default:dry_shrub")
	local c_leaves = minetest.get_content_id("default:leaves")
	local c_jungleleaves = minetest.get_content_id("default:jungleleaves")
	local c_junglegrass = minetest.get_content_id("default:junglegrass")
	local c_ice = minetest.get_content_id("default:ice")
	local c_water = minetest.get_content_id("default:water_source")
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local c_sand = minetest.get_content_id("default:sand")

	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
	local data = vm:get_data()

	local snow_tab,num = {},1

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local nvals_cold = minetest.get_perlin_map(np_cold, chulens):get2dMap_flat({x=x0, y=z0})
	local nvals_ice = minetest.get_perlin_map(np_ice, chulens):get2dMap_flat({x=x0, y=z0})

	-- Choose biomes
	local pr = PseudoRandom(seed+57)
	-- Land biomes
	local biome = pr:next(1, 5)
	local snowy = biome == 1 -- spawns alot of snow
	local alpine = biome == 3 -- rocky terrain
	-- Misc biome settings
	local icy = pr:next(1, 2) == 2   -- if enabled spawns ice in sand instead of snow blocks
	local shrubs = pr:next(1,2) == 1 -- spawns dry shrubs in snow
	local pines = pr:next(1,2) == 1 -- spawns pines
	-- Reseed random
	pr = PseudoRandom(seed+68)

	-- Loop through columns in chunk
	local write_to_map = false
	local ni = 1
	for z = z0, z1 do
	for x = x0, x1 do
	        local in_biome = false
	        local test = nvals_cold[ni]
	        if smooth and (not snowy)
		and (test > 0.73 or (test > 0.43 and pr:next(0,29) > (0.73 - test) * 100 )) then
	            in_biome = true
	        elseif (not smooth or snowy) and test > 0.53 then
			in_biome = true
	        end

		if not in_biome then
			if alpine and test > 0.43 then
				local ground_y = nil
				for y = maxp.y, minp.y, -1 do
					local nodid = data[area:index(x, y, z)]
					if nodid ~= c_air
					and nodid ~= c_ignore then
						ground_y = y
						break
					end
				end

				if ground_y then
					local vi = area:index(x, ground_y, z)
					if data[vi] == c_leaves or data[vi] == c_jungleleaves then
						for y = ground_y, -16, -1 do
							local vi = area:index(x, y, z)
							local id = data[vi]
							if id ~= c_air then
								if id == c_leaves
								or id == c_jungleleaves
								or id == c_tree
								or id == c_apple then
									data[vi] = c_air
								else
									break
								end
							end
						end
					end
				end
			end
		elseif in_biome then
			write_to_map = true
	        	local icetype = nvals_ice[ni]
			local cool = icetype > 0 -- only spawns ice on edge of water
			local icebergs = icetype > -0.2 and icetype <= 0
			local icehole = icetype > -0.4 and icetype <= -0.2 -- icesheet with holes
			local icesheet = icetype > -0.6 and icetype <= -0.4
			local icecave = icetype <= -0.6

			local ground_y = nil
			for y = maxp.y, minp.y, -1 do
				local nodid = data[area:index(x, y, z)]
				if nodid ~= c_air and nodid ~= c_ignore then
					ground_y = y
					break
				end
			end

			if ground_y then
				local node = area:index(x, ground_y, z)
				local abovenode = area:index(x, ground_y+1, z)
				local belownode = area:index(x, ground_y-1, z)

				if ground_y and data[node] == c_dirt_with_grass then
					if alpine and test > 0.53 then
						snow_tab[num] = {abovenode, z, x, test}
						num = num+1
						for y = ground_y, -6, -1 do
							local vi = area:index(x, y, z)
							if data[vi] == c_stone then
								break
							else
								data[vi] = c_stone
							end
						end
					elseif (shrubs and pr:next(1,28) == 1) then
						data[node] = c_dirt_with_snow
						data[abovenode] = c_dry_shrub
					elseif pines and pr:next(1,36) == 1 then
						data[node] = c_dirt_with_snow
						spawn_pine({x=x, y=ground_y+1, z=z}, area, data)
					elseif snowy and test > 0.63 then
						data[abovenode] = c_snow_block
					else
						data[node] = c_dirt_with_snow
						snow_tab[num] = {abovenode, z, x, test}
						num = num+1
					end
				elseif ground_y and data[node] == c_sand then
					if not icy then
						snow_tab[num] = {abovenode, z, x, test}
						num = num+1
					else
						data[node] = c_ice
					end
				elseif ground_y and data[node] == c_leaves
				or data[node] == c_jungleleaves or data[node] == c_apple then
					if alpine then
						snow_tab[num] = {abovenode, z, x, test}
						num = num+1
						for y = ground_y, -6, -1 do
							local stone = area:index(x, y, z)
							if data[stone] ==  c_stone then
								break
							else
								data[stone] = c_stone
							end
						end
					else
						snow_tab[num] = {abovenode, z, x, test}
						num = num+1
					end
				elseif ground_y
				and data[node] == c_junglegrass then
					data[node] = c_dry_shrub
				elseif ground_y
				and data[node] == c_papyrus then
					for y = ground_y, ground_y-4, -1 do
						local vi = area:index(x, y, z)
						if data[vi] == c_papyrus then
							snow_tab[num] = {area:index(x, ground_y, z), z, x, test}
							num = num+1
							data[vi] = c_snow_block
						end
					end
				elseif ground_y
				and data[node] == c_water then
					if not icesheet
					and not icecave
					and not icehole then
						local x1 = data[area:index(x+1, ground_y, z)]
						local z1 = data[area:index(x, ground_y, z+1)]
						local xz1 = data[area:index(x+1, ground_y, z+1)]
						local xz2 = data[area:index(x-1, ground_y, z-1)]
						local x2 = data[area:index(x-1, ground_y, z)]
						local z2 = data[area:index(x, ground_y, z-1)]
						local rand = (pr:next(1,4) == 1) and (cool or icebergs)
						local ice
						if rand then
							for _,i in ipairs({x1,z1,xz1,xz2,x2,z2}) do
								if i == c_ice then
									ice = true
									break
								end
							end
						end
						if not ice then
							for _,i in ipairs({x1,z1,xz1,xz2,x2,z2}) do
								if i ~= c_water
								and i ~= c_ice
								and i ~= c_air
								and i ~= c_ignore then
									ice = true
									break
								end
							end
						end
						local y = data[area:index(x, ground_y-1, z)]
						if ice
						or (y ~= c_water and y ~= c_ice) -- and y ~= "air") …I don't think y can be a string here ~HybridDog
						or (icebergs and pr:next(1,6) == 1) then
							data[node] = c_ice
						end
					else
						if (icehole and pr:next(1,10) > 1)
						or icecave
						or icesheet then
							data[node] = c_ice
						end
						if icecave then
							for y = ground_y-1, -33, -1 do
								local vi = area:index(x, y, z)
								if data[vi] ~= c_water then
									break
								else
									data[vi] = c_air
								end
							end
						end
					end
				end
			end
		end
		ni = ni + 1
	end
	end

	local param2s
	if num ~= 1 then
		local wsz, wsx
		for _,i in pairs(snow_tab) do
			local p,z,x,test = unpack(i)
			data[p] = c_snow
			test = test-0.73
			if test > 0 then
				local minh = math.floor(test*4*9)%9+1
				if minh ~= 1 then
					if not wsz then
						wsz = get_ws_list(5, z0)
						wsx = get_ws_list(2, x0)
						param2s = vm:get_param2_data()
					end
					local h = math.min(minh, math.floor(wsx[x]+wsz[z]*5)%9+1)
					if h ~= 1 then
						if h == 9 then
							h = 4
						end
						param2s[p] = h*7
					end
				end
			end
		end
	end

	vm:set_data(data)
	if param2s then
		vm:set_param2_data(param2s)
	end
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map()

	if write_to_map
	and snow.debug then -- print if any column of mapchunk was snow biome
		local biome_string = biome_to_string(biome)
		local chugent = math.ceil((os.clock() - t1) * 1000)
		print("[snow] "..biome_string.." x "..minp.x.." z "..minp.z.." time "..chugent.." ms")
	end
end)


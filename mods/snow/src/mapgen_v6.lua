-- https://github.com/paramat/meru/blob/master/init.lua#L52
-- Parameters must match mgv6 biome noise

local np_default = {
	offset = 0,
	scale = 1,
	spread = {x=250, y=250, z=250},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}


-- 2D noise for coldness

local mg = snow.mapgen
local scale = mg.perlin_scale
local np_cold = {
	offset = 0,
	scale = 1,
	spread = {x=scale, y=scale, z=scale},
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


local function do_ws_func(a, x)
	local n = math.pi * x / 16000
	local y = 0
	for k = 1,1000 do
		y = y + math.sin(k^a * n)/(k^a)
	end
	return 1000*y/math.pi
end


-- caching functions

local ws_values = {}
local function get_ws_value(a, x)
	local v = ws_values[a]
	if v then
		v = v[x]
		if v then
			return v
		end
	else
		ws_values[a] = {}
		-- weak table, see https://www.lua.org/pil/17.1.html
		setmetatable(ws_values[a], {__mode = "kv"})
	end
	v = do_ws_func(a, x)
	ws_values[a][x] = v
	return v
end

local plantlike_ids = {}
setmetatable(plantlike_ids, {__mode = "kv"})
local function is_plantlike(id)
	if plantlike_ids[id] ~= nil then
		return plantlike_ids[id]
	end
	local node = minetest.registered_nodes[minetest.get_name_from_content_id(id)]
	if not node then
		plantlike_ids[id] = false
		return false
	end
	local drawtype = node.drawtype
	if not drawtype
	or drawtype ~= "plantlike" then
		plantlike_ids[id] = false
		return false
	end
	plantlike_ids[id] = true
	return true
end

local snowable_ids = {}
setmetatable(snowable_ids, {__mode = "kv"})
local function is_snowable(id)
	if snowable_ids[id] ~= nil then
		return snowable_ids[id]
	end
	local node = minetest.registered_nodes[minetest.get_name_from_content_id(id)]
	if not node then
		snowable_ids[id] = false
		return false
	end
	local drawtype = node.drawtype
	if drawtype
	and drawtype ~= "normal"
	and drawtype ~= "allfaces_optional"
	and drawtype ~= "glasslike" then
		snowable_ids[id] = false
		return false
	end
	snowable_ids[id] = true
	return true
end


local c, replacements, mg_debug, biome_to_string
local function define_contents()
	c = {
		dirt_with_grass = minetest.get_content_id("default:dirt_with_grass"),
		dirt = minetest.get_content_id("default:dirt"),
		tree = minetest.get_content_id("default:tree"),
		apple = minetest.get_content_id("default:apple"),
		snow = minetest.get_content_id("default:snow"),
		snow_block = minetest.get_content_id("default:snowblock"),
		dirt_with_snow = minetest.get_content_id("default:dirt_with_snow"),
		air = minetest.get_content_id("air"),
		ignore = minetest.get_content_id("ignore"),
		stone = minetest.get_content_id("default:stone"),
		dry_shrub = minetest.get_content_id("default:dry_shrub"),
		snow_shrub = minetest.get_content_id("snow:shrub_covered"),
		leaves = minetest.get_content_id("default:leaves"),
		jungleleaves = minetest.get_content_id("default:jungleleaves"),
		junglegrass = minetest.get_content_id("default:junglegrass"),
		ice = minetest.get_content_id("default:ice"),
		water = minetest.get_content_id("default:water_source"),
		papyrus = minetest.get_content_id("default:papyrus"),
		sand = minetest.get_content_id("default:sand"),
		desert_sand = minetest.get_content_id("default:desert_sand"),
	}
	replacements = snow.known_plants or {}

	mg_debug = snow.debug
end

local smooth = snow.smooth_biomes
local smooth_rarity_max = mg.smooth_rarity_max
local smooth_rarity_min = mg.smooth_rarity_min
local smooth_rarity_dif = mg.smooth_rarity_dif
local nosmooth_rarity = mg.nosmooth_rarity

snow.register_on_configuring(function(name, v)
	if name == "debug" then
		mg_debug = v
	elseif name == "mapgen_rarity"
	or name == "mapgen_size"
	or name == "smooth_biomes" then
		minetest.after(0, function()
			smooth = snow.smooth_biomes
			smooth_rarity_max = mg.smooth_rarity_max
			smooth_rarity_min = mg.smooth_rarity_min
			smooth_rarity_dif = mg.smooth_rarity_dif
			nosmooth_rarity = mg.nosmooth_rarity
			local scale = mg.perlin_scale
			np_cold = {
				offset = 0,
				scale = 1,
				spread = {x=scale, y=scale, z=scale},
				seed = 112,
				octaves = 3,
				persist = 0.5
			}
		end)
	end
end)

minetest.register_on_generated(function(minp, maxp, seed)
	local t1 = os.clock()

	local x0 = minp.x
	local z0 = minp.z
	local x1 = maxp.x
	local z1 = maxp.z

	if not c then
		define_contents()
	end

	local vm, emin, emax = minetest.get_mapgen_object"voxelmanip"
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local param2s = vm:get_param2_data()

	local heightmap = minetest.get_mapgen_object"heightmap"

	local snow_tab,num = {},1
	local pines_tab,pnum = {},1

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local nvals_default = minetest.get_perlin_map(np_default, chulens):get2dMap_flat{x=x0+150, y=z0+50}
	local nvals_cold, nvals_ice

	-- Choose biomes
	local pr = PseudoRandom(seed+57)
	-- Land biomes
	local biome = pr:next(1, 5)
	local snowy = biome == 1 -- spawns snow
	local alpine = biome == 3 -- rocky terrain
	-- Misc biome settings
	local icy = pr:next(1, 2) == 2   -- if enabled spawns ice in sand instead of snow blocks
	local shrubs = pr:next(1,2) == 1 -- spawns dry shrubs in snow
	local pines = pr:next(1,2) == 1 -- spawns pines
	-- Reseed random
	pr = PseudoRandom(seed+68)

	local nodes_added

	-- Loop through columns in chunk
	local smooth = smooth and not snowy
	local write_to_map = false
	local ni = 1
	for z = z0, z1 do
	for x = x0, x1 do
		local in_biome = false
		local test
		if nvals_default[ni] < 0.35 then
			if not nvals_cold then
				nvals_cold = minetest.get_perlin_map(np_cold, chulens):get2dMap_flat{x=x0, y=z0}
			end
			test = math.min(nvals_cold[ni], 1)
			if smooth then
				if test >= smooth_rarity_max
				or (
					test > smooth_rarity_min
					and pr:next(1, 1000) <= ((test-smooth_rarity_min)/smooth_rarity_dif)*1000
				) then
					in_biome = true
				end
			elseif test > nosmooth_rarity then
				in_biome = true
			end
		end

		if not in_biome then
			if alpine
			and test
			and test > smooth_rarity_min then
				-- remove trees near alpine
				local ground_y
				if data[area:index(x, maxp.y, z)] == c.air then
					for y = math.min(heightmap[ni]+20, maxp.y), math.max(minp.y, heightmap[ni]-5), -1 do
						if data[area:index(x, y, z)] ~= c.air then
							ground_y = y
							break
						end
					end
				end

				if ground_y then
					local vi = area:index(x, ground_y, z)
					if data[vi] == c.leaves
					or data[vi] == c.jungleleaves then
						nodes_added = true
						for y = ground_y, -16, -1 do
							local vi = area:index(x, y, z)
							local id = data[vi]
							if id ~= c.air then
								if id == c.leaves
								or id == c.jungleleaves
								or id == c.tree
								or id == c.apple then
									data[vi] = c.air
								else
									break
								end
							end
						end
					end
				end
			end
		else
			nodes_added = true
			write_to_map = true
			if not nvals_ice then
				nvals_ice = minetest.get_perlin_map(np_ice, chulens):get2dMap_flat{x=x0, y=z0}
			end
			local icetype = nvals_ice[ni]
			local cool = icetype > 0 -- only spawns ice on edge of water
			local icebergs = icetype > -0.2 and icetype <= 0
			local icehole = icetype > -0.4 and icetype <= -0.2 -- icesheet with holes
			local icesheet = icetype > -0.6 and icetype <= -0.4
			local icecave = icetype <= -0.6


			local ground_y
			-- avoid generating underground
			if data[area:index(x, maxp.y, z)] == c.air then
				-- search for non air node from 20 m above ground down to 5 m below ground (confined by minp and maxp)
				for y = math.min(heightmap[ni]+20, maxp.y), math.max(minp.y, heightmap[ni]-5), -1 do
					if data[area:index(x, y, z)] ~= c.air then
						ground_y = y
						break
					end
				end
			end

			if ground_y then
				local node = area:index(x, ground_y, z)
				local c_ground = data[node]

				if c_ground == c.dirt_with_grass then
					if alpine
					and test > nosmooth_rarity then
						snow_tab[num] = {ground_y, z, x, test}
						num = num+1
						-- generate stone ground
						for y = ground_y, math.max(-6, minp.y-6), -1 do
							local vi = area:index(x, y, z)
							if data[vi] == c.stone then
								break
							end
							data[vi] = c.stone
						end
					elseif pines
					and pr:next(1,36) == 1 then
						pines_tab[pnum] = {x=x, y=ground_y+1, z=z}
						pnum = pnum+1
					elseif shrubs
					and pr:next(1,928) == 1 then
						data[node] = c.dirt_with_snow
						data[area:index(x, ground_y+1, z)] = c.dry_shrub
					else
						if snowy
						or test > smooth_rarity_max then
							-- more, deeper snow
							data[node] = c.snow_block
						else
							data[node] = c.dirt_with_snow
						end
						snow_tab[num] = {ground_y, z, x, test}
						num = num+1
					end
				elseif c_ground == c.water then
					if not icesheet
					and not icecave
					and not icehole then
						local nds = {
							data[area:index(x+1, ground_y, z)],
							data[area:index(x, ground_y, z+1)],
							data[area:index(x+1, ground_y, z+1)],
							data[area:index(x-1, ground_y, z-1)],
							data[area:index(x-1, ground_y, z)],
							data[area:index(x, ground_y, z-1)],
						}
						local ice
						if pr:next(1,4) == 1
						and (cool or icebergs) then
							for _,i in ipairs(nds) do
								if i == c.ice then
									ice = true
									break
								end
							end
						end
						if not ice then
							for _,i in ipairs(nds) do
								if i ~= c.water
								and i ~= c.ice
								and i ~= c.air
								and i ~= c.ignore then
									ice = true
									break
								end
							end
						end
						local y = data[area:index(x, ground_y-1, z)]
						if ice
						or (y ~= c.water and y ~= c.ice) -- and y ~= "air") …I don't think y can be a string here ~HybridDog
						or (icebergs and pr:next(1,6) == 1) then
							data[node] = c.ice
						end
					else
						if icesheet
						or icecave
						or (icehole and pr:next(1,10) > 1) then
							data[node] = c.ice
						end
						if icecave then
							for y = ground_y-1, -33, -1 do
								local vi = area:index(x, y, z)
								if data[vi] ~= c.water then
									break
								end
								data[vi] = c.air
							end
						end
						if icesheet then
							-- put snow onto icesheets
							snow_tab[num] = {ground_y, z, x, test}
							num = num+1
						end
					end
				elseif c_ground == c.sand then
					if icy then
						data[node] = c.ice
					end
					snow_tab[num] = {ground_y, z, x, test}
					num = num+1
				elseif c_ground == c.papyrus then
					snow_tab[num] = {ground_y, z, x, test}
					num = num+1
					-- replace papyrus plants with snowblocks
					local y = ground_y
					for _ = 1,7 do
						local vi = area:index(x, y, z)
						if data[vi] == c.papyrus then
							data[vi] = c.snow_block
							y = y-1
						else
							break
						end
					end
				elseif alpine then
					-- make stone pillars out of trees and other stuff
					for y = ground_y, math.max(-6, minp.y-6), -1 do
						local stone = area:index(x, y, z)
						if data[stone] == c.stone then
							break
						end
						data[stone] = c.stone
					end
					-- put snow onto it
					snow_tab[num] = {ground_y, z, x, test}
					num = num+1
				elseif c_ground ~= c.desert_sand then
					if is_snowable(c_ground) then
						-- put snow onto it
						snow_tab[num] = {ground_y, z, x, test}
						num = num+1
					end
					for y = 0, 12 do
						y = ground_y-y
						local vi = area:index(x, y, z)
						local nd = data[vi]
						local plantlike = is_plantlike(nd)
						if replacements[nd] then
							data[vi] = replacements[nd]
							if plantlike then
								param2s[vi] = pr:next(0,179)
							end
						elseif nd == c.dirt_with_grass then
							data[vi] = c.dirt_with_snow
							break
						elseif plantlike then
							local under = area:index(x, y-1, z)
							if data[under] == c.dirt_with_grass then
								-- replace other plants with shrubs
								data[vi] = c.snow_shrub
								param2s[vi] = pr:next(0,179)
								data[under] = c.dirt_with_snow
								break
							end
						elseif nd == c.stone then
							break
						end
					end
				end
			end
		end
		ni = ni + 1
	end
	end

	-- abort if mapgen doesn't change sth
	if not nodes_added then
		return
	end

	-- try to fix oom memory crashes
	minetest.after(0, collectgarbage)

	if num ~= 1 then
		for _,i in pairs(snow_tab) do
			-- set snow
			data[area:index(i[3], i[1]+1, i[2])] = c.snow
		end
		for _,i in pairs(snow_tab) do
			local y,z,x,test = unpack(i)
			test = (test-nosmooth_rarity)/(1-nosmooth_rarity) -- /(1-0.53)
			if test > 0 then
				local maxh = math.floor(test*10)%10+1
				if maxh ~= 1 then
					local h = math.floor(get_ws_value(2, x) + get_ws_value(5, z)*5)%10+1
					if h ~= 1 then
						-- search for nearby snow
						y = y+1
						for i = -1,1,2 do
							for _,cord in pairs({{x+i,z}, {x,z+i}}) do
								local nd = data[area:index(cord[1], y, cord[2])]
								if nd == c.air
								or is_plantlike(nd) then
									h = h/2
								end
							end
						end
						h = math.floor(h+0.5)
						if h > 1 then
							-- make snowdrifts walkable
							if h == 10 then
								h = 5
							end
							h = math.min(maxh, h)
							local vi = area:index(x, y, z)
							if h == 9 then
								-- replace the snow with a snowblock because its a full node
								data[vi] = c.snow_block
							else
								-- set a specific snow height
								param2s[vi] = h*7
							end
						end
					end
				end
			end
		end
	end

	-- spawn pines
	if pines
	and pnum ~= 1 then
		local spawn_pine = snow.voxelmanip_pine
		for _,pos in pairs(pines_tab) do
			spawn_pine(pos, area, data)
		end
	end

	vm:set_data(data)
	vm:set_param2_data(param2s)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map()

	if write_to_map
	and mg_debug then -- print if any column of mapchunk was snow biome
		local biome_string = biome_to_string(biome)
		local chugent = math.ceil((os.clock() - t1) * 1000)
		print("[snow] "..biome_string.." x "..minp.x.." z "..minp.z.." time "..chugent.." ms")
	end
end)


-- Debugging function

local biome_strings = {
	{"snowy", "plain", "alpine", "normal", "normal"},
	{"cool", "icebergs", "icesheet", "icecave", "icehole"}
}
function biome_to_string(num,num2)
	local biome = biome_strings[1][num] or "unknown "..num
	return biome
end

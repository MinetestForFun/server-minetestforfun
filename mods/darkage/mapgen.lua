--[[
	This file generates:
	darkage:mud
	darkage:silt
	darkage:chalk
	darkage:ors
	darkage:shale
	darkage:slate
	darkage:schist
	darkage:basalt
	darkage:marble
	darkage:serpentine
	darkage:gneiss
--]]

local getID = minetest.get_content_id

local function generate_stratus(data, varea, name, wherein, ceilin, ceil, minp, maxp, seed, stratus_chance, radius, radius_y, deep, height_min, height_max)
	local c_ore = getID(name)
	local c_wherein = {}
	local c_ceilin = {}
	for k, v in ipairs(wherein) do
		c_wherein[k] = getID(v)
	end
	for k, v in ipairs(ceilin) do
		c_ceilin[k] = getID(v)
	end
	local c_ceil
	if ceil then
		c_ceil = getID(ceil)
	end
	
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local stratus_per_volume = 1
	local area = 45
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = ((maxp.x-minp.x+1)/area)*((y_max-y_min+1)/area)*((maxp.z-minp.z+1)/area)
	local pr = PseudoRandom(seed)
	local blocks = math.floor(stratus_per_volume*volume)
	print("  <<"..dump(name)..">>");
	if blocks == 0 then
		blocks = 1
	end
	print("    blocks: "..dump(blocks).." in vol: "..dump(volume).." ("..dump(maxp.x-minp.x+1)..","..dump(y_max-y_min+1)..","..dump(maxp.z-minp.z+1)..")")
	for i=1,blocks do
		local x = pr:next(1,stratus_chance)
		if x == 1 then
			local y0=y_max-radius_y+1
			if y0 < y_min then
				y0=y_min
			else
				y0=pr:next(y_min, y0)
			end
			local x0 = maxp.x-radius+1
			if x0 < minp.x then
				x0 = minp.x
			else
				x0 = pr:next(minp.x, x0)
			end
			local z0 = maxp.z-radius+1
			if z0 < minp.z then
				x0 = minp.z
			else
				z0 = pr:next(minp.z, z0)
			end
			local p0 = {x=x0, y=y0, z=z0}
			local n = data[varea:indexp(p0)]
			local i = 0
			x = 0
			for k, v in ipairs(c_ceilin) do
				if n == v then
					x = 1
					break
				end
			end
			if x == 1 then
				for y1=y0-1,y_min,-1 do
					p0.y=y1
					n = data[varea:indexp(p0)]
					x = 0
					for k, v in ipairs(c_wherein) do
						if n == v then
							x = 1
							break
						end
					end
					if x == 1 then
						y0=y1-deep
						if y0 < y_min then
							y0 = y_min
						end
						break
					end
				end
				local rx=pr:next(radius/2,radius)+1
				local rz=pr:next(radius/2,radius)+1
				local ry=pr:next(radius_y/2,radius_y)+1
				for x1=0,rx do
					rz = rz + 3 - pr:next(1,6)
					if rz < 1 then
						rz = 1
					end
					for z1=pr:next(1,3),rz do
						local ry0=ry+ pr:next(1,3)
						for y1=pr:next(1,3),ry0 do
							local x2 = x0+x1
							local y2 = y0+y1
							local z2 = z0+z1
							local p2 = {x=x2, y=y2, z=z2}
							n = data[varea:indexp(p2)]
							x = 0
								for k, v in ipairs(c_wherein) do
									if n == v then
										x = 1
										break
									end
							end
							if x == 1 then
								if c_ceil == nil then
									data[varea:indexp(p2)] = c_ore
									i = i +1
								else
									local p3 = {p2.x,p2.y+1,p2}
									if data[varea:indexp(p3)] == c_ceil then
										data[varea:indexp(p2)] = c_ore
										i = i +1
									end
								end
							end
						end
					end
				end
				print("    generated "..dump(i).." blocks in ("..dump(x0)..","..dump(y0)..","..dump(z0)..")")
			end
		end
	end
end

local function generate_claylike(data, varea, name, minp, maxp, seed, chance, minh, maxh, dirt)
	local c_ore = getID(name)
	local c_sand = getID("default:sand")
	local c_dirt = getID("default:dirt")
	local c_lawn = getID("default:dirt_with_grass")
	local c_water = getID("default:water_source")
	local c_air = getID("air")

	if maxp.y >= maxh+1 and minp.y <= minh-1 then
	local pr = PseudoRandom(seed)
	local divlen = 4
	local divs = (maxp.x-minp.x)/divlen+1;
		for yy=minh,maxh do
			local x = pr:next(1,chance)
			if x == 1 then
				for divx=0+1,divs-1-1 do
					for divz=0+1,divs-1-1 do
						local cx = minp.x + math.floor((divx+0.5)*divlen)
						local cz = minp.z + math.floor((divz+0.5)*divlen)
						local up = data[varea:index(cx,yy,cz)]
						local down = data[varea:index(cx,yy-1,cz)]
						if ( up == c_water or up == c_air ) and ( down == c_sand or (dirt == 1 and (down == c_dirt or down == c_lawn ))) then
							local is_shallow = true
							local num_water_around = 0
							if data[varea:index(cx-divlen*2,yy,cz)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx+divlen*2,yy,cz)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx,yy,cz-divlen*2)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx,yy,cz+divlen*2)] == c_water then
								num_water_around = num_water_around + 1
							end
							if num_water_around >= 3 then
								is_shallow = false
							end	
							if is_shallow then
								for x1=-divlen,divlen do
									for z1=-divlen,divlen do
										local p={x=cx+x1,y=yy-1,z=cz+z1}
										down = data[varea:indexp(p)]
										if down == c_sand or (dirt == 1 and (down == c_dirt or down == c_lawn)) then
											data[varea:indexp(p)] = c_ore
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end


local function generate_ore(data, varea, name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	local c_ore = getID(name)
	local c_wherein = getID(wherein)

	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
				for y1=0,chunk_size-1 do
					for z1=0,chunk_size-1 do
						if pr:next(1,inverse_chance) == 1 then
							local x2 = x0+x1
							local y2 = y0+y1
							local z2 = z0+z1
							local p2 = {x=x2, y=y2, z=z2}
							local indexp2 = varea:indexp(p2)
							if data[indexp2] == c_wherein then
								data[indexp2] = c_ore
							end
						end
					end
				end
			end
		end
	end
end

function darkage_mapgen(data, area, minp, maxp, seed) -- public function, to be used by Lua mapgens
	if minp.y < -19600 then return end
	local t1 = os.clock()
	generate_claylike(data, area, "darkage:mud", minp, maxp, seed+1, 4, 0, 2, 0)
	generate_claylike(data, area, "darkage:silt", minp, maxp, seed+2, 4, -1, 1, 1)
	generate_stratus(data, area, "darkage:chalk",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+3, 4, 25, 8, 0, -20,  50)
	generate_stratus(data, area, "darkage:ors",
				{"default:stone"},
				{"default:stone","air","default:water_source"}, nil,
				minp, maxp, seed+4, 4, 25, 7, 50, -200,  500)
	generate_stratus(data, area, "darkage:shale",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+5, 4, 23, 7, 50, -50,  20)
	generate_stratus(data, area, "darkage:slate",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+6, 6, 23, 5, 50, -500, 0)
	generate_stratus(data, area, "darkage:schist",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+7, 6, 19, 6, 50, -31000, -10)
	generate_stratus(data, area, "darkage:basalt",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+8, 5, 20, 5, 20, -31000, -50)
	generate_stratus(data, area, "darkage:marble",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+9, 4, 25, 6, 50, -31000,  -75)
	generate_stratus(data, area, "darkage:serpentine",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+10, 4, 28, 8, 50, -31000,  -350)
	generate_stratus(data, area, "darkage:gneiss",
				{"default:stone"},
				{"default:stone","air"}, nil,
				minp, maxp, seed+11, 4, 15, 5, 50, -31000, -250)
	print("DARKAGE: calculating time : " .. os.clock() - t1)
end

minetest.register_on_mapgen_init(function(mgparams)
	if mgparams.mgname ~= "singlenode" then
		minetest.register_on_generated(function(minp, maxp, seed)
			if minp.y < -19600 then return end

			local t0 = os.clock()
			local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
			local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
			local data = vm:get_data()

			darkage_mapgen(data, area, minp, maxp, seed)

			vm:set_data(data)
			vm:write_to_map()
			print("DARKAGE: total time taken : " .. os.clock() - t0)
		end)
	end
end)

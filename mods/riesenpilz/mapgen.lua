local c
local function define_contents()
	c = {
		air = minetest.get_content_id("air"),
		stone = minetest.get_content_id("default:stone"),
		dirt = minetest.get_content_id("default:dirt"),
		desert_sand = minetest.get_content_id("default:desert_sand"),

		dry_shrub = minetest.get_content_id("default:dry_shrub"),

		ground = minetest.get_content_id("riesenpilz:ground"),
		riesenpilz_brown = minetest.get_content_id("riesenpilz:brown"),
		riesenpilz_red = minetest.get_content_id("riesenpilz:red"),
		riesenpilz_fly_agaric = minetest.get_content_id("riesenpilz:fly_agaric"),
		riesenpilz_lavashroom = minetest.get_content_id("riesenpilz:lavashroom"),
		riesenpilz_glowshroom = minetest.get_content_id("riesenpilz:glowshroom"),
		riesenpilz_parasol = minetest.get_content_id("riesenpilz:parasol"),

		GROUND = {},
		TREE_STUFF = {
			minetest.get_content_id("default:tree"),
			minetest.get_content_id("default:leaves"),
			minetest.get_content_id("default:apple"),
			minetest.get_content_id("default:jungletree"),
			minetest.get_content_id("default:jungleleaves"),
			minetest.get_content_id("default:junglegrass"),
		},
		USUAL_STUFF = {
			minetest.get_content_id("default:cactus"),
			minetest.get_content_id("default:papyrus"),
		},
	}
	for name,data in pairs(minetest.registered_nodes) do
		local groups = data.groups
		if groups then
			if groups.crumbly == 3
			or groups.soil == 1 then
				table.insert(c.GROUND, minetest.get_content_id(name))
			end
		end
	end
end


local function find_ground(a,list)
	for _,nam in ipairs(list) do
		if a == nam then
			return true
		end
	end
	return false
end


local function fix_light(minp, maxp)
	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map(minp, maxp)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()

	manip:set_data(nodes)
	manip:write_to_map()
	manip:update_map()
end

local data, area
function riesenpilz_circle(nam, pos, radius, chance)
	for _,p in pairs(vector.circle(radius)) do
		if pr:next(1,chance) == 1 then
			local p = vector.add(pos, p)
			local p_p = area:indexp(p)
			if data[p_p] == c.air
			and data[area:index(p.x, p.y-1, p.z)] == c.ground then
				data[p_p] = nam
			end
		end
	end
end

local function say_info(info)
	local info = "[riesenpilz] "..info
	print(info)
	minetest.chat_send_all(info)
end

local riesenpilz_rarity = riesenpilz.mapgen_rarity
local riesenpilz_size = riesenpilz.mapgen_size
local smooth_trans_size = riesenpilz.smooth_trans_size

local nosmooth_rarity = 1-riesenpilz_rarity/50
local perlin_scale = riesenpilz_size*100/riesenpilz_rarity
local smooth_rarity_max = nosmooth_rarity+smooth_trans_size*2/perlin_scale
local smooth_rarity_min = nosmooth_rarity-smooth_trans_size/perlin_scale
local smooth_rarity_dif = smooth_rarity_max-smooth_rarity_min

--local USUAL_STUFF =	{"default:leaves","default:apple","default:tree","default:cactus","default:papyrus"}

local contents_defined
minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y <= 0
	or minp.y >= 150 then --avoid generation in the sky
		return
	end

	local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
	local env = minetest.env	--Should make things a bit faster.
	local perlin1 = env:get_perlin(51,3, 0.5, perlin_scale)	--Get map specific perlin

	if not riesenpilz.always_generate then
		local biome_allowed
		for x = x0, x1, 16 do
			for z = z0, z1, 16 do
				if perlin1:get2d({x=x, y=z}) > nosmooth_rarity then
					biome_allowed = true
					break
				end
			end
		end
		if not biome_allowed then
			return
		end
	end

	--[[if not (perlin1:get2d({x=x0, y=z0}) > 0.53) and not (perlin1:get2d({x=x1, y=z1}) > 0.53)
	and not (perlin1:get2d({x=x0, y=z1}) > 0.53) and not (perlin1:get2d({x=x1, y=z0}) > 0.53)
	and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) then

	if not riesenpilz.always_generate
	and not ( perlin1:get2d( {x=x0, y=z0} ) > nosmooth_rarity ) 					--top left
	and not ( perlin1:get2d( { x = x0 + ( (x1-x0)/2), y=z0 } ) > nosmooth_rarity )--top middle
	and not (perlin1:get2d({x=x1, y=z1}) > nosmooth_rarity) 						--bottom right
	and not (perlin1:get2d({x=x1, y=z0+((z1-z0)/2)}) > nosmooth_rarity) 			--right middle
	and not (perlin1:get2d({x=x0, y=z1}) > nosmooth_rarity)  						--bottom left
	and not (perlin1:get2d({x=x1, y=z0}) > nosmooth_rarity)						--top right
	and not (perlin1:get2d({x=x0+((x1-x0)/2), y=z1}) > nosmooth_rarity) 			--left middle
	and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > nosmooth_rarity) 			--middle
	and not (perlin1:get2d({x=x0, y=z1+((z1-z0)/2)}) > nosmooth_rarity) then		--bottom middle
		return
	end]]

	local t1 = os.clock()
	riesenpilz.inform("tries to generate a giant mushroom biome at: x=["..minp.x.."; "..maxp.x.."]; y=["..minp.y.."; "..maxp.y.."]; z=["..minp.z.."; "..maxp.z.."]", 2)

	if not contents_defined then
		define_contents()
		contents_defined = true
	end

	local divs = (maxp.x-minp.x);
	local num = 1
	local tab = {}
	pr = PseudoRandom(seed+68)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	data = vm:get_data()
	area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for p_pos in area:iterp(minp, maxp) do	--remove tree stuff
		local d_p_pos = data[p_pos]
		for _,nam in ipairs(c.TREE_STUFF) do
			if d_p_pos == nam then
				data[p_pos] = c.air
				break
			end
		end
	end
		--[[remove usual stuff
		local trees = env:find_nodes_in_area(minp, maxp, USUAL_STUFF)
		for i,v in pairs(trees) do
			env:remove_node(v)
		end]]


	local smooth = riesenpilz.smooth

	for j=0,divs do
		for i=0,divs do
			local x,z = x0+i,z0+j

			--Check if we are in a "riesenpilz biome"
			local in_biome = false
			local test = perlin1:get2d({x=x, y=z})
			--smooth mapgen
			if riesenpilz.always_generate then
				in_biome = true
			elseif smooth then
				if test >= smooth_rarity_max
				or (
					test > smooth_rarity_min
					and pr:next(1, 1000) <= ((test-smooth_rarity_min)/smooth_rarity_dif)*1000
				) then
					in_biome = true
				end
			elseif (not smooth)
			and test > nosmooth_rarity then
				in_biome = true
			end

			if in_biome then

				for b = minp.y,maxp.y,1 do	--remove usual stuff
					local p_pos = area:index(x, b, z)
					local d_p_pos = data[p_pos]
					for _,nam in ipairs(c.USUAL_STUFF) do
						if d_p_pos == nam then
							data[p_pos] = c.air
							break
						end
					end
				end

				local ground_y = nil --Definition des Bodens:
--				for y=maxp.y,0,-1 do
				for y=maxp.y,1,-1 do
					if find_ground(data[area:index(x, y, z)], c.GROUND) then
						ground_y = y
						break
					end
				end
				if ground_y then
					local p_ground = area:index(x, ground_y, z)
					local p_boden = area:index(x, ground_y+1, z)
					local d_p_ground = data[p_ground]
					local d_p_boden = data[p_boden]

					data[p_ground] = c.ground
					for i = -1,-5,-1 do
						local p_pos = area:index(x, ground_y+i, z)
						local d_p_pos = data[p_pos]
						if d_p_pos == c.desert_sand then
							data[p_pos] = c.dirt
						else
							break
						end
					end
					local boden = {x=x,y=ground_y+1,z=z}
					if pr:next(1,15) == 1 then
						data[p_boden] = c.dry_shrub
					elseif pr:next(1,80) == 1 then
						riesenpilz_circle(c.riesenpilz_brown, boden, pr:next(3,4), 3)
					elseif pr:next(1,85) == 1 then
						riesenpilz_circle(c.riesenpilz_parasol, boden, pr:next(3,5), 3)
					elseif pr:next(1,90) == 1 then
						riesenpilz_circle(c.riesenpilz_red, boden, pr:next(4,5), 3)
					elseif pr:next(1,100) == 1 then
						riesenpilz_circle(c.riesenpilz_fly_agaric, boden, 4, 3)
					elseif pr:next(1,4000) == 1 and maxp.y <= -200 then -- Modif MFF
						riesenpilz_circle(c.riesenpilz_lavashroom, boden, pr:next(5,6), 3)
					elseif pr:next(1,5000) == 1 then
						riesenpilz_circle(c.riesenpilz_glowshroom, boden, 3, 3)
					--[[elseif pr:next(1,80) == 1 then
						env:add_node(boden, {name="riesenpilz:brown"})
					elseif pr:next(1,90) == 1 then
						env:add_node(boden, {name="riesenpilz:red"})
					elseif pr:next(1,100) == 1 then
						env:add_node(boden, {name="riesenpilz:fly_agaric"})
					elseif pr:next(1,4000) == 1 then
						env:add_node(boden, {name="riesenpilz:lavashroom"})
					elseif pr:next(1,5000) == 1 then
						env:add_node(boden, {name="riesenpilz:glowshroom"})]]
					elseif pr:next(1,380) == 1 then
						tab[num] = {1, boden}
						num = num+1
					elseif pr:next(1,340) == 10 then
						tab[num] = {2, boden}
						num = num+1
					elseif pr:next(1,390) == 20 then
						tab[num] = {3, boden}
						num = num+1
					elseif pr:next(1,6000) == 2 and pr:next(1,200) == 15 then
						tab[num] = {4, boden}
						num = num+1
					elseif pr:next(1,800) == 7 then
						tab[num] = {5, boden}
						num = num+1
					end
				end
			end
		end
	end
	vm:set_data(data)
	vm:write_to_map()
	riesenpilz.inform("ground finished", 2, t1)

	local t2 = os.clock()
	local single_map_update = #tab > 3
	if single_map_update then
		riesenpilz.vm_update = false
	end
	for _,v in pairs(tab) do
		local p = v[2]
		local m = v[1]
		if m == 1 then
			riesenpilz_hybridpilz(p)
		elseif m == 2 then
			riesenpilz_brauner_minecraftpilz(p)
		elseif m == 3 then
			riesenpilz_minecraft_fliegenpilz(p)
		elseif m == 4 then
			riesenpilz_lavashroom(p)
		elseif m == 5 then
			riesenpilz_parasol(p)
		end
	end
	if single_map_update then
		riesenpilz.vm_update = true
		fix_light(minp, maxp)
	end
	riesenpilz.inform("giant shrooms generated", 2, t2)

	riesenpilz.inform("done", 1, t1)
end)
--[[	if maxp.y < -10 then
		local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
		local env = minetest.env	--Should make things a bit faster.
		local perlin1 = env:get_perlin(11,3, 0.5, 200)	--Get map specific perlin

		--[if not (perlin1:get2d({x=x0, y=z0}) > 0.53) and not (perlin1:get2d({x=x1, y=z1}) > 0.53)
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53) and not (perlin1:get2d({x=x1, y=z0}) > 0.53)
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) then]
		if not ( perlin1:get2d( {x=x0, y=z0} ) > 0.53 ) 					--top left
		and not ( perlin1:get2d( { x = x0 + ( (x1-x0)/2), y=z0 } ) > 0.53 )--top middle
		and not (perlin1:get2d({x=x1, y=z1}) > 0.53) 						--bottom right
		and not (perlin1:get2d({x=x1, y=z0+((z1-z0)/2)}) > 0.53) 			--right middle
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53)  						--bottom left
		and not (perlin1:get2d({x=x1, y=z0}) > 0.53)						--top right
		and not (perlin1:get2d({x=x0+((x1-x0)/2), y=z1}) > 0.53) 			--left middle
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) 			--middle
		and not (perlin1:get2d({x=x0, y=z1+((z1-z0)/2)}) > 0.53) then		--bottom middle
			print("abortriesenpilz")
			return
		end
		local divs = (maxp.x-minp.x);
		local pr = PseudoRandom(seed+68)

		for j=0,divs do
			for i=0,divs do
				local x,z = x0+i,z0+j

				for y=minp.y,maxp.y,1 do
					local pos = {x=x, y=y, z=z}

					if env:get_node(pos).name == "air"
					and env:get_node({x=x, y=y-1, z=z}).name == "default:stone"
					and pr:next(1,40) == 33
					and env:find_node_near(pos, 4, "group:igniter")
					and not env:find_node_near(pos, 3, "group:igniter") then
						env:add_node(pos, {name="riesenpilz:lavashroom"})
					end
				end
			end
		end
	end
end)]]

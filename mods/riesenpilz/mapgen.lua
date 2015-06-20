local c
local function define_contents()
	c = {
		ignore = minetest.get_content_id("ignore"),
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
	for i = 1,#list do
		if a == list[i] then
			return true
		end
	end
	return false
end


local data, area
function riesenpilz_circle(nam, pos, radius, chance)
	for _,p in pairs(vector.circle(radius)) do
		if pr:next(1,chance) == 1 then
			local p = vector.add(pos, p)
			local p_p = area:indexp(p)
			if (data[p_p] == c.air or data[p_p] == c.ignore)
			and find_ground(data[area:index(p.x, p.y-1, p.z)], c.GROUND) then
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
			if biome_allowed then
				break
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

				local ground_y = nil --Definition des Bodens:
--				for y=maxp.y,0,-1 do
				for y=maxp.y,1,-1 do
					local p_pos = area:index(x, y, z)
					local d_p_pos = data[p_pos]
					for _,nam in pairs(c.USUAL_STUFF) do --remove usual stuff
						if d_p_pos == nam then
							data[p_pos] = c.air
							p_pos = nil
							break
						end
					end
					if p_pos --else search ground_y
					and find_ground(d_p_pos, c.GROUND) then
						ground_y = y
						break
					end
				end
				if ground_y then
					data[area:index(x, ground_y, z)] = c.ground
					for i = -1,-5,-1 do
						local p_pos = area:index(x, ground_y+i, z)
						if data[p_pos] == c.desert_sand then
							data[p_pos] = c.dirt
						else
							break
						end
					end
					local boden = {x=x,y=ground_y+1,z=z}
					if pr:next(1,15) == 1 then
						data[area:index(x, ground_y+1, z)] = c.dry_shrub
					elseif pr:next(1,80) == 1 then
						riesenpilz_circle(c.riesenpilz_brown, boden, pr:next(3,4), 3)
					elseif pr:next(1,85) == 1 then
						riesenpilz_circle(c.riesenpilz_parasol, boden, pr:next(3,5), 3)
					elseif pr:next(1,90) == 1 then
						riesenpilz_circle(c.riesenpilz_red, boden, pr:next(4,5), 3)
					elseif pr:next(1,100) == 1 then
						riesenpilz_circle(c.riesenpilz_fly_agaric, boden, 4, 3)
					elseif pr:next(1,4000) == 1 then
						riesenpilz_circle(c.riesenpilz_lavashroom, boden, pr:next(5,6), 3)
					elseif pr:next(1,5000) == 1 then
						riesenpilz_circle(c.riesenpilz_glowshroom, boden, 3, 3)
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
	riesenpilz.inform("ground finished", 2, t1)

	local param2s
	if num ~= 1 then
		local t2 = os.clock()
		for _,v in pairs(tab) do
			local p = v[2]
			local m = v[1]
			if m == 1 then
				riesenpilz.red(p, data, area)
			elseif m == 2 then
				riesenpilz.brown(p, data, area)
			elseif m == 3 then
				if not param2s then
					param2s = vm:get_param2_data()
				end
				riesenpilz.fly_agaric(p, data, area, param2s)
			elseif m == 4 then
				riesenpilz.lavashroom(p, data, area)
			elseif m == 5 then
				riesenpilz.parasol(p, data, area)
			end
		end
		riesenpilz.inform("giant shrooms generated", 2, t2)
	end

	local t2 = os.clock()
	vm:set_data(data)
	if param2s then
		vm:set_param2_data(param2s)
	end
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map()
	riesenpilz.inform("data set", 2, t2)

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

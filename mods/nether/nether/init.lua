-- Nether Mod (based on Nyanland by Jeija, Catapult by XYZ, and Livehouse by neko259)
-- lkjoel (main developer, code, ideas, textures)
-- == CONTRIBUTERS ==
-- jordan4ibanez (code, ideas, textures)
-- Gilli (code, ideas, textures, mainly for the Glowstone)
-- Death Dealer (code, ideas, textures)
-- LolManKuba (ideas, textures)
-- IPushButton2653 (ideas, textures)
-- Menche (textures)
-- sdzen (ideas)
-- godkiller447 (ideas)
-- If I didn't list you, please let me know!

local load_time_start = os.clock()

if not rawget(_G, "nether") then
	nether = {}
end

--== EDITABLE OPTIONS ==--

--says some information.
nether.info = true

-- tell everyone about the generation
nether.inform_all = minetest.is_singleplayer()

--1:<a bit of information> 2:<acceptable amount of information> 3:<lots of text>
nether.max_spam = 2

-- Depth of the nether
local nether_middle = -20000

-- forest bottom perlin multiplication
local f_bottom_scale = 4

-- forest bottom height
local f_h_min = nether_middle+10

-- forest top height
local f_h_max = f_h_min+250

-- Frequency of trees in the nether forest (higher is less frequent)
local tree_rarity = 200

-- Frequency of glowflowers in the nether forest (higher is less frequent)
local glowflower_rarity = 120

-- Frequency of nether grass in the nether forest (higher is less frequent)
local grass_rarity = 2

-- Frequency of nether mushrooms in the nether forest (higher is less frequent)
local mushroom_rarity = 80

-- Frequency of trees in the nether forest (higher is less frequent)
local tree_rarity = 200

local abm_tree_interval = 864
local abm_tree_chance = 100

-- height of the nether generation's end
nether.start = f_h_max+100

-- Height of the nether (bottom of the nether is nether_middle - NETHER_HEIGHT)
local NETHER_HEIGHT = 30

-- Maximum amount of randomness in the map generation
NETHER_RANDOM = 2

-- Frequency of Glowstone on the "roof" of the Nether (higher is less frequent)
local GLOWSTONE_FREQ_ROOF = 500

-- Frequency of lava (higher is less frequent)
local LAVA_FREQ = 100

local nether_structure_freq = 350
local NETHER_SHROOM_FREQ = 100

-- Maximum height of lava
--LAVA_HEIGHT = 2
-- Frequency of Glowstone on lava (higher is less frequent)
--GLOWSTONE_FREQ_LAVA = 2
-- Height of nether structures
--NETHER_TREESIZE = 2
-- Frequency of apples in a nether structure (higher is less frequent)
--NETHER_APPLE_FREQ = 5
-- Frequency of healing apples in a nether structure (higher is less frequent)
--NETHER_HEAL_APPLE_FREQ = 10
-- Start position for the Throne of Hades (y is relative to the bottom of the nether)
--HADES_THRONE_STARTPOS = {x=0, y=1, z=0}
-- Spawn pos for when the nether hasn't been loaded yet (i.e. no portal in the nether) (y is relative to the bottom of the nether)
--NETHER_SPAWNPOS = {x=0, y=5, z=0}
-- Structure of the nether portal (all is relative to the nether portal creator block)

--== END OF EDITABLE OPTIONS ==--

if nether.info then
	function nether:inform(msg, spam, t)
		if spam <= self.max_spam then
			local info
			if t then
				info = string.format("[nether] "..msg.." after ca. %.2fs", os.clock() - t)
			else
				info = "[nether] "..msg
			end
			minetest.log("action", info)
			if self.inform_all then
				minetest.chat_send_all(info)
			end
		end
	end
else
	function nether:inform()
	end
end


local path = minetest.get_modpath("nether")
dofile(path.."/weird_mapgen_noise.lua")
dofile(path.."/items.lua")
--dofile(path.."/furnace.lua")
dofile(path.."/pearl.lua")

local function table_contains(t, v)
	for _,i in pairs(t) do
		if i == v then
			return true
		end
	end
	return false
end

-- Weierstrass function stuff from https://github.com/slemonide/gen
local SIZE = 1000
local ssize = math.ceil(math.abs(SIZE))
local function do_ws_func(depth, a, x)
	local n = x/(16*SIZE)
	local y = 0
	for k=1,depth do
		y = y + math.sin(math.pi * k^a * n)/(k^a)
	end
	return SIZE*y/math.pi
end

local chunksize = minetest.setting_get("chunksize") or 5
local ws_lists = {}
local function get_ws_list(a,x)
        ws_lists[a] = ws_lists[a] or {}
        local v = ws_lists[a][x]
        if v then
                return v
        end
        v = {}
        for x=x,x + (chunksize*16 - 1) do
		local y = do_ws_func(ssize, a, x)
                v[x] = y
        end
        ws_lists[a][x] = v
        return v
end


local function dif(z1, z2)
	if z1 < 0
	and z2 < 0 then
		z1,z2 = -z1,-z2
	end
	return math.abs(z1-z2)
end

local function pymg(x1, x2, z1, z2)
	return math.max(dif(x1, x2), dif(z1, z2))
end

local function r_area(manip, width, height, pos)
	local emerged_pos1, emerged_pos2 = manip:read_from_map(
		{x=pos.x-width, y=pos.y, z=pos.z-width},
		{x=pos.x+width, y=pos.y+height, z=pos.z+width}
	)
	return VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
end

local function set_vm_data(manip, nodes, pos, t1, name, generated)
	manip:set_data(nodes)
	manip:write_to_map()
	local spam = 2
	if generated then
		spam = 3
	end
	nether:inform(name.." grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", spam, t1)
	if not generated then
		local t1 = os.clock()
		manip:update_map()
		nether:inform("map updated", spam, t1)
	end
end

local function fix_light(minp, maxp)
	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map(minp, maxp)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()
	-- MODIFICATION MADE FOR MFF ^

	manip:set_data(nodes)
	manip:write_to_map()
	manip:update_map()
end

-- Generated variables
local NETHER_BOTTOM = (nether_middle - NETHER_HEIGHT)
nether.buildings = NETHER_BOTTOM+12
local NETHER_ROOF_ABS = (nether_middle - NETHER_RANDOM)
local f_yscale_top = (f_h_max-f_h_min)/2
local f_yscale_bottom = f_yscale_top/2
--HADES_THRONE_STARTPOS_ABS = {x=HADES_THRONE_STARTPOS.x, y=(NETHER_BOTTOM + HADES_THRONE_STARTPOS.y), z=HADES_THRONE_STARTPOS.z}
--LAVA_Y = (NETHER_BOTTOM + LAVA_HEIGHT)
--HADES_THRONE_ABS = {}
--HADES_THRONE_ENDPOS_ABS = {}
--HADES_THRONE_GENERATED = minetest.get_worldpath() .. "/netherhadesthrone.txt"
--NETHER_SPAWNPOS_ABS = {x=NETHER_SPAWNPOS.x, y=(NETHER_BOTTOM + NETHER_SPAWNPOS.y), z=NETHER_SPAWNPOS.z}
--[[for i,v in ipairs(HADES_THRONE) do
	v.pos.x = v.pos.x + HADES_THRONE_STARTPOS_ABS.x
	v.pos.y = v.pos.y + HADES_THRONE_STARTPOS_ABS.y
	v.pos.z = v.pos.z + HADES_THRONE_STARTPOS_ABS.z
	HADES_THRONE_ABS[i] = v
end
local htx = 0
local hty = 0
local htz = 0
for i,v in ipairs(HADES_THRONE_ABS) do
	if v.pos.x > htx then
		htx = v.pos.x
	end
	if v.pos.y > hty then
		hty = v.pos.y
	end
	if v.pos.z > htz then
		htz = v.pos.z
	end
end
HADES_THRONE_ENDPOS_ABS = {x=htx, y=hty, z=htz}]]

local c
local function define_contents()
	c = {
		ignore = minetest.get_content_id("ignore"),
		air = minetest.get_content_id("air"),
		lava = minetest.get_content_id("default:lava_source"),
		gravel = minetest.get_content_id("default:gravel"),
		coal = minetest.get_content_id("default:stone_with_coal"),
		diamond = minetest.get_content_id("default:stone_with_diamond"),
		mese = minetest.get_content_id("default:mese"),

		glowstone = minetest.get_content_id("glow:stone"), --https://github.com/Zeg9/minetest-glow

		nether_shroom = minetest.get_content_id("riesenpilz:nether_shroom"),

		netherrack = minetest.get_content_id("nether:netherrack"),
		netherrack_tiled = minetest.get_content_id("nether:netherrack_tiled"),
		netherrack_black = minetest.get_content_id("nether:netherrack_black"),
		netherrack_blue = minetest.get_content_id("nether:netherrack_blue"),
		netherrack_brick = minetest.get_content_id("nether:netherrack_brick"),
		white = minetest.get_content_id("nether:white"),

		nether_vine = minetest.get_content_id("nether:vine"),
		blood = minetest.get_content_id("nether:blood"),
		blood_top = minetest.get_content_id("nether:blood_top"),
		blood_stem = minetest.get_content_id("nether:blood_stem"),
		nether_apple = minetest.get_content_id("nether:apple"),

		nether_tree = minetest.get_content_id("nether:tree"),
		nether_tree_corner = minetest.get_content_id("nether:tree_corner"),
		nether_leaves = minetest.get_content_id("nether:leaves"),
		nether_grass = {
			minetest.get_content_id("nether:grass_small"),
			minetest.get_content_id("nether:grass_middle"),
			minetest.get_content_id("nether:grass_big")
		},
		glowflower = minetest.get_content_id("nether:glowflower"),
		nether_dirt = minetest.get_content_id("nether:dirt"),
		nether_dirt_top = minetest.get_content_id("nether:dirt_top"),
		nether_dirt_bottom = minetest.get_content_id("nether:dirt_bottom"),
	}
end

local pr, contents_defined

local function return_nether_ore(id, glowstone)
	if glowstone
	and pr:next(0,GLOWSTONE_FREQ_ROOF) == 1 then
		return c.glowstone
	end
	if id == c.coal then
		return c.netherrack_tiled
	end
	if id == c.gravel then
		return c.netherrack_black
	end
	if id == c.diamond then
		return c.netherrack_blue
	end
	if id == c.mese then
		return c.white
	end
	return c.netherrack
end

local f_perlins = {}

--local perlin1 = minetest.get_perlin(13,3, 0.5, 50)	--Get map specific perlin
--	local perlin2 = minetest.get_perlin(133,3, 0.5, 10)
--	local perlin3 = minetest.get_perlin(112,3, 0.5, 5)
local tmp = f_yscale_top*4
local tmp2 = tmp/f_bottom_scale
local perlins = {
	{
		seed = 13,
		octaves = 3,
		persist = 0.5,
		spread = {x=50, y=50, z=50},
		scale = 1,
		offset = 0,
	},
	{
		seed = 133,
		octaves = 3,
		persist = 0.5,
		spread = {x=10, y=10, z=10},
		scale = 1,
		offset = 0,
	},
	{
		seed = 112,
		octaves = 3,
		persist = 0.5,
		spread = {x=5, y=5, z=5},
		scale = 1,
		offset = 0,
	},
	--[[forest_bottom = {
		seed = 11,
		octaves = 3,
		persist = 0.8,
		spread = {x=tmp2, y=tmp2, z=tmp2},
		scale = 1,
		offset = 0,
	},]]
	forest_top = {
		seed = 21,
		octaves = 3,
		persist = 0.8,
		spread = {x=tmp, y=tmp, z=tmp},
		scale = 1,
		offset = 0,
	},
}

local info = true
local structures_enabled = true
local vine_maxlength = math.floor(NETHER_HEIGHT/4+0.5)
-- Create the Nether
minetest.register_on_generated(function(minp, maxp, seed)
	if not (maxp.y >= NETHER_BOTTOM-100 and minp.y <= nether.start) then --avoid big map generation
		return
	end
	local addpos = {}

	local t1 = os.clock()
	nether:inform("generates at: x=["..minp.x.."; "..maxp.x.."]; y=["..minp.y.."; "..maxp.y.."]; z=["..minp.z.."; "..maxp.z.."]", 2)

	if not contents_defined then
		define_contents()
		contents_defined = true
	end

	local buildings = 0
	if maxp.y <= NETHER_BOTTOM then
		buildings = 1
	elseif minp.y <= nether.buildings then
		buildings = 2
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	pr = PseudoRandom(seed+33)
	local tab,num = {},1
	local trees,num_trees = {},1

	--local perlin1 = minetest.get_perlin(13,3, 0.5, 50)	--Get map specific perlin
	--local perlin2 = minetest.get_perlin(133,3, 0.5, 10)
	--local perlin3 = minetest.get_perlin(112,3, 0.5, 5)

	local side_length = maxp.x - minp.x + 1	-- maybe mistake here
	local map_lengths_xyz = {x=side_length, y=side_length, z=side_length}

	local pmap1 = minetest.get_perlin_map(perlins[1], map_lengths_xyz):get2dMap_flat({x=minp.x, y=minp.z})
	local pmap2 = minetest.get_perlin_map(perlins[2], map_lengths_xyz):get2dMap_flat({x=minp.x, y=minp.z})
	local pmap3 = minetest.get_perlin_map(perlins[3], map_lengths_xyz):get2dMap_flat({x=minp.x, y=minp.z})

	local forest_possible = maxp.y > f_h_min and minp.y < f_h_max

	--local pmap_f_bottom = minetest.get_perlin_map(perlins.forest_bottom, map_lengths_xyz):get2dMap_flat({x=minp.x, y=minp.z})
	local perlin_f_bottom, pmap_f_top, strassx, strassz
	if forest_possible then
		perlin_f_bottom = minetest.get_perlin(11, 3, 0.8, tmp2)
		pmap_f_top = minetest.get_perlin_map(perlins.forest_top, map_lengths_xyz):get2dMap_flat({x=minp.x, y=minp.z})
		strassx = get_ws_list(2, minp.x, side_length)
		strassz = get_ws_list(2, minp.z, side_length)
	end

	local num2, tab2
	if buildings >= 1 then
		num2 = 1
		tab2 = nether_weird_noise({x=minp.x, y=nether.buildings-(maxp.y-minp.y), z=minp.z}, pymg, 200, 8, 10, maxp.y-minp.y)
	end

	local count = 0
	for z=minp.z, maxp.z do
		for x=minp.x, maxp.x do

			count = count+1

			local test = pmap1[count]+1
			local test2 = pmap2[count]
			local test3 = math.abs(pmap3[count])

			local t = math.floor(test*3+0.5)

			local h
			if test2 < 0 then
				h = math.floor(test2*3+0.5)-1
			else
				h = 3+t+pr:next(0,NETHER_RANDOM)
			end

			local generate_vine = false
			if test3 >= 0.72+pr:next(0,NETHER_RANDOM)/10
			and pr:next(0,NETHER_RANDOM) == 1 then
				generate_vine = true
			end

			local bottom = NETHER_BOTTOM+h
			local top = nether_middle-pr:next(0,NETHER_RANDOM)+t

			local py_h = 0
			local difn, noisp, py_h_g
			if buildings >= 1 then
				py_h = tab2[num2].y
				num2 = num2+1

				difn = nether.buildings-py_h
				if difn == 5 then
					noisp = 1
				elseif difn < 5 then
					noisp = 2
				end
				py_h_g = nether.buildings-7
			end

			if buildings == 1
			and noisp then
				if noisp == 1 then
					for y=minp.y, maxp.y do
						local p_addpos = area:index(x, y, z)
						data[p_addpos] = c.netherrack_brick
					end
				else
					for y=minp.y, maxp.y do
						local p_addpos = area:index(x, y, z)
						data[p_addpos] = c.lava
					end
				end
			else

				local r_structure = pr:next(1,nether_structure_freq)
				local r_shroom = pr:next(1,NETHER_SHROOM_FREQ)
				local r_glowstone = pr:next(0,GLOWSTONE_FREQ_ROOF)
				local r_vine_length = pr:next(1,vine_maxlength)

				local f_bottom, f_top, is_forest, f_h_dirt
				if forest_possible then
					local p = {x=math.floor(x/f_bottom_scale), z=math.floor(z/f_bottom_scale)}
					local pstr = p.x.." "..p.z
					if not f_perlins[pstr] then
						f_perlins[pstr] = math.floor(f_h_min+(math.abs(perlin_f_bottom:get2d({x=p.x, y=p.z})+1))*f_yscale_bottom+0.5)
					end
					local top_noise = pmap_f_top[count]+1
					if top_noise < 0 then
						top_noise = -top_noise/10
						--nether:inform("ERROR: (perlin noise) "..pmap_f_top[count].." is not inside [-1; 1]", 1)
					end
					f_top = math.floor(f_h_max - top_noise*f_yscale_top + 0.5)
					f_bottom = f_perlins[pstr]+pr:next(0,f_bottom_scale-1)
					is_forest = f_bottom < f_top
					f_h_dirt = f_bottom-pr:next(0,1)
				end

				for y=minp.y, maxp.y do
					local p_addpos = area:index(x, y, z)
					local d_p_addp = data[p_addpos]
					--if py_h >= maxp.y-4 then
					if y <= py_h
					and noisp then
						if noisp == 1 then
							data[p_addpos] = c.netherrack_brick
						elseif noisp == 2 then
							if y == py_h then
								data[p_addpos] = c.netherrack_brick
							elseif y == py_h_g
							and pr:next(1,3) <= 2 then
								data[p_addpos] = c.netherrack
							elseif y <= py_h_g then
								data[p_addpos] = c.lava
							else
								data[p_addpos] = c.air
							end
						end
					elseif d_p_addp ~= c.air then

						if is_forest
						and y == f_bottom then
							data[p_addpos] = c.nether_dirt_top
						elseif is_forest
						and y < f_bottom
						and y >= f_h_dirt then
							data[p_addpos] = c.nether_dirt
						elseif is_forest
						and y == f_h_dirt-1 then
							data[p_addpos] = c.nether_dirt_bottom
						elseif is_forest
						and y == f_h_dirt+1 then
							if pr:next(1,tree_rarity) == 1 then
								trees[num_trees] = {x=x, y=y, z=z}
								num_trees = num_trees+1
							elseif pr:next(1,mushroom_rarity) == 1 then
								data[p_addpos] = c.nether_shroom
							elseif pr:next(1,glowflower_rarity) == 1 then
								data[p_addpos] = c.glowflower
							elseif pr:next(1,grass_rarity) == 1 then
								data[p_addpos] = c.nether_grass[pr:next(1,3)]
							else
								data[p_addpos] = c.air
							end
						elseif is_forest
						and y > f_bottom
						and y < f_top then
							if not table_contains(
								{c.nether_tree, c.nether_tree_corner, c.nether_leaves, c.nether_fruit},
								d_p_addp
							) then
								data[p_addpos] = c.air
							end
						elseif is_forest
						and y == f_top then
							local sel = math.floor(strassx[x]+strassz[z]+0.5)%10
							if sel <= 5 then
								data[p_addpos] = return_nether_ore(d_p_addp, true)
							elseif sel == 6 then
								data[p_addpos] = c.netherrack_black
							elseif sel == 7 then
								data[p_addpos] = c.glowstone
							else
								data[p_addpos] = c.air
							end

						elseif y <= NETHER_BOTTOM then
							if y <= bottom then
								data[p_addpos] = return_nether_ore(d_p_addp, true)
							else
								data[p_addpos] = c.lava
							end
						elseif r_structure == 1
						and y == bottom then
							tab[num] = {x=x, y=y-1, z=z}
							num = num+1
						elseif y <= bottom then
							if pr:next(1,LAVA_FREQ) == 1 then
								data[p_addpos] = c.lava
							else
								data[p_addpos] = return_nether_ore(d_p_addp, false)
							end
						elseif r_shroom == 1
						and r_structure ~= 1
						and y == bottom+1 then
							data[p_addpos] = c.nether_shroom
						elseif (y == top and r_glowstone == 1) then
							data[p_addpos] = c.glowstone
						elseif y >= top then
							data[p_addpos] = return_nether_ore(d_p_addp, true)
						elseif y <= top-1
						and generate_vine
						and y >= top-r_vine_length then
							data[p_addpos] = c.nether_vine
						else
							data[p_addpos] = c.air
						end
					end
				end
			end
		end
	end
	vm:set_data(data)
--	vm:set_lighting(12)
--	vm:calc_lighting()
--	vm:update_liquids()
	vm:write_to_map()

	nether:inform("nodes set", 2, t1)

	local t2 = os.clock()

	if structures_enabled then	--Trees:
		for _,v in ipairs(tab) do
			nether.grow_netherstructure(v, true)
		end
	end

	if forest_possible then	--Trees:
		for _,v in ipairs(trees) do
			nether.grow_tree(v, true)
		end
	end

	nether:inform("trees set", 2, t2)

	t2 = os.clock()
	fix_light(minp, maxp)

	nether:inform("map updated", 2, t2)

	nether:inform("done", 1, t1)
end)


function nether.grow_netherstructure(pos, generated)
	local t1 = os.clock()

	if not contents_defined then
		define_contents()
		contents_defined = true
	end

	if not pos.x then print(dump(pos))
		nether:inform("Error: "..dump(pos), 1)
		return
	end

	local height = 6
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, 2, height, pos)
	local nodes = manip:get_data()

	for i = 0, height-1 do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.blood_stem
	end

	for i = -1,1 do
		for j = -1,1 do
			nodes[area:index(pos.x+i, pos.y+height, pos.z+j)] = c.blood_top
		end
	end

	for k = -1, 1, 2 do
		for l = -2+1, 2 do
			local p1 = {pos.x+2*k, pos.y+height, pos.z-l*k}
			local p2 = {pos.x+l*k, pos.y+height, pos.z+2*k}
			local udat = c.blood_top
			if math.random(2) == 1 then
				nodes[area:index(p1[1], p1[2], p1[3])] = c.blood_top
				nodes[area:index(p2[1], p2[2], p2[3])] = c.blood_top
				udat = c.blood
			end
			nodes[area:index(p1[1], p1[2]-1, p1[3])] = udat
			nodes[area:index(p2[1], p2[2]-1, p2[3])] = udat
		end
		for l = 0, 1 do
			for _,p in ipairs({
				{pos.x+k, pos.y+height-1, pos.z-l*k},
				{pos.x+l*k, pos.y+height-1, pos.z+k},
			}) do
				if math.random(2) == 1 then
					nodes[area:index(p[1], p[2], p[3])] = c.nether_apple
				--elseif math.random(10) == 1 then
				--	nodes[area:index(p[1], p[2], p[3])] = c.apple
				end
			end
		end
	end
	set_vm_data(manip, nodes, pos, t1, "blood", generated)
end


local set = vector.set_data_to_pos
local get = vector.get_data_from_pos
local remove = vector.remove_data_from_pos

local function soft_node(id)
	return id == c.air or id == c.ignore
end

local function update_minmax(min, max, p)
	min.x = math.min(min.x, p.x)
	max.x = math.max(max.x, p.x)
	min.z = math.min(min.z, p.z)
	max.z = math.max(max.z, p.z)
end

local fruit_chances = {}
for y = -2,1 do --like a hyperbola
	fruit_chances[y] = math.floor(-4/(y-2)+0.5)
end

local dirs = {
	{-1, 0, 12, 19},
	{1, 0, 12, 13},
	{0, 1, 4},
	{0, -1, 4, 10},
}

local h_max = 26
local h_stem_min = 3
local h_stem_max = 7
local h_arm_min = 2
local h_arm_max = 6
local r_arm_min = 1
local r_arm_max = 5
local fruit_rarity = 25 --a bigger number results in less fruits
local leaf_thickness = 3 --a bigger number results in more blank trees

local h_trunk_max = h_max-h_arm_max

function nether.grow_tree(pos, generated)
	local t1 = os.clock()

	if not contents_defined then
		define_contents()
		contents_defined = true
	end

	local min = vector.new(pos)
	local max = vector.new(pos)
	min.y = min.y-1
	max.y = max.y+h_max

	local trunks = {}
	local trunk_corners = {}
	local h_stem = math.random(h_stem_min, h_stem_max)
	local todo,n = {{x=pos.x, y=pos.y+h_stem, z=pos.z}},1
	while n do
		local p = todo[n]
		todo[n] = nil
		n = next(todo)

		local used_dirs,u = {},1
		for _,dir in pairs(dirs) do
			if math.random(1,2) == 1 then
				used_dirs[u] = dir
				u = u+1
			end
		end
		if not used_dirs[1] then
			local dir1 = math.random(4)
			local dir2 = math.random(3)
			if dir1 <= dir2 then
				dir2 = dir2+1
			end
			used_dirs[1] = dirs[dir1]
			used_dirs[2] = dirs[dir2]
		end
		for _,dir in pairs(used_dirs) do
			local p = vector.new(p)
			local r = math.random(r_arm_min, r_arm_max)
			for j = 1,r do
				local x = p.x+j*dir[1]
				local z = p.z+j*dir[2]
				set(trunks, z,p.y,x, dir[3])
			end
			r = r+1
			p.x = p.x+r*dir[1]
			p.z = p.z+r*dir[2]
			set(trunk_corners, p.z,p.y,p.x, dir[4] or dir[3])
			local h = math.random(h_arm_min, h_arm_max)
			for i = 1,h do
				set(trunks, p.z,p.y+i,p.x, true)
			end
			p.y = p.y+h
			--n = #todo+1 -- caused small trees
			todo[#todo+1] = p
		end
		if p.y > pos.y+h_trunk_max then
			break
		end

		n = n or next(todo)
	end
	local leaves = {}
	local fruits = {}
	local trunk_ps = {}
	local count = 0
	local ps, trmin, trmax, trunk_count = vector.get_data_pos_table(trunks)

	update_minmax(min, max, trmin)
	update_minmax(min, max, trmax)

	for _,d in pairs(ps) do
		if d[4] == true then
			d[4] = nil
		end
		trunk_ps[#trunk_ps+1] = d
		local pz, py, px = unpack(d)
		count = count+1
		if count > leaf_thickness then
			count = 0
			for y = -2,2 do
				local fruit_chance = fruit_chances[y]
				for z = -2,2 do
					for x = -2,2 do
						local distq = x*x+y*y+z*z
						if distq ~= 0
						and math.random(1, math.sqrt(distq)) == 1 then
							local x = x+px
							local y = y+py
							local z = z+pz
							if not get(trunks, z,y,x) then
								if fruit_chance
								and math.random(1, fruit_rarity) == 1
								and math.random(1, fruit_chance) == 1 then
									set(fruits, z,y,x, true)
								else
									set(leaves, z,y,x, true)
								end
								update_minmax(min, max, {x=x, z=z})
							end
						end
					end
				end
			end
		end
	end

	for i = -1,h_stem+1 do
		trunk_ps[#trunk_ps+1] = {pos.z, pos.y+i, pos.x, 0} -- par 0 because of leaves
	end

	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map(min, max)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()
	local param2s = manip:get_param2_data()

	for _,p in pairs(vector.get_data_pos_table(leaves)) do
		p = area:index(p[3], p[2], p[1])
		if soft_node(nodes[p]) then
			nodes[p] = c.nether_leaves
			param2s[p] = math.random(0,179)
			--param2s[p] = math.random(0,44)
		end
	end

	for _,p in pairs(vector.get_data_pos_table(fruits)) do
		p = area:index(p[3], p[2], p[1])
		if soft_node(nodes[p]) then
			nodes[p] = c.nether_apple
		end
	end

	for _,p in pairs(trunk_ps) do
		local par = p[4]
		p = area:index(p[3], p[2], p[1])
		if par then
			param2s[p] = par
		end
		nodes[p] = c.nether_tree
	end

	for _,p in pairs(vector.get_data_pos_table(trunk_corners)) do
		local vi = area:index(p[3], p[2], p[1])
		nodes[vi] = c.nether_tree_corner
		param2s[vi] = p[4]
	end

	manip:set_data(nodes)
	manip:set_param2_data(param2s)
	manip:write_to_map()
	local spam = 2
	if generated then
		spam = 3
	end
	nether:inform("a nether tree with "..trunk_count.." branch trunk nodes grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", spam, t1)
	if not generated then
		local t1 = os.clock()
		manip:update_map()
		nether:inform("map updated", spam, t1)
	end
end


--abms

minetest.register_abm({
	nodenames = {"nether:sapling"},
	neighbors = {"nether:blood_top"},
	interval = 20,
	chance = 8,
	action = function(pos)
		local under = {x=pos.x, y=pos.y-1, z=pos.z}
		if minetest.get_node_light(pos) < 4
		and minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air"
		and minetest.get_node(under).name == "nether:blood_top" then
			nether.grow_netherstructure(under)
		end
	end
})

minetest.register_abm({
	nodenames = {"nether:tree_sapling"},
	neighbors = {"group:nether_dirt"},
	interval = abm_tree_interval,
	chance = abm_tree_chance,
	action = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name == "air"
		and minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			local udata = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name]
			if udata
			and udata.groups
			and udata.groups.nether_dirt then
				nether.grow_tree(pos)
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"nether:netherrack_soil"},
	neighbors = {"air"},
	interval = 20,
	chance = 20,
	action = function(pos, node)
		local par2 = node.param2
		if par2 == 0 then
			return
		end
		pos.y = pos.y+1
		if (minetest.get_node_light(pos) or 16) > 7 then --mushrooms grow at dark places
			return
		end
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="riesenpilz:nether_shroom"})
			pos.y = pos.y-1
			minetest.set_node(pos, {name="nether:netherrack_soil", param2=par2-1})
		end
	end
})

local function grass_allowed(pos)
	local nd = minetest.get_node(pos).name
	if nd == "air" then
		return true
	end
	if nd == "ignore" then
		return 0
	end
	local data = minetest.registered_nodes[nd]
	local drawtype = data.drawtype
	if drawtype
	and drawtype ~= "normal"
	and drawtype ~= "liquid"
	and drawtype ~= "flowingliquid" then
		return true
	end
	local light = data.light_source
	if light
	and light > 0 then
		return true
	end
	return false
end

minetest.register_abm({
	nodenames = {"nether:dirt"},
	interval = 20,
	chance = 9,
	action = function(pos)
		local allowed = grass_allowed({x=pos.x, y=pos.y+1, z=pos.z})
		if allowed == 0 then
			return
		end
		if allowed then
			minetest.set_node(pos, {name="nether:dirt_top"})
		end
	end
})

minetest.register_abm({
	nodenames = {"nether:dirt_top"},
	interval = 30,
	chance = 9,
	action = function(pos)
		local allowed = grass_allowed({x=pos.x, y=pos.y+1, z=pos.z})
		if allowed == 0 then
			return
		end
		if not allowed then
			minetest.set_node(pos, {name="nether:dirt"})
		end
	end
})


minetest.register_privilege("nether", "Allows sending players to nether and extracting them")

dofile(path.."/crafting.lua")
dofile(path.."/portal.lua")
dofile(path.."/guide.lua")


local time = math.floor(tonumber(os.clock()-load_time_start)*100+0.5)/100
local msg = "[nether] loaded after ca. "..time
if time > 0.05 then
	minetest.log("warning", msg)
else
	minetest.log("info", msg)
end

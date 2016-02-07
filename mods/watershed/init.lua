-- watershed 0.6.6 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default stairs bucket
-- License: code WTFPL, textures CC BY-SA

-- re-add z=1 for z component of 2D noisemap size to fix crashes

-- Parameters

local YMIN = -33000 -- Approximate base of realm stone
local YMAX = 33000 -- Approximate top of atmosphere / mountains / floatlands
local TERCEN = -128 -- Terrain zero level, average seabed
local YWAT = 1 -- Sea surface y
local YSAV = 5 -- Average sandline y, dune grasses above this
local SAMP = 3 -- Sandline amplitude
local YCLOMIN = 207 -- Minimum height of mod clouds
local CLOUDS = true -- Mod clouds?

local TERSCA = 512 -- Vertical terrain scale
local XLSAMP = 0.1 -- Extra large scale height variation amplitude
local BASAMP = 0.3 -- Base terrain amplitude
local MIDAMP = 0.1 -- Mid terrain amplitude
local CANAMP = 0.4 -- Canyon terrain maximum amplitude
local ATANAMP = 1.1 -- Arctan function amplitude, smaller = more and larger floatlands above ridges
local BLENEXP = 2 -- Terrain blend exponent

local TSTONE = 0.02 -- Density threshold for stone, depth of soil at TERCEN
local TRIVER = -0.028 -- Densitybase threshold for river surface
local TRSAND = -0.035 -- Densitybase threshold for river sand
local TSTREAM = -0.004 -- Densitymid threshold for stream surface
local TSSAND = -0.005 -- Densitymid threshold for stream sand
local TLAVA = 2 -- Maximum densitybase threshold for lava, small because grad is non-linear
local TFIS = 0.01 -- Fissure threshold, controls width
local TSEAM = 0.2 -- Seam threshold, width of seams
local ORESCA = 512 -- Seam system vertical scale
local ORETHI = 0.002 -- Ore seam thickness tuner
local BERGDEP = 32 -- Maximum iceberg depth
local TFOG = -0.04 -- Fog top densitymid threshold

local HITET = 0.35 -- High temperature threshold
local LOTET = -0.35 -- Low ..
local ICETET = -0.7 -- Ice ..
local HIHUT = 0.35 -- High humidity threshold
local LOHUT = -0.35 -- Low ..
local FOGHUT = 1.0 -- Fog ..
local BLEND = 0.02 -- Biome blend randomness

local flora = {
	PINCHA = 36, -- Pine tree 1/x chance per node
	APTCHA = 36, -- Appletree
	FLOCHA = 289, -- Flower
	GRACHA = 36, -- Grassland grasses
	JUTCHA = 16, -- Jungletree
	JUGCHA = 16, -- Junglegrass
	CACCHA = 800, -- Cactus
	CACCHA_DRYGRASS = 1600,
	DRYCHA = 150, -- Dry shrub
	ACACHA = 1369, -- Acacia tree
	GOGCHA = 9, -- Golden grass
	PAPCHA = 4, -- Papyrus
	DUGCHA = 16, -- Dune grass
}

local np = {
-- pack it in a single table to avoid "function has more than 60 upvalues"

-- 3D noises

-- 3D noise for terrain

terrain = {
	offset = 0,
	scale = 1,
	spread = {x=384, y=192, z=384},
	seed = 593,
	octaves = 5,
	persist = 0.67
},

-- 3D noise for fissures

fissure = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=512, z=256},
	seed = 20099,
	octaves = 5,
	persist = 0.5
},

-- 3D noise for ore seam networks

seam = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -992221,
	octaves = 2,
	persist = 0.5
},

-- 3D noise for rock strata inclination

strata = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 92219,
	octaves = 3,
	persist = 0.5
},

-- 3D noises for caves, from Valleys Mapgen mod by Gael-de-Sailly

cave1 = {
	offset = 0,
	scale = 1,
	spread = {x = 32, y = 32, z = 32},
	seed = -4640,
	octaves = 4,
	persist = 0.5
},

cave2 = {
	offset = 0,
	scale = 1,
	seed = 8804,
	spread = {x = 32, y = 32, z = 32},
	octaves = 4,
	persist = 0.5
},

cave3 = {
	offset = 0,
	scale = 1,
	seed = -4780,
	spread = {x = 32, y = 32, z = 32},
	octaves = 4,
	persist = 0.5
},

cave4 = {
	offset = 0,
	scale = 1,
	seed = -9969,
	spread = {x = 32, y = 32, z = 32},
	octaves = 4,
	persist = 0.5
},

-- 2D noises

-- 2D noise for mid terrain / streambed height

mid = {
	offset = 0,
	scale = 1,
	spread = {x=768, y=768, z=768},
	seed = 85546,
	octaves = 5,
	persist = 0.5
},

-- 2D noise for base terrain / riverbed height

base = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 8890,
	octaves = 3,
	persist = 0.33
},

-- 2D noise for extra large scale height variation

xlscale = {
	offset = 0,
	scale = 1,
	spread = {x=4096, y=4096, z=4096},
	seed = -72,
	octaves = 3,
	persist = 0.33
},

-- 2D noise for magma surface

magma = {
	offset = 0,
	scale = 1,
	spread = {x=128, y=128, z=128},
	seed = -13,
	octaves = 2,
	persist = 0.5
},

-- 2D noise for temperature, the same than in Plantlife and Snowdrift

temp = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 112,
	octaves = 3,
	persist = 0.5
},

-- 2D noise for humidity

humid = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 72384,
	octaves = 4,
	persist = 0.66
},

}

-- Stuff

-- initialize 3D and 2D noise objects to nil

local nobj_terrain = nil
local nobj_fissure = nil
local nobj_seam    = nil
local nobj_strata  = nil
local nobj_cave1   = nil
local nobj_cave2   = nil
local nobj_cave3   = nil
local nobj_cave4   = nil

local nobj_mid     = nil
local nobj_base    = nil
local nobj_xlscale = nil
local nobj_magma   = nil
local nobj_temp    = nil
local nobj_humid   = nil

dofile(minetest.get_modpath("watershed").."/nodes.lua")
dofile(minetest.get_modpath("watershed").."/functions.lua")


-- Mapchunk generation function

local global_seed
function watershed_chunkgen(x0, y0, z0, x1, y1, z1, area, data)
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_water = minetest.get_content_id("default:water_source")
	local c_sand = minetest.get_content_id("default:sand")
	local c_desand = minetest.get_content_id("default:desert_sand")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_ice = minetest.get_content_id("default:ice")
	local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
	local c_jungrass = minetest.get_content_id("default:junglegrass")
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	local c_danwhi = minetest.get_content_id("flowers:dandelion_white")
	local c_danyel = minetest.get_content_id("flowers:dandelion_yellow")
	local c_rose = minetest.get_content_id("flowers:rose")
	local c_tulip = minetest.get_content_id("flowers:tulip")
	local c_geranium = minetest.get_content_id("flowers:geranium")
	local c_viola = minetest.get_content_id("flowers:viola")
	local c_stodiam = minetest.get_content_id("default:stone_with_diamond")
	local c_mese = minetest.get_content_id("default:mese")
	local c_stogold = minetest.get_content_id("default:stone_with_gold")
	local c_stocopp = minetest.get_content_id("default:stone_with_copper")
	local c_stoiron = minetest.get_content_id("default:stone_with_iron")
	local c_stocoal = minetest.get_content_id("default:stone_with_coal")
	local c_sandstone = minetest.get_content_id("default:sandstone")
	local c_gravel = minetest.get_content_id("default:gravel")
	local c_clay = minetest.get_content_id("default:clay")
	local c_grass5 = minetest.get_content_id("default:grass_5")
	local c_obsidian = minetest.get_content_id("default:obsidian")

	local c_wsfreshwater = minetest.get_content_id("watershed:freshwater")
	local c_wsmixwater = minetest.get_content_id("watershed:mixwater")
	local c_wsstone = minetest.get_content_id("watershed:stone")
	local c_wsredstone = minetest.get_content_id("watershed:redstone")
	local c_wsgrass = minetest.get_content_id("watershed:grass")
	local c_wsdrygrass = minetest.get_content_id("watershed:drygrass")
	local c_wsgoldengrass = minetest.get_content_id("watershed:goldengrass")
	local c_wsdirt = minetest.get_content_id("watershed:dirt")
	local c_wspermafrost = minetest.get_content_id("watershed:permafrost")
	local c_wslava = minetest.get_content_id("watershed:lava")
	local c_wsfreshice = minetest.get_content_id("watershed:freshice")
	local c_wscloud = minetest.get_content_id("air") -- disable clouds
	local c_wsluxore = minetest.get_content_id("watershed:luxore")
	local c_wsicydirt = minetest.get_content_id("watershed:icydirt")
	-- perlinmap stuff
	local sidelen = x1 - x0 + 1 -- chunk sidelength
	local chulensxyz = {x=sidelen, y=sidelen+2, z=sidelen} -- chunk dimensions, '+2' for overgeneration
	local chulensxz = {x=sidelen, y=sidelen, z=1} -- here x = map x, y = map z
	local minposxyz = {x=x0, y=y0-1, z=z0}
	local minposxz = {x=x0, y=z0} -- here x = map x, y = map z
	-- 3D and 2D noise objects created once on first mapchunk generation only
	nobj_terrain = nobj_terrain or minetest.get_perlin_map(np.terrain, chulensxyz)
	nobj_fissure = nobj_fissure or minetest.get_perlin_map(np.fissure, chulensxyz)
	nobj_seam    = nobj_seam    or minetest.get_perlin_map(np.seam, chulensxyz)
	nobj_strata  = nobj_strata  or minetest.get_perlin_map(np.strata, chulensxyz)
	nobj_cave1   = nobj_cave1  or minetest.get_perlin_map(np.cave1, chulensxyz)
	nobj_cave2   = nobj_cave2  or minetest.get_perlin_map(np.cave2, chulensxyz)
	nobj_cave3   = nobj_cave3  or minetest.get_perlin_map(np.cave3, chulensxyz)
	nobj_cave4   = nobj_cave4  or minetest.get_perlin_map(np.cave4, chulensxyz)

	nobj_mid     = nobj_mid     or minetest.get_perlin_map(np.mid, chulensxz)
	nobj_base    = nobj_base    or minetest.get_perlin_map(np.base, chulensxz)
	nobj_xlscale = nobj_xlscale or minetest.get_perlin_map(np.xlscale, chulensxz)
	nobj_magma   = nobj_magma   or minetest.get_perlin_map(np.magma, chulensxz)
	nobj_temp    = nobj_temp    or minetest.get_perlin_map(np.temp, chulensxyz)
	nobj_humid   = nobj_humid   or minetest.get_perlin_map(np.humid, chulensxyz)
	-- 3D and 2D perlinmaps created per mapchunk
	local nvals_terrain = nobj_terrain:get3dMap_flat(minposxyz)
	local nvals_fissure = nobj_fissure:get3dMap_flat(minposxyz)
	local nvals_seam    = nobj_seam:get3dMap_flat(minposxyz)
	local nvals_strata  = nobj_strata:get3dMap_flat(minposxyz)
	local nvals_cave1   = nobj_cave1:get3dMap_flat(minposxyz)
	local nvals_cave2   = nobj_cave2:get3dMap_flat(minposxyz)
	local nvals_cave3   = nobj_cave3:get3dMap_flat(minposxyz)
	local nvals_cave4   = nobj_cave4:get3dMap_flat(minposxyz)

	local nvals_mid     = nobj_mid:get2dMap_flat(minposxz)
	local nvals_base    = nobj_base:get2dMap_flat(minposxz)
	local nvals_xlscale = nobj_xlscale:get2dMap_flat(minposxz)
	local nvals_magma   = nobj_magma:get2dMap_flat(minposxz)
	local nvals_temp    = nobj_temp:get2dMap_flat(minposxz)
	local nvals_humid   = nobj_humid:get2dMap_flat(minposxz)
	-- ungenerated chunk below?
	local viu = area:index(x0, y0-1, z0)
	local ungen = data[viu] == c_ignore

	-- mapgen loop
	local nixyz = 1 -- 3D and 2D perlinmap indexes
	local nixz = 1
	local stable = {} -- stability table of true/false. is node supported from below by 2 stone or nodes on 2 stone?
	local under = {} -- biome table. biome number of previous fine material placed in column
	local increment_y = (x1 - x0 + 1)
	local increment_z = increment_y * (y1 - y0 + 1)
	for z = z0, z1 do -- for each xy plane progressing northwards
		for y = y0 - 1, y1 + 1 do -- for each x row progressing upwards
			local vi = area:index(x0, y, z) -- voxelmanip index for first node in this x row
			local viu = area:index(x0, y-1, z) -- index for under node
			for x = x0, x1 do -- for each node do
				local si = x - x0 + 1 -- stable, under tables index
				-- noise values for node
				local n_absterrain = math.abs(nvals_terrain[nixyz])
				local n_fissure = nvals_fissure[nixyz]
				local n_seam = nvals_seam[nixyz]
				local n_strata = nvals_strata[nixyz]
				local n_cave1 = nvals_cave1[nixyz]
				local n_cave2 = nvals_cave2[nixyz]
				local n_cave3 = nvals_cave3[nixyz]
				local n_cave4 = nvals_cave4[nixyz]

				local n_absmid = math.abs(nvals_mid[nixz])
				local n_absbase = math.abs(nvals_base[nixz])
				local n_xlscale = nvals_xlscale[nixz]
				local n_magma = nvals_magma[nixz]
				local n_temp = nvals_temp[nixz]
				local n_humid = nvals_humid[nixz]
				-- get densities
				local n_invbase = (1 - n_absbase)
				local terblen = (math.max(n_invbase, 0)) ^ BLENEXP
				local grad = math.atan((TERCEN - y) / TERSCA) * ATANAMP
				local densitybase = n_invbase * BASAMP + n_xlscale * XLSAMP + grad
				local densitymid = n_absmid * MIDAMP + densitybase
				local canexp = 0.5 + terblen * 0.5
				local canamp = terblen * CANAMP
				local density = n_absterrain ^ canexp * canamp * n_absmid + densitymid
				-- other values
				local triver = TRIVER * n_absbase -- river threshold
				local trsand = TRSAND * n_absbase -- river sand
				local tstream = TSTREAM * (1 - n_absmid) -- stream threshold
				local tssand = TSSAND * (1 - n_absmid) -- stream sand
				local tstone = TSTONE * (1 + grad) -- stone threshold
				local tlava = TLAVA * (1 - n_magma ^ 4 * terblen ^ 16 * 0.6) -- lava threshold
				local ysand = YSAV + n_fissure * SAMP + math.random() * 2 -- sandline
				local bergdep = math.abs(n_seam) * BERGDEP -- iceberg depth

				local nofis = false -- set fissure bool
				if math.abs(n_fissure) >= TFIS
				and n_cave1 ^ 2 + n_cave2 ^ 2 + n_cave3 ^ 2 + n_cave4 ^ 2 >= 0.07 then -- from Valleys Mapgen
					nofis = true
				end

				local biome = false -- select biome for node
				if n_temp < LOTET + (math.random() - 0.5) * BLEND then
					if n_humid < LOHUT + (math.random() - 0.5) * BLEND then
						biome = 1 -- tundra
					elseif n_humid > HIHUT + (math.random() - 0.5) * BLEND then
						biome = 3 -- taiga
					else
						biome = 2 -- snowy plains
					end
				elseif n_temp > HITET + (math.random() - 0.5) * BLEND then
					if n_humid < LOHUT + (math.random() - 0.5) * BLEND then
						biome = 7 -- desert
					elseif n_humid > HIHUT + (math.random() - 0.5) * BLEND then
						biome = 9 -- rainforest
					else
						biome = 8 -- savanna
					end
				else
					if n_humid < LOHUT then
						biome = 4 -- dry grassland
					elseif n_humid > HIHUT then
						biome = 6 -- deciduous forest
					else
						biome = 5 -- grassland
					end
				end

				-- overgeneration and in-chunk generation
				if y == y0 - 1 then -- node layer below chunk, initialise tables
					under[si] = 0
					if ungen then
						if nofis and density >= 0 then -- if node solid
							stable[si] = 2
						else
							stable[si] = 0
						end
					else -- scan top layer of chunk below
						local nodid = data[vi]
						if nodid == c_wsstone
						or nodid == c_wsredstone
						or nodid == c_wsdirt
						or nodid == c_wspermafrost
						or nodid == c_wsluxore
						or nodid == c_sand
						or nodid == c_desand
						or nodid == c_mese
						or nodid == c_stodiam
						or nodid == c_stogold
						or nodid == c_stocopp
						or nodid == c_stoiron
						or nodid == c_stocoal
						or nodid == c_sandstone
						or nodid == c_gravel
						or nodid == c_clay
						or nodid == c_obsidian then
							stable[si] = 2
						else
							stable[si] = 0
						end
					end
				elseif y >= y0 and y <= y1 then -- chunk
					-- add nodes and flora
					if densitybase >= tlava then -- lava
						if densitybase >= 0 then
							data[vi] = c_wslava
						end
						stable[si] = 0
						under[si] = 0
					elseif densitybase >= tlava - math.min(0.6 + density * 6, 0.6)
					and density < tstone then -- obsidian
						data[vi] = c_obsidian
						stable[si] = 1
						under[si] = 0
					elseif density >= tstone and nofis  -- stone cut by fissures
					or (density >= tstone and density < TSTONE * 1.2 and y <= YWAT) -- stone around water
					or (density >= tstone and density < TSTONE * 1.2 and densitybase >= triver ) -- stone around river
					or (density >= tstone and density < TSTONE * 1.2 and densitymid >= tstream ) then -- stone around stream
						local densitystr = n_strata * 0.25 + (TERCEN - y) / ORESCA
						local densityper = densitystr - math.floor(densitystr) -- periodic strata 'density'
						if (densityper >= 0.05 and densityper <= 0.09) -- sandstone strata
						or (densityper >= 0.25 and densityper <= 0.28)
						or (densityper >= 0.45 and densityper <= 0.47)
						or (densityper >= 0.74 and densityper <= 0.76)
						or (densityper >= 0.77 and densityper <= 0.79)
						or (densityper >= 0.84 and densityper <= 0.87)
						or (densityper >= 0.95 and densityper <= 0.98) then
							if y > -84 and (y >= -80 or math.random() > 0.5) then
								data[vi] = c_sandstone
							else
								data[vi] = c_wsstone
							end
						elseif biome == 7 and density < TSTONE * 3 then -- desert stone as surface layer
							data[vi] = c_wsredstone
						elseif math.abs(n_seam) < TSEAM then
							if densityper >= 0.55 and densityper <= 0.55 + ORETHI * 2 then
								data[vi] = c_gravel
							elseif densityper >= 0.1 and densityper <= 0.1 + ORETHI * 2 then
								data[vi] = c_wsluxore
							else
								data[vi] = c_wsstone
							end
						else
							data[vi] = c_wsstone
						end
						stable[si] = stable[si] + 1
						under[si] = 0
					elseif density >= 0 and density < tstone and stable[si] >= 2 then -- fine materials
						if y == YWAT - 2 and math.abs(n_temp) < 0.05 then -- clay
							data[vi] = c_clay
						elseif y <= ysand then -- seabed/beach/dune sand not cut by fissures
							data[vi] = c_sand
							under[si] = 10 -- beach/dunes
						elseif densitybase >= trsand + math.random() * 0.001 then -- river sand
							data[vi] = c_sand
							under[si] = 11 -- riverbank papyrus
						elseif densitymid >= tssand + math.random() * 0.001 then -- stream sand
							data[vi] = c_sand
							under[si] = 0
						elseif nofis then -- fine materials cut by fissures
							if biome == 1 then
								data[vi] = c_wspermafrost
								under[si] = 1 -- tundra
							elseif biome == 2 then
								data[vi] = c_wsdirt
								under[si] = 2 -- snowy plains
							elseif biome == 3 then
								data[vi] = c_wsdirt
								under[si] = 3 -- taiga
							elseif biome == 4 then
								data[vi] = c_wsdirt
								under[si] = 4 -- dry grassland
							elseif biome == 5 then
								data[vi] = c_wsdirt
								under[si] = 5 -- grassland
							elseif biome == 6 then
								data[vi] = c_wsdirt
								under[si] = 6 -- forest
							elseif biome == 7 then
								data[vi] = c_desand
								under[si] = 7 -- desert
							elseif biome == 8 then
								data[vi] = c_wsdirt
								under[si] = 8 -- savanna
							elseif biome == 9 then
								data[vi] = c_wsdirt
								under[si] = 9 -- rainforest
							end
						else -- fissure
							stable[si] = 0
							under[si] = 0
						end
					elseif y >= YWAT - bergdep and y <= YWAT + bergdep / 8 -- icesheet
					and n_temp < ICETET and density < tstone
					and nofis then
						data[vi] = c_ice
						under[si] = 12
						stable[si] = 0
					elseif y <= YWAT and density < tstone then -- sea water
						data[vi] = c_water
						under[si] = 0
						stable[si] = 0
					elseif densitybase >= triver and density < tstone then -- river water not in fissures
						if n_temp < ICETET then
							data[vi] = c_wsfreshice
						else
							if y == YWAT + 1 then
								data[vi] = c_wsmixwater
							else
								data[vi] = c_wsfreshwater
							end
						end
						stable[si] = 0
						under[si] = 0
					elseif densitymid >= tstream and density < tstone then -- stream water not in fissures
						if n_temp < ICETET then
							data[vi] = c_wsfreshice
						else
							if y == YWAT + 1 then
								data[vi] = c_wsmixwater
							else
								data[vi] = c_wsfreshwater
							end
						end
						stable[si] = 0
						under[si] = 0
					elseif density < 0 and y >= YWAT and under[si] ~= 0 then -- air above surface node
						local fnoise = n_fissure -- noise for flower colours
						if under[si] == 1 then
							data[viu] = c_wsicydirt
							if math.random(flora.DRYCHA) == 2 then
								data[vi] = c_dryshrub
							end
						elseif under[si] == 2 then
							data[viu] = c_dirtsnow
							data[vi] = c_snowblock
						elseif under[si] == 3 then
							if math.random(flora.PINCHA) == 2 then
								watershed_pinetree(x, y, z, area, data)
							else
								data[viu] = c_dirtsnow
								data[vi] = c_snowblock
							end
						elseif under[si] == 4 then
							data[viu] = c_wsdrygrass
							if math.random(flora.CACCHA_DRYGRASS) == 2 then
								watershed_cactus(x, y, z, area, data)
							elseif math.random(flora.DRYCHA) == 2 then
								data[vi] = c_dryshrub
							end
						elseif under[si] == 5 then
							data[viu] = c_wsgrass
							if math.random(flora.FLOCHA) == 2 then
								watershed_flower(data, vi, fnoise)
							elseif math.random(flora.GRACHA) == 2 then
								data[vi] = c_grass5
							end
						elseif under[si] == 6 then
							if math.random(flora.APTCHA) == 2 then
								watershed_appletree(x, y, z, area, data)
							else
								data[viu] = c_wsgrass
								if math.random(flora.FLOCHA) == 2 then
									watershed_flower(data, vi, fnoise)
								elseif math.random(flora.GRACHA) == 2 then
									data[vi] = c_grass5
								end
							end
						elseif under[si] == 7 and n_temp < HITET + 0.1 then
							if math.random(flora.CACCHA) == 2 then
								watershed_cactus(x, y, z, area, data)
							elseif math.random(flora.DRYCHA) == 2 then
								data[vi] = c_dryshrub
							end
						elseif under[si] == 8 then
							if math.random(flora.ACACHA) == 2 then
								watershed_acaciatree(x, y, z, area, data)
							else
								data[viu] = c_wsdrygrass
								if math.random(flora.GOGCHA) == 2 then
									data[vi] = c_wsgoldengrass
								end
							end
						elseif under[si] == 9 then
							if math.random(flora.JUTCHA) == 2 then
								watershed_jungletree(x, y, z, area, data)
							else
								data[viu] = c_wsgrass
								if math.random(flora.JUGCHA) == 2 then
									data[vi] = c_jungrass
								end
							end
						elseif under[si] == 10 then -- dunes
							if math.random(flora.DUGCHA) == 2 and y > YSAV
							and biome >= 4 then
								data[vi] = c_wsgoldengrass
							end
						elseif under[si] == 11 and n_temp > HITET then -- hot biome riverbank
							if math.random(flora.PAPCHA) == 2 then
								watershed_papyrus(x, y, z, area, data)
							end
						elseif under[si] == 12
						and n_humid > LOHUT + (math.random() - 0.5) * BLEND then -- snowy iceberg
							data[vi] = c_snowblock
						end
						stable[si] = 0
						under[si] = 0
					elseif density < 0 and densitymid > TFOG and n_humid > FOGHUT then -- fog
						data[vi] = c_wscloud
						stable[si] = 0
						under[si] = 0
					elseif density < 0 and CLOUDS and y == y1 and y >= YCLOMIN then -- clouds
						local xrq = 16 * math.floor((x - x0) / 16) -- quantise to 16x16 lattice
						local zrq = 16 * math.floor((z - z0) / 16)
						local yrq = y1 - y0
						local qixyz = zrq * increment_z + yrq * increment_y + xrq + 1 -- quantised 3D index
						local qixz = zrq * increment_y + xrq + 1
						if nvals_fissure[qixyz] and math.abs(nvals_fissure[qixyz]) < nvals_humid[qixz] * 0.1 then
							data[vi] = c_wscloud
						end
						stable[si] = 0
						under[si] = 0
					else -- air
						stable[si] = 0
						under[si] = 0
					end
				elseif y == y1 + 1 then -- plane of nodes above chunk
					if density < 0 and y >= YWAT and under[si] ~= 0 then -- if air above fine materials
						if under[si] == 1 then -- add surface nodes to chunk top layer
							data[viu] = c_wsicydirt
						elseif under[si] == 2 then
							data[viu] = c_dirtsnow
							data[vi] = c_snowblock -- snowblocks in chunk above
						elseif under[si] == 3 then
							data[viu] = c_dirtsnow
							data[vi] = c_snowblock
						elseif under[si] == 4 then
							data[viu] = c_wsdrygrass
						elseif under[si] == 5 then
							data[viu] = c_wsgrass
						elseif under[si] == 6 then
							data[viu] = c_wsgrass
						elseif under[si] == 8 then
							data[viu] = c_wsdrygrass
						elseif under[si] == 9 then
							data[viu] = c_wsgrass
						end
					end
				end
				nixyz = nixyz + 1 -- increment perlinmap and voxelarea indexes along x row
				nixz = nixz + 1
				vi = vi + 1
				viu = viu + 1
			end
			nixz = nixz - sidelen
		end
		nixz = nixz + sidelen
	end

	darkage_mapgen(data, area, {x=x0, y=y0, z=z0}, {x=x1, y=y1, z=z1}, global_seed) -- Generate darkage ores
end


-- Regenerate chunk by chat command. Dependant on chunksize = 5.

minetest.register_chatcommand("regen",{
	description = "Regenerate player's current mapchunk",
	privs = {server = true, rollback = true},
	func = function(name, params)
		local t1 = os.clock()

		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		local plax = math.floor(pos.x + 0.5)
		local play = math.floor(pos.y + 0.5)
		local plaz = math.floor(pos.z + 0.5)
		local x0 = (80 * math.floor((plax + 32) / 80)) - 32
		local y0 = (80 * math.floor((play + 32) / 80)) - 32
		local z0 = (80 * math.floor((plaz + 32) / 80)) - 32
		local x1 = x0 + 79
		local y1 = y0 + 79
		local z1 = z0 + 79

		if y0 < YMIN or y1 > YMAX then
			return
		end

		print ("[watershed] regenerate mapchunk")

		local vm = minetest.get_voxel_manip()
		local pos1 = {x = x0, y = y0 - 1, z = z0}
		local pos2 = {x = x1, y = y1 + 1, z = z1}
		local emin, emax = vm:read_from_map(pos1, pos2)
		local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
		local data = vm:get_data()

		watershed_chunkgen(x0, y0, z0, x1, y1, z1, area, data)

		vm:set_data(data)
		minetest.generate_ores(vm, minp, maxp)
		minetest.generate_decorations(vm, minp, maxp)
		vm:set_lighting({day = 0, night = 0})
		vm:calc_lighting()
		vm:write_to_map()
		vm:update_map()

		local chugent = math.ceil((os.clock() - t1) * 1000)
		print ("[watershed] "..chugent.." ms")
	end
})


-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	global_seed = seed
	if minp.y < YMIN or maxp.y > YMAX then
		return
	end

	local t1 = os.clock()

	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	print ("[watershed] generate mapchunk minp ("..x0.." "..y0.." "..z0..")")

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

	watershed_chunkgen(x0, y0, z0, x1, y1, z1, area, data)

	vm:set_data(data)
	minetest.generate_ores(vm, minp, maxp)
	minetest.generate_decorations(vm, minp, maxp)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)
	vm:update_liquids()

	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[watershed] "..chugent.." ms")
end)

default.register_ores()
farming.register_mgv6_decorations()
-- cherry tree
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.005,
		spread = {x=100, y=100, z=100},
		seed = 278,
		octaves = 2,
		persist = 0.7
	},
	decoration = "default:mg_cherry_sapling",
	height = 1,
})

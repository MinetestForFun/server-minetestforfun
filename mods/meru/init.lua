-- Parameters

local COORD = false -- Print tower co-ordinates to terminal (cheat)

local XMIN = 1000 -- Area for the meru mountain spawn
local XMAX = 1000
local ZMIN = 14000
local ZMAX = 14000

local BASRAD = 64 -- Average radius at y = -32
local HEIGHT = 2048 -- Approximate height measured from y = -32
local CONVEX = 0.6 -- Convexity. <1 = concave, 1 = conical, >1 = convex
local VOID = 0.4 -- Void threshold. Controls size of central void
local NOISYRAD = 0.2 -- Noisyness of structure at base radius.
						-- 0 = smooth geometric form, 0.3 = noisy.
local NOISYCEN = 0 -- Noisyness of structure at centre
local FISOFFBAS = 0.02 -- Fissure noise offset at base,
						-- controls size of fissure entrances on outer surface.
local FISOFFTOP = 0.04 -- Fissure noise offset at top
local FISEXPBAS = 0.6 -- Fissure expansion rate under surface at base
local FISEXPTOP = 1.2 -- Fissure expansion rate under surface at top

-- 3D noise for primary structure

local np_structure = {
	offset = 0,
	scale = 1,
	spread = {x = 64, y = 64, z = 64},
	seed = 46893,
	octaves = 5,
	persist = 0.5
}

-- 3D noise for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x = 24, y = 24, z = 24},
	seed = 92940980987,
	octaves = 4,
	persist = 0.5
}

-- 2D noise for biome. Parameters must match mgv6 biome noise

local np_biome = {
	offset = 0,
	scale = 1,
	spread = {x = 250, y = 250, z = 250},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

-- Stuff

local xmid = (XMIN + XMAX) / 2
local zmid = (ZMIN + ZMAX) / 2
local xrad = xmid - XMIN
local zrad = zmid - ZMIN

local merux -- The position of the mountain is calculated on first mapgen
local meruz

local merux_min
local merux_max
local meruz_min
local meruz_max

-- Nodes

minetest.register_node("meru:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("meru:destone", {
	description = "Desert Stone",
	tiles = {"default_desert_stone.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	drop = "default:desert_stone",
	sounds = default.node_sound_stone_defaults(),
})

-- Initialize noise objects to nil

local nobj_structure = nil
local nobj_fissure = nil
local nobj_biome = nil

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if not merux and not meruz then -- on first mapgen
		local persist = math.sqrt(1.25) - 0.5 -- golden ratio - 1, solves the equation x²+x+1 = 2

		local locnoise = minetest.get_perlin(5839090, 3, persist, 1)
		local noisex = locnoise:get2d({x = 31, y = 23}) / 2
		local noisez = locnoise:get2d({x = 17, y = 11}) / 2

		merux = math.floor(xmid + noisex * xrad + 0.5)
		meruz = math.floor(zmid + noisez * zrad + 0.5)
		merux_min = merux - BASRAD
		merux_max = merux + BASRAD
		meruz_min = meruz - BASRAD
		meruz_max = meruz + BASRAD

		if COORD then
			print ("[meru] at x " .. merux .. " z " .. meruz)
		end
	end

	if minp.x > merux_max or maxp.x < merux_min or minp.z > meruz_max or maxp.z < meruz_min then
		return
	end

	local t0 = os.clock()
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()

	local c_stone = minetest.get_content_id("default:stone")
	local c_destone = minetest.get_content_id("default:desert_stone")

	local sidelen = x1 - x0 + 1
	local chulens3d = {x = sidelen, y = sidelen, z = sidelen}
	local chulens2d = {x = sidelen, y = sidelen, z = 1}
	local minpos3d = {x = x0, y = y0, z = z0}

	nobj_structure = nobj_structure or minetest.get_perlin_map(np_structure, chulens3d)
	nobj_fissure = nobj_fissure or minetest.get_perlin_map(np_fissure, chulens3d)
	nobj_biome = nobj_biome or minetest.get_perlin_map(np_biome, chulens2d)

	local nvals_structure = nobj_structure:get3dMap_flat(minpos3d)
	local nvals_fissure = nobj_fissure:get3dMap_flat(minpos3d)
	local nvals_biome = nobj_biome:get2dMap_flat({x = x0 + 150, y = z0 + 50})

	local nixyz = 1 -- 3D noise index
	local nixz = 1 -- 2D noise index
	for z = z0, z1 do
		for y = y0, y1 do
			local vi = area:index(x0, y, z)
			for x = x0, x1 do
				local n_structure = nvals_structure[nixyz]
				local radius = ((x - merux) ^ 2 + (z - meruz) ^ 2) ^ 0.5
				local deprop = (BASRAD - radius) / BASRAD -- radial depth proportion
				local noisy = NOISYRAD + deprop * (NOISYCEN - NOISYRAD)
				local heprop = ((y + 32) / HEIGHT) -- height proportion
				local offset = deprop - heprop ^ CONVEX
				local n_offstructure = n_structure * noisy + offset
				if n_offstructure > 0 and n_offstructure < VOID then
					local n_absfissure = math.abs(nvals_fissure[nixyz])
					local fisoff = FISOFFBAS + heprop * (FISOFFTOP - FISOFFBAS)
					local fisexp = FISEXPBAS + heprop * (FISEXPTOP - FISEXPBAS)
					if n_absfissure - n_offstructure * fisexp - fisoff > 0 then
						local n_biome = nvals_biome[nixz]
						local desert = n_biome > 0.45
						or math.random(0,10) > (0.45 - n_biome) * 100
						if desert then
							data[vi] = c_destone
						else
							data[vi] = c_stone
						end
					end
				end

				nixyz = nixyz + 1
				nixz = nixz + 1
				vi = vi + 1
			end
			nixz = nixz - sidelen
		end
		nixz = nixz + sidelen
	end

	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)

	local chugent = math.ceil((os.clock() - t0) * 1000)
	print ("[meru] " .. chugent .. " ms")
end)

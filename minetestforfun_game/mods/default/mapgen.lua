--
-- Aliases for map generator outputs
--


minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
minetest.register_alias("mapgen_desert_sand", "default:desert_sand")
minetest.register_alias("mapgen_dirt_with_snow", "default:dirt_with_snow")
minetest.register_alias("mapgen_snowblock", "default:snowblock")
minetest.register_alias("mapgen_snow", "default:snow")
minetest.register_alias("mapgen_ice", "default:ice")
minetest.register_alias("mapgen_sandstone", "default:sandstone")

minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")
minetest.register_alias("mapgen_pinetree", "default:pinetree")
minetest.register_alias("mapgen_pine_needles", "default:pine_needles")

minetest.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
minetest.register_alias("mapgen_mese", "default:mese")
minetest.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
minetest.register_alias("mapgen_clay", "default:clay")
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")
minetest.register_alias("mapgen_sandstonebrick", "default:sandstonebrick")
minetest.register_alias("mapgen_stair_sandstonebrick", "stairs:stair_sandstonebrick")


--
-- Register ores
--


-- Blob ore first to avoid other ores inside blobs

function default.register_ores()
	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:clay",
		wherein          = {"default:sand"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -15,
		y_max            = 0,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=-316,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:sand",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -63,
		y_max            = 4,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=2316,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:dirt",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -63,
		y_max            = 31000,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=17676,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:gravel",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -31000,
		y_max            = 31000,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=766,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "default:stone",
		clust_scarcity = 9*9*9,
		clust_num_ores = 8,
		clust_size     = 3,
		y_min          = -30000,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:desert_stone_with_coal",
		wherein        = "default:desert_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 10,
		clust_size     = 3,
		y_min          = 0,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "default:stone",
		clust_scarcity = 24*24*24,
		clust_num_ores = 27,
		clust_size     = 6,
		y_min          = -30000,
		y_max          = 0,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 11*11*11,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -15,
		y_max          = 2,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 10*10*10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -63,
		y_max     = -16,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 9*9*9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -30000,
		y_max          = -64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 25*25*25,
		clust_num_ores = 27,
		clust_size     = 6,
		y_min          = -30000,
		y_max          = -64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_mese",
		wherein        = "default:stone",
		clust_scarcity = 18*18*18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -128,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_mese",
		wherein        = "default:stone",
		clust_scarcity = 14*14*14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -1024,
		y_max          = -256,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "default:stone",
		clust_scarcity = 20*20*20,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -30000,
		y_max          = -1024,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "default:stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -1024,
		y_max          = 64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:meze",
		wherein        = "default:stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = 0,
		y_max          = 64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "default:desert_stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -1024,
		y_max          = 64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:meze",
		wherein        = "default:desert_stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = 0,
		y_max          = 64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "maptools:superapple",
		wherein        = "default:apple",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = 0,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "maptools:superapple",
		wherein        = "default:jungleleaves",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = 0,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coin",
		wherein        = "default:stone",
		clust_scarcity = 26 * 26 * 26,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = -30000,
		y_max          = 0,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_gold",
		wherein        = "default:stone",
		clust_scarcity = 15*15*15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_gold",
		wherein        = "default:stone",
		clust_scarcity = 13*13*13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -30000,
		y_max          = -256,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "default:stone",
		clust_scarcity = 17*17*17,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -512,
		y_max          = -256,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "default:stone",
		clust_scarcity = 15*15*15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -30000,
		y_max          = -512,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_copper",
		wherein        = "default:stone",
		clust_scarcity = 12*12*12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -63,
		y_max          = -16,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:desert_stone_with_copper",
		wherein        = "default:desert_stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 6,
		clust_size     = 3,
		y_min          = 0,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_copper",
		wherein        = "default:stone",
		clust_scarcity = 10*10*10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -30000,
		y_max          = -64,
		flags          = "absheight",
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "default:stone",
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 40,
		clust_size     = 4,
		y_max          = 64,
		y_min          = -30000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 48 * 48 * 48,
		clust_num_ores = 40,
		clust_size     = 4,
		y_max          = 64,
		y_min          = -30000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "default:stone",
		clust_scarcity = 30 * 30 * 30,
		clust_num_ores = 64,
		clust_size     = 5,
		y_max          = -1024,
		y_min          = -30000,
	})

	if minetest.setting_get("mg_name") == "indev" then
		-- Floatlands and high mountains springs:
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = "default:water_source",
			ore_param2     = 128,
			wherein        = "default:stone",
			clust_scarcity = 40 *40 *40,
			clust_num_ores = 8,
			clust_size     = 3,
			y_min          = 100,
			y_max          = 30000,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = "default:lava_source",
			ore_param2     = 128,
			wherein        = "default:stone",
			clust_scarcity = 50 * 50 * 50,
			clust_num_ores = 5,
			clust_size     = 2,
			y_min          = 10000,
			y_max          = 30000,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = "default:sand",
			wherein        = "default:stone",
			clust_scarcity = 20 * 20 * 20,
			clust_num_ores = 5 * 5 * 3,
			clust_size     = 5,
			y_min          = 500,
			y_max          = 30000,
		})
	end

	-- Underground springs:

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:water_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 20 * 20 * 20,
		clust_num_ores = 10,
		clust_size     = 4,
		y_min          = -10000,
		y_max          = -10,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:lava_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = -30000,
		y_max          = -100,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "default:stone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 64,
		clust_size     = 5,
		y_max          = 64,
		y_min          = -4096,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:gravel",
		wherein        = "default:stone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 64,
		clust_size     = 5,
		y_max          = 64,
		y_min          = -30000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:sand",
		wherein        = "default:stone",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 32,
		clust_size     = 4,
		y_max          = 64,
		y_min          = -1024,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:clay",
		wherein        = "default:stone",
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 32,
		clust_size     = 4,
		y_max          = 64,
		y_min          = -1024,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:cobble",
		wherein        = "default:stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 512,
		clust_size     = 9,
		y_max          = 64,
		y_min          = -4096,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:desert_cobble",
		wherein        = "default:desert_stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 512,
		clust_size     = 9,
		y_max          = 64,
		y_min          = 0,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:clay",
		wherein        = "default:sand",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 64,
		clust_size     = 5,
		y_max          = 4,
		y_min          = -8,
	})

	-- Air rooms in dirt:

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "air",
		wherein        = "default:dirt",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 200,
		clust_size     = 7,
		y_min          = -30000,
		y_max          = 64,
	})

	-- Acid lakes in gravel:

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:acid_source",
		wherein        = "default:gravel",
		clust_scarcity = 20 * 20 * 20,
		clust_num_ores = 64,
		clust_size     = 5,
		y_min          = -30000,
		y_max          = 64,
	})
end


--
-- Register biomes
--


function default.register_biomes()
	minetest.clear_registered_biomes()

	minetest.register_biome({
		name = "default:grassland",
		--node_dust = "",
		node_top = "default:dirt_with_grass",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 2,
		--node_stone = "",
		--node_water_top = "",
		--depth_water_top = ,
		--node_water = "",
		y_min = -31000,
		y_max = 31000,
		heat_point = 50,
		humidity_point = 50,
		node_underwater = "default:sand",
		height_shore = 3,
		node_shore_filler = "default:sand",
		node_shore_top = "default:sand",
	})
end


--
-- Register mgv6 decorations
--


function default.register_mgv6_decorations()

	-- Papyrus

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 8,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x=100, y=100, z=100},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		y_min = 1,
		y_max = 1,
		decoration = "default:papyrus",
		height = 2,
	        height_max = 4,
		spawn_by = "default:water_source",
		num_spawn_by = 1,
	})

	-- Cacti

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x=100, y=100, z=100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "default:cactus",
		height = 3,
	        height_max = 4,
	})

	-- Grasses

	for length = 1, 5 do
		minetest.register_decoration({
			deco_type = "simple",
			place_on = {"default:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.007,
				spread = {x=100, y=100, z=100},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			y_min = 1,
			y_max = 30,
			decoration = "default:grass_"..length,
		})
	end

	-- Dry shrubs

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand", "default:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x=100, y=100, z=100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "default:dry_shrub",
	})

	-- Cherry tree
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
end


--
-- Register decorations
--


function default.register_decorations()

	-- Flowers

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:rose",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 19822,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:tulip",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 1220999,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:dandelion_yellow",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 36662,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:geranium",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 1133,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:viola",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=100, y=100, z=100},
			seed = 73133,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:dandelion_white",
	})

	-- Grasses

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.04,
			scale = 0.08,
			spread = {x=100, y=100, z=100},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_1",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.02,
			scale = 0.08,
			spread = {x=100, y=100, z=100},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_2",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.08,
			spread = {x=100, y=100, z=100},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_3",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.08,
			spread = {x=100, y=100, z=100},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_4",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.08,
			spread = {x=100, y=100, z=100},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_5",
	})
end


--
-- Detect mapgen to select functions
--


-- Mods using singlenode mapgen can call these functions to enable
-- the use of minetest.generate_ores or minetest.generate_decorations

local mg_params = minetest.get_mapgen_params()
if mg_params.mgname == "v5" then
	default.register_biomes()
	default.register_ores()
elseif mg_params.mgname == "v6" then
	default.register_mgv6_decorations()
	default.register_ores()
elseif mg_params.mgname == "v7" then
	default.register_biomes()
	default.register_ores()
end


--
-- Generate nyan cats in all mapgens
--


-- facedir: 0/1/2/3 (head node facedir value)
-- length: length of rainbow tail
function default.make_nyancat(pos, facedir, length)
	local tailvec = {x=0, y=0, z=0}
	if facedir == 0 then
		tailvec.z = 1
	elseif facedir == 1 then
		tailvec.x = 1
	elseif facedir == 2 then
		tailvec.z = -1
	elseif facedir == 3 then
		tailvec.x = -1
	else
		--print("default.make_nyancat(): Invalid facedir: "+dump(facedir))
		facedir = 0
		tailvec.z = 1
	end
	local p = {x=pos.x, y=pos.y, z=pos.z}
	minetest.set_node(p, {name="default:nyancat", param2=facedir})
	for i=1,length do
		p.x = p.x + tailvec.x
		p.z = p.z + tailvec.z
		minetest.set_node(p, {name="default:nyancat_rainbow", param2=facedir})
	end
end


function default.generate_nyancats(minp, maxp, seed)
	local height_min = -30000
	local height_max = 30000
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed + 9324342)
	local max_num_nyancats = math.floor(volume / (15*15*15))
	for i=1,max_num_nyancats do
		if pr:next(0, 1000) == 0 then
			local x0 = pr:next(minp.x, maxp.x)
			local y0 = pr:next(minp.y, maxp.y)
			local z0 = pr:next(minp.z, maxp.z)
			local p0 = {x=x0, y=y0, z=z0}
			default.make_nyancat(p0, pr:next(0,3), 10)
		end
	end
end


minetest.register_on_generated(default.generate_nyancats)

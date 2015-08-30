minetest.register_biome({
	name           = "snow_biome_default",

	node_top       = "default:dirt_with_snow",
	depth_top      = 1,
	node_filler    = "default:dirt",
	depth_filler   = 2,

	height_min     = snow.min_height,
	height_max     = snow.min_height+60,
	heat_point     = 10.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "snow_biome_forest",

	node_top       = "default:dirt_with_snow",
	depth_top      = 1,
	node_filler    = "default:dirt",
	depth_filler   = 2,

	height_min     = snow.min_height,
	height_max     = snow.min_height+60,
	heat_point     = 10.0,
	humidity_point = 55.0,
})

minetest.register_biome({
	name           = "snow_biome_lush",

	node_top       = "default:dirt_with_snow",
	depth_top      = 1,
	node_filler    = "default:dirt",
	depth_filler   = 2,

	height_min     = snow.min_height,
	height_max     = snow.min_height+60,
	heat_point     = 10.0,
	humidity_point = 70.0,
})

minetest.register_biome({
	name           = "snow_biome_alpine",

	node_top       = "default:stone",
	depth_top      = 1,
	node_filler    = "default:stone",

	height_min     = snow.min_height+60,
	height_max     = 31000,
	heat_point     = 10.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "snow_biome_sand",

	node_top       = "default:sand",
	depth_top      = 3,
	node_filler    = "default:stone",
	depth_filler   = 0,

	height_min     = -31000,
	height_max     = 2,
	heat_point     = 10.0,
	humidity_point = 40.0,
})


--Pine tree.
minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"snow_biome_default"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"snow_biome_forest"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"snow_biome_lush"},
	schematic = minetest.get_modpath("snow").."/schematics/pine.mts",
	flags = "place_center_x, place_center_z",
})

--Dry shrubs.
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"snow_biome_default"},
	decoration = "default:dry_shrub",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"snow_biome_forest", "snow_biome_lush"},
	decoration = "default:dry_shrub",
})

--Snow.
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 10,
	biomes = {"snow_biome_default", "snow_biome_forest", "snow_biome_lush"},
	decoration = "default:snow",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:stone",
	sidelen = 16,
	fill_ratio = 10,
	biomes = {"snow_biome_alpine"},
	decoration = "default:snow",
})


moretrees.beech_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 8,
	seed_diff = 2,
	rarity = 50,
	max_count = 20,
}

moretrees.palm_biome = {
	surface = "default:sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 330,
	min_elevation = -1,
	max_elevation = 1,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = 0.25,
	temp_max = -0.15,
	rarity = 50,
	max_count = 10,
}

moretrees.date_palm_biome = {
	surface = "default:desert_sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 339,
	min_elevation = -1,
	max_elevation = 10,
	near_nodes = {"default:water_source"},
	near_nodes_size = 20,
	near_nodes_count = 100,
	near_nodes_vertical = 20,
	temp_min = -0.20,
	humidity_max = 0.20,
	rarity = 10,
	max_count = 30,
}

moretrees.date_palm_biome_2 = {
	surface = "default:desert_sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 340,
	min_elevation = 11,
	max_elevation = 30,
	near_nodes = {"default:water_source"},
	near_nodes_size = 1,
	near_nodes_count = 1,
	near_nodes_vertical = 30,
	temp_min = -0.20,
	humidity_max = 0.20,
	rarity = 10,
	max_count = 30,
}

moretrees.apple_tree_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 331,
	min_elevation = 1,
	max_elevation = 10,
	temp_min = 0.1,
	temp_max = -0.15,
	rarity = 75,
	max_count = 5,
}

moretrees.oak_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 15,
	seed_diff = 332,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 0.4,
	temp_max = 0.2,
	rarity = 50,
	max_count = 5,
}

moretrees.sequoia_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 333,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 1,
	temp_max = -0.4,
	rarity = 90,
	max_count = 5,
}

moretrees.birch_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 334,
	min_elevation = 10,
	max_elevation = 15,
	temp_min = 0.9,
	temp_max = 0.3,
	rarity = 50,
	max_count = 10,
}

moretrees.willow_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 337,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
	rarity = 75,
	max_count = 5,
}

moretrees.rubber_tree_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 338,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = -0.15,
	rarity = 75,
	max_count = 10,
}

moretrees.jungletree_biome = {
	surface = {
		"default:dirt",
		"default:dirt_with_grass",
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2"
	},
	avoid_nodes = {"moretrees:jungletree_trunk"},
	max_count = 12,
	avoid_radius = 3,
	rarity = 85,
	seed_diff = 329,
	min_elevation = 1,
	near_nodes = {"default:jungletree"},
	near_nodes_size = 6,
	near_nodes_vertical = 2,
	near_nodes_count = 1,
	plantlife_limit = -0.9,
}

moretrees.spruce_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 335,
	min_elevation = 20,
	temp_min = 0.9,
	temp_max = 0.7,
	rarity = 50,
	max_count = 5,
}

moretrees.cedar_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 336,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
	rarity = 50,
	max_count = 10,
}


-- Poplar requires a lot of water.
moretrees.poplar_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 6,
	seed_diff = 341,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_vertical = 5,
	near_nodes_count = 1,
	humidity_min = -0.7,
	humidity_max = -1,
	rarity = 50,
	max_count = 15,
}

-- The humidity requirement it quite restrictive (apparently).
-- Spawn an occasional poplar elsewhere.
moretrees.poplar_biome_2 = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 6,
	seed_diff = 341,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_vertical = 4,
	near_nodes_count = 10,
	humidity_min = 0.1,
	humidity_max = -0.6,
	rarity = 50,
	max_count = 1,
}

-- Subterranean lakes provide enough water for poplars to grow
moretrees.poplar_biome_3 = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 6,
	seed_diff = 342,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 1,
	near_nodes_vertical = 25,
	near_nodes_count = 1,
	humidity_min = -0.5,
	humidity_max = -1,
	rarity = 0,
	max_count = 30,
}

moretrees.poplar_small_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 4,
	seed_diff = 343,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 10,
	near_nodes_vertical = 5,
	near_nodes_count = 1,
	humidity_min = -0.7,
	humidity_max = -1,
	rarity = 50,
	max_count = 10,
}

moretrees.poplar_small_biome_2 = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 4,
	seed_diff = 343,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 10,
	near_nodes_vertical = 4,
	near_nodes_count = 5,
	humidity_min = 0.1,
	humidity_max = -0.6,
	rarity = 50,
	max_count = 3,
}


moretrees.fir_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	min_elevation = 25,
	temp_min = 0.9,
	temp_max = 0.3,
	rarity = 50,
	max_count = 10,
}

moretrees.fir_biome_snow = {
	surface = {"snow:dirt_with_snow", "snow:snow"},
	below_nodes = {"default:dirt", "default:dirt_with_grass", "snow:dirt_with_snow"},
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	rarity = 50,
	max_count = 10,
	check_air = false,
	delete_above = true,
	spawn_replace_node = true
}

-- Register ores

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_silver",
	wherein = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 4,
	clust_size     = 11,
	y_min     = -31000,
	y_max     = -12,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_tin",
	wherein = "default:stone",
	clust_scarcity = 7 * 7 * 7,
	clust_num_ores = 3,
	clust_size     = 7,
	y_min     = -31000,
	y_max     = 12,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_mithril",
	wherein = "default:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min     = -31000,
	y_max     = -1024,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_mithril",
	wherein = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 2,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -2048,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_mithril",
	wherein = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 5,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -4096,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "moreores:mineral_mithril",
	wherein = "default:stone",
	clust_scarcity = 28 * 28 * 28,
	clust_num_ores = 20,
	clust_size     = 7,
	y_min     = -31000,
	y_max     = -12288,
})

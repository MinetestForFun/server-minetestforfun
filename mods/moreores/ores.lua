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

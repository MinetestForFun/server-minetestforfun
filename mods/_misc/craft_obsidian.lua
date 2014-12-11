-- Craft obsidian
minetest.register_craft({
	output = "default:obsidian",
	recipe = {
		{"bucket:bucket_lava"},
	},
	replacements = {
		{"bucket:bucket_lava", "bucket:bucket_empty"}
	},
})

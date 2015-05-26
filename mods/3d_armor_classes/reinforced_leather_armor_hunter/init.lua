-- Register helmets:

minetest.register_tool(":3d_armor:helmet_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Helmet",
	inventory_image = "3d_armor_inv_helmet_reinforced_leather_hunter.png",
	groups = {armor_head = 6, armor_heal = 0, armor_use = 40},
	wear = 0,
})

-- Register chestplates:

minetest.register_tool(":3d_armor:chestplate_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Chestplate",
	inventory_image = "3d_armor_inv_chestplate_reinforced_leather_hunter.png",
	groups = {armor_torso = 10, armor_heal = 0, armor_use = 40},
	wear = 0,
})

-- Register leggings:

minetest.register_tool(":3d_armor:leggings_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Leggings",
	inventory_image = "3d_armor_inv_leggings_reinforced_leather_hunter.png",
	groups = {armor_legs = 10, armor_heal = 0, armor_use = 40},
	wear = 0,
})

-- Register boots:

	minetest.register_tool(":3d_armor:boots_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Boots",
	inventory_image = "3d_armor_inv_boots_reinforced_leather_hunter.png",
	groups = {armor_feet = 6, armor_heal = 0, armor_use = 40},
	wear = 0,
})

-- Reinforced Leather craft recipe
minetest.register_craft({
	output = "3d_armor:reinforced_leather",
	recipe = {
		{"technic:brass_ingot",		"moreores:mithril_ingot", 	"darkage:chain"		},
		{"mobs:leather", 		"mobs:minotaur_eye", 		"mobs:leather"		},
		{"darkage:chain", 		"moreores:mithril_ingot", 	"technic:brass_ingot"	},
	}
})

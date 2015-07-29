if ARMOR_MATERIALS.reinforcedleather then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_reinforcedleather", {
		description = "Hunter's Reinforced Leather Helmet (Hunter)",
		inventory_image = "3d_armor_inv_helmet_reinforcedleather.png",
		groups = {armor_head = 6, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_reinforcedleather", {
		description = "Reinforced Leather Chestplate (Hunter)",
		inventory_image = "3d_armor_inv_chestplate_reinforcedleather.png",
		groups = {armor_torso = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_reinforcedleather", {
		description = "Reinforced Leather Leggings (Hunter)",
		inventory_image = "3d_armor_inv_leggings_reinforcedleather.png",
		groups = {armor_legs = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_reinforcedleather", {
		description = "Reinforced Leather Boots (Hunter)",
		inventory_image = "3d_armor_inv_boots_reinforcedleather.png",
		groups = {armor_feet = 6, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
end

-- Reinforced Leather craft recipe
minetest.register_craft({
	output = "3d_armor:reinforcedleather",
	recipe = {
		{"technic:brass_ingot",		"moreores:mithril_ingot", 	"darkage:chain"		},
		{"mobs:leather", 		"mobs:minotaur_eye", 		"mobs:leather"		},
		{"darkage:chain", 		"moreores:mithril_ingot", 	"technic:brass_ingot"	},
	}
})

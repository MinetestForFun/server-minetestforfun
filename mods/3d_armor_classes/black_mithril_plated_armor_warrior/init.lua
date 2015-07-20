if ARMOR_MATERIALS.black_mithril then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_black_mithril_plated_warrior", {
		description = "Warrior's Black Mithril Plated Helmet",
		inventory_image = "3d_armor_inv_helmet_black_mithril_plated_warrior.png",
		groups = {armor_head = 11, armor_heal = 1, armor_use = 40},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_black_mithril_plated_warrior", {
		description = "Warrior's Black Mithril Plated Chestplate",
		inventory_image = "3d_armor_inv_chestplate_black_mithril_plated_warrior.png",
		groups = {armor_torso = 17, armor_heal = 1, armor_use = 40},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_black_mithril_plated_warrior", {
		description = "Warrior's Black Mithril Plated Leggings",
		inventory_image = "3d_armor_inv_leggings_black_mithril_plated_warrior.png",
		groups = {armor_legs = 17, armor_heal = 1, armor_use = 40},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_black_mithril_plated_warrior", {
		description = "Warrior's Black Mithril Plated Boots",
		inventory_image = "3d_armor_inv_boots_black_mithril_plated_warrior.png",
		groups = {armor_feet = 11, armor_heal = 1, armor_use = 40},
		wear = 0,
	})
end

-- Black Mithril craft recipe
minetest.register_craft({
	output = "3d_armor:black_mithril",
	recipe = {
		{"nether:white",		"mobs:dungeon_master_blood", 	"default:obsidian"	},
		{"default:mithril_ingot", 	"mobs:dungeon_master_diamond",	"default:mithril_ingot"	},
		{"default:obsidian", 		"mobs:dungeon_master_blood", 	"nether:white"		},
	}
})

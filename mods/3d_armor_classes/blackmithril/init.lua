if ARMOR_MATERIALS.blackmithril then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_blackmithril", {
		description = "Black Mithril Helmet",
		inventory_image = "3d_armor_inv_helmet_blackmithril.png",
		groups = {armor_head = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_blackmithril", {
		description = "Black Mithril Chestplate",
		inventory_image = "3d_armor_inv_chestplate_blackmithril.png",
		groups = {armor_torso = 17, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_blackmithril", {
		description = "Black Mithril Leggings",
		inventory_image = "3d_armor_inv_leggings_blackmithril.png",
		groups = {armor_legs = 17, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_blackmithril", {
		description = "Black Mithril Boots",
		inventory_image = "3d_armor_inv_boots_blackmithril.png",
		groups = {armor_feet = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
end

-- Black Mithril craft recipe
minetest.register_craft({
	output = "3d_armor:blackmithril",
	recipe = {
		{"nether:white",		"mobs:dungeon_master_blood", 	"default:obsidian"	},
		{"default:mithril_ingot", 	"mobs:dungeon_master_diamond",	"default:mithril_ingot"	},
		{"default:obsidian", 		"mobs:dungeon_master_blood", 	"nether:white"		},
	}
})

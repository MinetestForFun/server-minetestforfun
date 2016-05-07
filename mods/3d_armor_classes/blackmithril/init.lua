if ARMOR_MATERIALS.blackmithril then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_blackmithril", {
		description = "Black Mithril Helmet (Warrior)",
		inventory_image = "3d_armor_inv_helmet_blackmithril.png",
		groups = {armor_head = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_blackmithril", {
		description = "Black Mithril Chestplate (Warrior)",
		inventory_image = "3d_armor_inv_chestplate_blackmithril.png",
		groups = {armor_torso = 17, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_blackmithril", {
		description = "Black Mithril Leggings (Warrior)",
		inventory_image = "3d_armor_inv_leggings_blackmithril.png",
		groups = {armor_legs = 17, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_blackmithril", {
		description = "Black Mithril Boots (Warrior)",
		inventory_image = "3d_armor_inv_boots_blackmithril.png",
		groups = {armor_feet = 11, armor_heal = 0, armor_use = 40},
		wear = 0,
	})
end

minetest.register_craftitem(":3d_armor:blackmithril_ingot", {
	description = "Black Mithril Ingot",
	inventory_image = "3d_armor_blackmithril_ingot.png",
	stack_max = 99,
	groups = {ingot = 1}
})

-- Black Mithril craft recipe
minetest.register_craft({
	output = "3d_armor:blackmithril_ingot",
	recipe = {
		{"moreores:mithril_ingot", 			"mobs:dungeon_master_blood",	""},
		{"mobs:dungeon_master_diamond", "default:obsidian",						""},
		{"", 														"",														""}
	}
})

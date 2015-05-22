-- Register helmets:

minetest.register_tool(":3d_armor:helmet_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Helmet",
	inventory_image = "3d_armor_inv_helmet_reinforced_leather_hunter.png",
	groups = {armor_head = 10, armor_heal = 0, armor_use = 500}, 		-- Valeurs décidés, a mettre en fonction du spreadsheet
	wear = 0,
})

-- Register chestplates:

minetest.register_tool(":3d_armor:chestplate_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Chestplate",
	inventory_image = "3d_armor_inv_chestplate_reinforced_leather_hunter.png",
	groups = {armor_torso = 15, armor_heal = 0, armor_use = 500}, 		-- Valeurs décidés, a mettre en fonction du spreadsheet
	wear = 0,
})

-- Register leggings:

minetest.register_tool(":3d_armor:leggings_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Leggings",
	inventory_image = "3d_armor_inv_leggings_reinforced_leather_hunter.png",
	groups = {armor_legs = 15, armor_heal = 0, armor_use = 500}, 		-- Valeurs décidés, a mettre en fonction du spreadsheet
	wear = 0,
})

-- Register boots:

	minetest.register_tool(":3d_armor:boots_reinforced_leather_hunter", {
	description = "Hunter's Reinforced Leather Boots",
	inventory_image = "3d_armor_inv_boots_reinforced_leather_hunter.png",
		groups = {armor_feet = 10, armor_heal = 0, armor_use = 500}, 	-- Valeurs décidés, a mettre en fonction du spreadsheet
	wear = 0,
})

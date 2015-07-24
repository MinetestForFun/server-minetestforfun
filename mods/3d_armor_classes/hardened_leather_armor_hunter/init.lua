if ARMOR_MATERIALS.hardened_leather then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_hardenedleather", {
		description = "Hunter's Hardened Leather Helmet",
		inventory_image = "3d_armor_inv_helmet_hardened_leather_hunter.png",
		groups = {armor_head = 5, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_hardenedleather", {
		description = "Hunter's Hardened Leather Chestplate",
		inventory_image = "3d_armor_inv_chestplate_hardened_leather_hunter.png",
		groups = {armor_torso = 8, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_hardenedleather", {
		description = "Hunter's Hardened Leather Leggings",
		inventory_image = "3d_armor_inv_leggings_hardened_leather_hunter.png",
		groups = {armor_legs = 8, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_hardenedleather", {
		description = "Hunter's Hardened Leather Boots",
		inventory_image = "3d_armor_inv_boots_hardened_leather_hunter.png",
		groups = {armor_feet = 5, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
end

-- Hardened Leather craft recipe
minetest.register_craft({
	output = "3d_armor:hardened_leather",
	recipe = {
		{"default:steel_ingot",		"mobs:leather", 	"default:bronze_ingot"	},
		{"mobs:leather", 		"mobs:leather", 	"mobs:leather"		},
		{"default:bronze_ingot", 	"mobs:leather", 	"default:steel_ingot"	},
	}
})

if ARMOR_MATERIALS.hardenedleather then
	-- Register helmets :
	minetest.register_tool(":3d_armor:helmet_hardenedleather", {
		description = "Hardened Leather Helmet (Hunter)",
		inventory_image = "3d_armor_inv_helmet_hardenedleather.png",
		groups = {armor_head = 5, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register chestplates :
	minetest.register_tool(":3d_armor:chestplate_hardenedleather", {
		description = "Hardened Leather Chestplate (Hunter)",
		inventory_image = "3d_armor_inv_chestplate_hardenedleather.png",
		groups = {armor_torso = 8, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register leggings :
	minetest.register_tool(":3d_armor:leggings_hardenedleather", {
		description = "Hardened Leather Leggings (Hunter)",
		inventory_image = "3d_armor_inv_leggings_hardenedleather.png",
		groups = {armor_legs = 8, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
	-- Register boots :
		minetest.register_tool(":3d_armor:boots_hardenedleather", {
		description = "Hardened Leather Boots (Hunter)",
		inventory_image = "3d_armor_inv_boots_hardenedleather.png",
		groups = {armor_feet = 5, armor_heal = 0, armor_use = 250},
		wear = 0,
	})
end

minetest.register_craftitem(":3d_armor:hardenedleather", {
	description = "Hardened Leather ingot",
	inventory_image = "3d_armor_hardenedleather.png",
	stack_max = 99,
})

-- Hardened Leather craft recipe
minetest.register_craft({
	output = "3d_armor:hardenedleather",
	recipe = {
		{"default:steel_ingot",		"mobs:leather", 	"default:bronze_ingot"},
		{"mobs:leather", 					"mobs:leather", 	"mobs:leather"				},
		{"default:bronze_ingot", 	"mobs:leather", 	"default:steel_ingot"	}
	}
})

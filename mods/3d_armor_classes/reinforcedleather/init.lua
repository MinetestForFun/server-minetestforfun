if armor.materials.reinforcedleather then

	-- Register helmets
	armor:register_armor(":3d_armor:helmet_reinforcedleather", {
		description = "Reinforced Leather Helmet (Hunter)",
		inventory_image = "3d_armor_inv_helmet_reinforcedleather.png",
		groups = {armor_head = 6, armor_heal = 0, armor_use = 40},
	})
	-- Register chestplates
	armor:register_armor(":3d_armor:chestplate_reinforcedleather", {
		description = "Reinforced Leather Chestplate (Hunter)",
		inventory_image = "3d_armor_inv_chestplate_reinforcedleather.png",
		groups = {armor_torso = 11, armor_heal = 0, armor_use = 40},
	})
	-- Register leggings
	armor:register_armor(":3d_armor:leggings_reinforcedleather", {
		description = "Reinforced Leather Leggings (Hunter)",
		inventory_image = "3d_armor_inv_leggings_reinforcedleather.png",
		groups = {armor_legs = 11, armor_heal = 0, armor_use = 40},
	})
	-- Register boots
		armor:register_armor(":3d_armor:boots_reinforcedleather", {
		description = "Reinforced Leather Boots (Hunter)",
		inventory_image = "3d_armor_inv_boots_reinforcedleather.png",
		groups = {armor_feet = 6, armor_heal = 0, armor_use = 40},
	})
end

minetest.register_craftitem(":3d_armor:reinforcedleather", {
	description = "Reinforced Leather",
	inventory_image = "3d_armor_reinforcedleather.png",
	stack_max = 99,
})

-- Reinforced Leather craft recipe
minetest.register_craft({
	output = "3d_armor:reinforcedleather",
	recipe = {
		{"default:mithril_ingot",	"technic:brass_ingot",	""},
		{"darkage:chain", 					"mobs:minotaur_eye",		""},
		{"", 												"", 										""}
	}
})
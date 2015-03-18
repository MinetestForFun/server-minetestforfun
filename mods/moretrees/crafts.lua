local S = moretrees.intllib

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]

	minetest.register_craft({
		output = "moretrees:"..treename.."_trunk 2",
		recipe = {
			{"moretrees:"..treename.."_trunk_sideways"},
			{"moretrees:"..treename.."_trunk_sideways"}
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk"
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk_sideways"
		}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "moretrees:"..treename.."_sapling",
		burntime = 10,
	})
end

minetest.register_craft({
	type = "shapeless",
	output = "moretrees:rubber_tree_planks 4",
	recipe = {
		"moretrees:rubber_tree_trunk_empty"
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:moretrees_leaves",
	burntime = 1,
})

-- Food recipes!

minetest.register_craftitem("moretrees:coconut_milk", {
	description = S("Coconut Milk"),
	inventory_image = "moretrees_coconut_milk_inv.png",
	wield_image = "moretrees_coconut_milk.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("moretrees:raw_coconut", {
	description = S("Raw Coconut"),
	inventory_image = "moretrees_raw_coconut.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("moretrees:acorn_muffin_batter", {
	description = S("Acorn Muffin batter"),
	inventory_image = "moretrees_acorn_muffin_batter.png",
})

minetest.register_craftitem("moretrees:acorn_muffin", {
	description = S("Acorn Muffin"),
	inventory_image = "moretrees_acorn_muffin.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("moretrees:spruce_nuts", {
	description = S("Roasted Spruce Cone Nuts"),
	inventory_image = "moretrees_spruce_nuts.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("moretrees:pine_nuts", {
	description = S("Roasted Pine Cone Nuts"),
	inventory_image = "moretrees_pine_nuts.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("moretrees:fir_nuts", {
	description = S("Roasted Fir Cone Nuts"),
	inventory_image = "moretrees_fir_nuts.png",
	on_use = minetest.item_eat(1),
})

for i in ipairs(moretrees.cutting_tools) do
	local tool = moretrees.cutting_tools[i]
	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:coconut_milk",
		recipe = {
			"moretrees:coconut",
			"vessels:drinking_glass",
			tool
		},
		replacements = {
			{ "moretrees:coconut", "moretrees:raw_coconut" },
			{ tool, tool }
		}
	})
end

minetest.register_craft({
	type = "shapeless",
	output = "moretrees:acorn_muffin_batter",
	recipe = {
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:acorn",
		"moretrees:coconut_milk",
	},
	replacements = {
		{ "moretrees:coconut_milk", "vessels:drinking_glass" }
	}
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:acorn_muffin 4",
	recipe = "moretrees:acorn_muffin_batter",
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:spruce_nuts 4",
	recipe = "moretrees:spruce_cone",
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:pine_nuts 4",
	recipe = "moretrees:pine_cone",
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:fir_nuts 4",
	recipe = "moretrees:fir_cone",
})



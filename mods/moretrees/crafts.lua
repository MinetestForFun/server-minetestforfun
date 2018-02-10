local S = moretrees.intllib

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]

	-- MODIFICATION MADE FOR MFF //MFF(Mg|08/12/15)
	if minetest.registered_items["moretrees:" .. treename .. "_trunk_sideways"] then
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
				"moretrees:"..treename.."_trunk_sideways"
			}
		})
	end

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk"
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

minetest.register_craftitem("moretrees:date", {
	description = S("Date"),
	inventory_image = "moretrees_date.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("moretrees:date_nut_snack", {
	description = S("Date & nut snack"),
	inventory_image = "moretrees_date_nut_snack.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("moretrees:date_nut_batter", {
	description = S("Date-nut cake batter"),
	inventory_image = "moretrees_date_nut_batter.png",
})

minetest.register_craftitem("moretrees:date_nut_cake", {
	description = S("Date-nut cake"),
	inventory_image = "moretrees_date_nut_cake.png",
	on_use = minetest.item_eat(32),
})

minetest.register_craftitem("moretrees:date_nut_bar", {
	description = S("Date-nut energy bar"),
	inventory_image = "moretrees_date_nut_bar.png",
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

minetest.register_craftitem("moretrees:cedar_nuts", {
	description = S("Roasted Cedar Cone Nuts"),
	inventory_image = "moretrees_cedar_nuts.png",
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
	output = "moretrees:date_nut_snack",
	recipe = {
		"moretrees:date",
		"moretrees:date",
		"moretrees:date",
		"moretrees:spruce_nuts",
		"moretrees:cedar_nuts",
		"moretrees:fir_nuts",
	}
})

-- The date-nut cake is an exceptional food item due to its highly
-- concentrated nature (32 food units). Because of that, it requires
-- many different ingredients, and, starting from the base ingredients
-- found or harvested in nature, it requires many steps to prepare.
local flour
if minetest.registered_nodes["farming:flour"] then
	flour = "farming:flour"
else
	flour = "moretrees:acorn_muffin_batter"
end
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:date_nut_batter",
	recipe = {
		"moretrees:date_nut_snack",
		"moretrees:date_nut_snack",
		"moretrees:date_nut_snack",
		"moretrees:coconut_milk",
		"moretrees:date_nut_snack",
		"moretrees:raw_coconut",
		"moretrees:coconut_milk",
		flour,
		"moretrees:raw_coconut",
	},
	replacements = {
		{ "moretrees:coconut_milk", "vessels:drinking_glass 2" }
	}
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:date_nut_cake",
	recipe = "moretrees:date_nut_batter",
})

minetest.register_craft({
	type = "shapeless",
	output = "moretrees:date_nut_bar 8",
	recipe = {"moretrees:date_nut_cake"},
})

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
	output = "moretrees:cedar_nuts 4",
	recipe = "moretrees:cedar_cone",
})

minetest.register_craft({
	type = "cooking",
	output = "moretrees:fir_nuts 4",
	recipe = "moretrees:fir_cone",
})



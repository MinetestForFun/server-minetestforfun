local S = biome_lib.intllib

-- Basket

minetest.register_craft({
    output = "bushes:basket_empty",
    recipe = {
	{ "default:stick", "default:stick", "default:stick" },
	{ "", "default:stick", "" },
    },
})

-- Sugar

-- Use the sugar from farming redo if available
if minetest.get_modpath("farming") and farming.mod == "redo" then
	--[[ We really have nothing to do to use farming:sugar in the recipes
	     because they use the generic group group:food_sugar
	     which is added to the groups list of farming:sugar by the mod "food".
	--]]

	--Temporary alias to replace existing bushes:sugar in the world
	minetest.register_alias("bushes:sugar", "farming:sugar")

else
minetest.register_craftitem(":bushes:sugar", {
    description = S("Sugar"),
    inventory_image = "bushes_sugar.png",
    on_use = minetest.item_eat(1),
	groups = {food_sugar=1}
})

minetest.register_craft({
    output = "bushes:sugar 1",
    recipe = {
	{ "default:papyrus", "default:papyrus" },
    },
})
end

for i, berry in ipairs(bushes_classic.bushes) do
	local desc = bushes_classic.bushes_descriptions[i]

	minetest.register_craftitem(":bushes:"..berry.."_pie_raw", {
		description = S("Raw "..desc.." pie"),
		inventory_image = "bushes_"..berry.."_pie_raw.png",
		on_use = minetest.item_eat(4),
	})

	if berry ~= "mixed_berry" then

		if berry == "strawberry" and minetest.registered_nodes["farming_plus:strawberry"] then
			-- Special case for strawberries, when farming_plus is in use. Use
			-- the item from that mod, but redefine it so it has the right
			-- groups and does't look so ugly!
			minetest.register_craftitem(":farming_plus:strawberry_item", {
				description = S("Strawberry"),
				inventory_image = "bushes_"..berry..".png",
				on_use = minetest.item_eat(2),
				groups = {berry=1, strawberry=1}
			})
			minetest.register_alias("bushes:strawberry", "farming_plus:strawberry_item")
		else
			minetest.register_craftitem(":bushes:"..berry, {
				description = desc,
				inventory_image = "bushes_"..berry..".png",
				groups = {berry = 1, [berry] = 1},
				on_use = minetest.item_eat(1),
			})
		end
		minetest.register_craft({
			output = "bushes:"..berry.."_pie_raw 1",
			recipe = {
			{ "group:food_sugar", "farming:flour", "group:food_sugar" },
			{ "group:"..berry, "group:"..berry, "group:"..berry },
			},
		})
	end

	-- Cooked pie

	minetest.register_craftitem(":bushes:"..berry.."_pie_cooked", {
		description = S("Cooked "..desc.." pie"),
		inventory_image = "bushes_"..berry.."_pie_cooked.png",
		on_use = minetest.item_eat(6),
	})

	minetest.register_craft({
		type = "cooking",
		output = "bushes:"..berry.."_pie_cooked",
		recipe = "bushes:"..berry.."_pie_raw",
		cooktime = 30,
	})

	-- slice of pie

	minetest.register_craftitem(":bushes:"..berry.."_pie_slice", {
		description = S("Slice of "..desc.." pie"),
		inventory_image = "bushes_"..berry.."_pie_slice.png",
		on_use = minetest.item_eat(1),
	})

	minetest.register_craft({
		output = "bushes:"..berry.."_pie_slice 6",
		recipe = {
		{ "bushes:"..berry.."_pie_cooked" },
		},
	})

	-- Basket with pies

	minetest.register_craft({
		output = "bushes:basket_"..berry.." 1",
		recipe = {
		{ "bushes:"..berry.."_pie_cooked", "bushes:"..berry.."_pie_cooked", "bushes:"..berry.."_pie_cooked" },
		{ "", "bushes:basket_empty", "" },
		},
	})
end

minetest.register_craft({
	output = "bushes:mixed_berry_pie_raw 2",
	recipe = {
	{ "group:food_sugar", "farming:flour", "group:food_sugar" },
	{ "group:berry", "group:berry", "group:berry" },
	{ "group:berry", "group:berry", "group:berry" },
	},
})



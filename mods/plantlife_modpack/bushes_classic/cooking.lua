-- support for i18n
local S = plantlife_i18n.gettext

-- Basket

minetest.register_craft({
	output = "bushes:basket_empty",
	recipe = {
		{ "default:stick", "default:stick", "default:stick" },
		{ "", "default:stick", "" },
	},
})

-- Sugar

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

for i, berry in ipairs(bushes_classic.bushes) do

	minetest.register_craftitem(":bushes:"..berry.."_pie_raw", {
		description = bushes_classic.bushes_descriptions[i][2],
		inventory_image = "bushes_"..berry.."_pie_raw.png",
		on_use = minetest.item_eat(4),
	})

	if berry ~= "mixed_berry" then

		-- Special case for strawberries, blueberries and raspberries
		-- when farming_plus or farming redo is in use. Use items
		-- from these mods, but redefine there so they has the right
		-- groups and does't look so ugly!

		if berry == "strawberry" and minetest.registered_nodes["farming_plus:strawberry"] then
			minetest.register_craftitem(":farming_plus:strawberry_item", {
				description = bushes_classic.bushes_descriptions[i][1],
				inventory_image = "bushes_"..berry..".png",
				on_use = minetest.item_eat(2),
				groups = {berry=1, strawberry=1}
			})
			minetest.register_alias("bushes:strawberry", "farming_plus:strawberry_item")

		elseif berry == "blueberry" and minetest.registered_items["farming:blueberries"] then
			minetest.register_craftitem(":farming:blueberries", {
				description = bushes_classic.bushes_descriptions[i][1],
				inventory_image = "bushes_"..berry..".png",
				on_use = minetest.item_eat(1),
				groups = {berry=1, blueberry=1}
			})
			minetest.register_alias("bushes:blueberry", "farming:blueberries")

		elseif berry == "raspberry" and minetest.registered_items["farming:raspberries"] then
			minetest.register_craftitem(":farming:raspberries", {
				description = bushes_classic.bushes_descriptions[i][1],
				inventory_image = "bushes_"..berry..".png",
				on_use = minetest.item_eat(1),
				groups = {berry=1, raspberry=1}
			})
			minetest.register_alias("bushes:raspberry", "farming:raspberries")

		else
			minetest.register_craftitem(":bushes:"..berry, {
				description = bushes_classic.bushes_descriptions[i][1],
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
		description = bushes_classic.bushes_descriptions[i][3],
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
		description = bushes_classic.bushes_descriptions[i][4],
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

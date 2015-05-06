-- FOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> food_basic/ingredients.lua
-- Fallback ingredients
-- =====================================

-- Boilerplate to support localized strings if intllib mod is installed.
local S = 0
if rawget(_G, "intllib") then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end

food.module("wheat", function()
	minetest.register_craftitem(":food:wheat", {
		description = S("Wheat"),
		inventory_image = "food_wheat.png",
		groups = {food_wheat=1}
	})

	food.craft({
		output = "food:wheat",
		recipe = {
			{"default:dry_shrub"},
		}
	})
end, true)

food.module("flour", function()
	minetest.register_craftitem(":food:flour", {
		description = S("Flour"),
		inventory_image = "food_flour.png",
		groups = {food_flour = 1}
	})
	food.craft({
		output = "food:flour",
		recipe = {
			{"group:food_wheat"},
			{"group:food_wheat"}
		}
	})
end, true)

food.module("potato", function()
	minetest.register_craftitem(":food:potato", {
		description = S("Potato"),
		inventory_image = "food_potato.png",
		groups = {food_potato = 1}
	})
	food.craft({
		output = "food:potato",
		recipe = {
			{"default:dirt"},
			{"default:apple"}

		}
	})
end, true)

food.module("orange", function()
	minetest.register_craftitem(":food:orange", {
		description = S("Orange"),
		inventory_image = "food_orange.png",
		groups = {food_orange = 1}
	})
	food.craft({
		output = "food:orange",
		recipe = {
			{"", "default:desert_sand", ""},
			{"default:desert_sand", "default:desert_sand", "default:desert_sand"},
			{"", "default:desert_sand", ""}
		}
	})
end, true)

food.module("tomato", function()
	minetest.register_craftitem(":food:tomato", {
		description = S("Tomato"),
		inventory_image = "food_tomato.png",
		groups = {food_tomato = 1}
	})
	food.craft({
		output = "food:tomato",
		recipe = {
			{"", "default:desert_sand", ""},
			{"default:desert_sand", "", "default:desert_sand"},
			{"", "default:desert_sand", ""}
		}
	})
end, true)

food.module("carrot", function()
	minetest.register_craftitem(":food:carrot", {
		description = S("Carrot"),
		inventory_image = "food_carrot.png",
		groups = {food_carrot=1},
		on_use = food.item_eat(3)
	})
	food.craft({
		output = "food:carrot",
		recipe = {
			{"default:apple", "default:apple", "default:apple"},
		}
	})
end, true)

food.module("milk", function()
	minetest.register_craftitem(":food:milk", {
		description = S("Milk"),
		image = "food_milk.png",
		on_use = food.item_eat(1),
		groups = { eatable=1, food_milk = 1 },
		stack_max=10
	})
	food.craft({
		output = "food:milk",
		recipe = {
			{"default:sand"},
			{"bucket:bucket_water"}
		},
		replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
	})
end, true)

food.module("egg", function()
	minetest.register_craftitem(":food:egg", {
		description = S("Egg"),
		inventory_image = "food_egg.png",
		groups = {food_egg=1}
	})
	food.craft({
		output = "food:egg",
		recipe = {
			{"", "default:sand", ""},
			{"default:sand", "", "default:sand"},
			{"", "default:sand", ""}
		}
	})
end, true)

food.module("cocoa", function()
	minetest.register_craftitem(":food:cocoa", {
		description = S("Cocoa Bean"),
		inventory_image = "food_cocoa.png",
		groups = {food_cocoa=1}
	})
	food.craft({
		output = "food:cocoa",
		recipe = {
			{"", "default:apple", ""},
			{"default:apple", "", "default:apple"},
			{"", "default:apple", ""}
		}
	})
end, true)

food.module("meat", function()
	minetest.register_craftitem(":food:meat", {
		description = S("Venison"),
		inventory_image = "food_meat.png",
		groups = {food_meat=1, food_chicken=1}
	})
	food.craft({
		type = "cooking",
		output = "food:meat",
		recipe = "group:food_meat_raw",
		cooktime = 30
	})

	if not minetest.get_modpath("animalmaterials") then
		minetest.register_craftitem(":food:meat_raw", {
			description = S("Raw meat"),
			image = "food_meat_raw.png",
			on_use = food.item_eat(1),
			groups = { meat=1, eatable=1, food_meat_raw=1 },
			stack_max=25
		})
		food.craft({
			output = "food:meat_raw",
			recipe = {
				{"default:apple"},
				{"default:dirt"}
			}
		})
	end
end, true)

food.module("sugar", function()
	minetest.register_craftitem(":food:sugar", {
		description = S("Sugar"),
		inventory_image = "food_sugar.png",
		groups = {food_sugar=1}
	})

	minetest.register_craft({
		output = "food:sugar 20",
		recipe = {
			{"default:papyrus"},
		}
	})
end, true)

food.module("chocolate_powder", function()
	minetest.register_craftitem(":food:chocolate_powder", {
		description = S("Chocolate Powder"),
		inventory_image = "food_chocolate_powder.png",
		groups = {food_choco_powder = 1}
	})
	food.craft({
		output = "food:chocolate_powder 16",
		recipe = {
			{"group:food_cocoa","group:food_cocoa","group:food_cocoa"},
			{"group:food_cocoa","group:food_cocoa","group:food_cocoa"},
			{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
		}
	})
end, true)

food.module("pasta", function()
	minetest.register_craftitem(":food:pasta",{
		description = S("Pasta"),
		inventory_image = "food_pasta.png",
		groups = {food_pasta=1}
	})
	food.craft({
		output = "food:pasta 4",
		type = "shapeless",
		recipe = {"group:food_flour","group:food_egg","group:food_egg"}
	})
end, true)

food.module("bowl", function()
	minetest.register_craftitem(":food:bowl",{
		description = S("Bowl"),
		inventory_image = "food_bowl.png",
		groups = {food_bowl=1}
	})
	food.craft({
		output = "food:bowl",
		recipe = {
			{"default:clay_lump","","default:clay_lump"},
			{"","default:clay_lump",""}
		}
	})
end, true)

food.module("butter", function()
	minetest.register_craftitem(":food:butter", {
		description = S("Butter"),
		inventory_image = "food_butter.png",
		groups = {food_butter=1}
	})
	food.craft({
		output = "food:butter",
		recipe = {
			{"group:food_milk","group:food_milk"},
		}
	})
end, true)

food.module("cheese", function()
	minetest.register_craftitem(":food:cheese", {
		description = S("Cheese"),
		inventory_image = "food_cheese.png",
		on_use = food.item_eat(4),
		groups = {food_cheese=1}
	})
	food.craft({
		output = "food:cheese",
		recipe = {
			{"group:food_butter","group:food_butter"},
		}
	})
end, true)

if (minetest.get_modpath("animalmaterials") and not minetest.get_modpath("mobfcooking")) then
	food.craft({
		type = "cooking",
		output = "food:meat",
		recipe = "animalmaterials:meat_raw",
		cooktime = 30
	})
end

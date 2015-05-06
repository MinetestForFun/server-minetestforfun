-- FOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> food_basic/init.lua
-- Some basic foods
-- =====================================

print("Food Mod - Version 2.3")

dofile(minetest.get_modpath("food_basic").."/support.lua")
dofile(minetest.get_modpath("food_basic").."/ingredients.lua")

-- Boilerplate to support localized strings if intllib mod is installed.
local S = 0
if rawget(_G, "intllib") then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end

-- Register dark chocolate
food.module("dark_chocolate", function()
	minetest.register_craftitem(":food:dark_chocolate",{
		description = S("Dark Chocolate"),
		inventory_image = "food_dark_chocolate.png",
		on_use = food.item_eat(3),
		groups = {food_dark_chocolate=1}
	})
	food.craft({
		output = "food:dark_chocolate",
		recipe = {
			{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
		}
	})
end)

-- Register milk chocolate
food.module("milk_chocolate", function()
	minetest.register_craftitem(":food:milk_chocolate",{
		description = S("Milk Chocolate"),
		inventory_image = "food_milk_chocolate.png",
		on_use = food.item_eat(3),
		groups = {food_milk_chocolate=1}
	})
	food.craft({
		output = "food:milk_chocolate",
		recipe = {
				{"","group:food_milk",""},
				{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
		}
	})
end)

-- Register baked potato
food.module("baked_potato", function()
	minetest.register_craftitem(":food:baked_potato", {
		description = S("Baked Potato"),
		inventory_image = "food_baked_potato.png",
		on_use = food.item_eat(6),
	})
	food.craft({
		type = "cooking",
		output = "food:baked_potato",
		recipe = "group:food_potato",
	})
end)

-- Register pasta bake
food.module("pasta_bake", function()
	minetest.register_craftitem(":food:pasta_bake",{
		description = S("Pasta Bake"),
		inventory_image = "food_pasta_bake.png",
		on_use = food.item_eat(4),
		groups = {food=3}
	})
	minetest.register_craftitem(":food:pasta_bake_raw",{
		description = S("Raw Pasta Bake"),
		inventory_image = "food_pasta_bake_raw.png",
	})
	food.craft({
		output = "food:pasta_bake",
		type = "cooking",
	 	recipe = "food:pasta_bake_raw"
	})
	food.craft({
		output = "food:pasta_bake_raw",
	 	recipe = {
			{"group:food_cheese"},
			{"group:food_pasta"},
			{"group:food_bowl"}
		}
	})
end)

-- Register Soups
local soups = {
	{"tomato", "tomato"},
	{"chicken", "meat"}
}
for i=1, #soups do
	local flav = soups[i]
	food.module("soup_"..flav[1], function()
		minetest.register_craftitem(":food:soup_"..flav[1],{
			description = S(flav[1].." Soup"),
			inventory_image = "food_soup_"..flav[1]..".png",
			on_use = food.item_eat(4),
			groups = {food=3}
		})
		minetest.register_craftitem(":food:soup_"..flav[1].."_raw",{
			description = S("Uncooked ".. flav[1].." Soup"),
			inventory_image = "food_soup_"..flav[1].."_raw.png",

		})
		food.craft({
			type = "cooking",
			output = "food:soup_"..flav[1],
			recipe = "food:soup_"..flav[1].."_raw",
		})
		food.craft({
			output = "food:soup_"..flav[1].."_raw",
			recipe = {
				{"", "", ""},
				{"bucket:bucket_water", "group:food_"..flav[2], "bucket:bucket_water"},
				{"", "group:food_bowl", ""},
			},
			replacements = {{"bucket:bucket_water", "bucket:bucket_empty"},{"bucket:bucket_water", "bucket:bucket_empty"}}
		})
	end)
end

-- Juices
local juices = {"apple", "orange", "cactus"}
for i=1, #juices do
	local flav = juices[i]
	food.module(flav.."_juice", function()
		minetest.register_craftitem(":food:"..flav.."_juice", {
			description = S(flav.." Juice"),
			inventory_image = "food_"..flav.."_juice.png",
			on_use = food.item_eat(2),
		})
		food.craft({
			output = "food:"..flav.."_juice 4",
			recipe = {
				{"","",""},
				{"","group:food_"..flav,""},
				{"","group:food_cup",""},
			}
		})
	end)
end

food.module("rainbow_juice", function()
	minetest.register_craftitem(":food:rainbow_juice", {
		description = S("Rainbow Juice"),
		inventory_image = "food_rainbow_juice.png",
		on_use = food.item_eat(20),
	})

	food.craft({
		output = "food:rainbow_juice 99",
		recipe = {
			{"","",""},
			{"","default:nyancat_rainbow",""},
			{"","group:food_cup",""},
		}
	})
end)

food.cake_box = {
	type = "fixed",
	fixed = {
		{-0.250000,-0.500000,-0.296880,0.250000,-0.250000,0.312502},
		{-0.309375,-0.500000,-0.250000,0.309375,-0.250000,0.250000},
		{-0.250000,-0.250000,-0.250000,0.250000,-0.200000,0.250000}
	}
}

-- Register cakes
food.module("cake", function()
	minetest.register_node(":food:cake", {
		description = S("Cake"),
		on_use = food.item_eat(4),
		groups={food=3,crumbly=3},
		tiles = {
			"food_cake_texture.png",
			"food_cake_texture.png",
			"food_cake_texture_side.png",
			"food_cake_texture_side.png",
			"food_cake_texture_side.png",
			"food_cake_texture_side.png"
		},
		walkable = false,
		sunlight_propagates = true,
		drawtype="nodebox",
		paramtype = "light",
		node_box = food.cake_box
	})
	food.craft({
		type = "cooking",
		output = "food:cake",
		recipe = "food:cakemix_plain",
		cooktime = 10,
	})
	minetest.register_craftitem(":food:cakemix_plain",{
		description = S("Cake Mix"),
		inventory_image = "food_cakemix_plain.png",
	})
	minetest.register_craft({
		output = "food:cakemix_plain",
		recipe = {
			{"group:food_flour","group:food_sugar","group:food_egg"},
		}
	})
end)


food.module("cake_choco", function()
	minetest.register_node(":food:cake_choco", {
		description = S("Chocolate Cake"),
		on_use = food.item_eat(4),
		groups={food=3,crumbly=3},
		tiles = {
			"food_cake_choco_texture.png",
			"food_cake_choco_texture.png",
			"food_cake_choco_texture_side.png",
			"food_cake_choco_texture_side.png",
			"food_cake_choco_texture_side.png",
			"food_cake_choco_texture_side.png"
		},
		walkable = false,
		sunlight_propagates = true,
		drawtype="nodebox",
		paramtype = "light",
		node_box = food.cake_box
	})
	food.craft({
		type = "cooking",
		output = "food:cake_choco",
		recipe = "food:cakemix_choco",
		cooktime = 10,
	})
	minetest.register_craftitem(":food:cakemix_choco",{
		description = S("Chocolate Cake Mix"),
		inventory_image = "food_cakemix_choco.png",
	})
	food.craft({
		output = "food:cakemix_choco",
		recipe = {
			{"","group:food_choco_powder",""},
			{"group:food_flour","group:food_sugar","group:food_egg"},
		}
	})
end)

food.module("cake_carrot", function()
	minetest.register_node(":food:cake_carrot", {
		description = S("Carrot Cake"),
		on_use = food.item_eat(4),
		groups={food=3,crumbly=3},
		walkable = false,
		sunlight_propagates = true,
		tiles = {
			"food_cake_carrot_texture.png",
			"food_cake_carrot_texture.png",
			"food_cake_carrot_texture_side.png",
			"food_cake_carrot_texture_side.png",
			"food_cake_carrot_texture_side.png",
			"food_cake_carrot_texture_side.png"
		},
		drawtype="nodebox",
		paramtype = "light",
		node_box = food.cake_box
	})
	food.craft({
		type = "cooking",
		output = "food:cake_carrot",
		recipe = "food:cakemix_carrot",
		cooktime = 10,
	})
	minetest.register_craftitem(":food:cakemix_carrot",{
		description = S("Carrot Cake Mix"),
		inventory_image = "food_cakemix_carrot.png",
	})
	food.craft({
		output = "food:cakemix_carrot",
		recipe = {
			{"","group:food_carrot",""},
			{"group:food_flour","group:food_sugar","group:food_egg"},
		}
	})
end)


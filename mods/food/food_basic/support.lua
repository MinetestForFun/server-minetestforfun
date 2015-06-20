-- FOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> food/support.lua
-- Support external mods
-- =====================================

-- The following ingredient list is licensed under WTFPL
-- You may use the list in your mod. I am doing this to
-- make it easier for mods to support lots of others -
-- good for the end user

-- Add support for other mods
food.support("cocoa", "farming_plus:cocoa_bean")
food.support("cup", "vessels:drinking_glass")
food.support("cactus", "default:cactus")
food.support("apple", "default:apple")
food.support("orange", "farming_plus:orange_item")
food.support("potato", {
	"docfarming:potato",
	"veggies:potato",
	"farming_plus:potato_item"
})
food.support("tomato", {
	"farming_plus:tomato_item",
	"plantlib:tomato"
})
food.support("carrot", {
	"farming_plus:carrot_item",
	"docfarming:carrot",
	"plantlib:carrot",
	"jkfarming:carrot"
})
food.support("milk", {
	"animalmaterials:milk",
	"my_mobs:milk_glass_cup",
	"jkanimals:bucket_milk",
	"mobs:bucket_milk"
})
food.support("egg", {
	"animalmaterials:egg",
	"animalmaterials:egg_big",
	"jkanimals:egg",
	"mobs:egg"
})
food.support("meat", {
	"mobs:meat",
	"jkanimals:meat",
	"mobfcooking:cooked_pork",
	"mobfcooking:cooked_beef",
	"mobfcooking:cooked_chicken",
	"mobfcooking:cooked_lamb",
	"mobfcooking:cooked_venison"
})
food.support("sugar", {
	"jkfarming:sugar",
	"bushes:sugar"
})

if farming and farming.mod == "redo" then
	food.support("wheat", "farming:wheat")
	food.support("flour", "farming:flour")
	food.support("carrot", "farming:carrot")
	food.support("potato", "farming:potato")
	food.support("tomato", "farming:tomato")
	food.support("cocoa", "farming:cocoa_beans")
	food.support("dark_chocolate", "farming:chocolate_dark")
	food.support("sugar", "farming:sugar")
	food.support("cup", "farming:drinking_cup")
	food.disable_if("farming", "baked_potato")
else
	food.support("wheat", "farming:wheat")
	food.support("flour", "farming:flour")
end

if minetest.get_modpath("mtfoods") then
	food.support("strawberry", "farming_plus:strawberry_item")
	food.support("strawberry", "plantlib:strawberry")
	food.support("strawberry", "bushes:strawberry")
	food.support("rhubarb", "farming_plus:rhubarb_item")
end


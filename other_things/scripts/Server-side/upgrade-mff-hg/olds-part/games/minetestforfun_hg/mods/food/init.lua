-- RUBENFOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> rubenfood/init.lua
-- inits the mod
-- =====================================
-- [regis-item] Cup
-- [craft] Cup
-- [regis-food] Cigerette (-4)
-- =====================================

minetest.register_alias("farming:bread", "food:bread")
minetest.register_alias("farming:bread_slice", "food:bread_slice")

-- Bread from the farming mod
minetest.register_craftitem("food:bread", {
	description = "Bread",
	inventory_image = "food_bread.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("food:bread_slice", {
	description = "Bread Slice",
	inventory_image = "food_bread_slice.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("food:bun", {
	description = "Bun",
	inventory_image = "food_bun.png",
	on_use = minetest.item_eat(4),
	groups={food=2},
})

--------------------------Apple Juice--------------------------
minetest.register_craftitem("food:apple_juice", {
	description = "Apple Juice",
	inventory_image = "food_juice_apple.png",
	on_use = minetest.item_eat(2)
})
----------------------Cactus Juice----------------------------
minetest.register_craftitem("food:cactus_juice", {
	description = "Cactus Juice",
	inventory_image = "food_juice_cactus.png",
	on_use = minetest.item_eat(2),
})


local S = farming.intllib

-- Donut (thanks to Bockwurst for making the donut images)
minetest.register_craftitem("farming:donut", {
	description = S("Donut"),
	inventory_image = "farming_donut.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = "farming:donut 3",
	recipe = {
		{'', 'farming:wheat', ''},
		{'farming:wheat', '', 'farming:wheat'},
		{'', 'farming:wheat', ''},
	}
})

-- Chocolate Donut
minetest.register_craftitem("farming:donut_chocolate", {
	description = S("Chocolate Donut"),
	inventory_image = "farming_donut_chocolate.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	output = "farming:donut_chocolate",
	recipe = {
		{'farming:cocoa_beans'},
		{'farming:donut'},
	}
})

-- Apple Donut
minetest.register_craftitem("farming:donut_apple", {
	description = S("Apple Donut"),
	inventory_image = "farming_donut_apple.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	output = "farming:donut_apple",
	recipe = {
		{'default:apple'},
		{'farming:donut'},
	}
})

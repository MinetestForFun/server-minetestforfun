-- Swap sands

-- desert -> normal
minetest.register_craft({
	output = "default:sand",
	recipe = {{"default:desert_sand"}}
})

-- normal -> desert
minetest.register_craft({
	output = "default:desert_sand",
	recipe = {{"default:sand"}}
})

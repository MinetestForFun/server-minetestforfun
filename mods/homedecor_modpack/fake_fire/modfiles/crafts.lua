-- RECIPE ITEM - FLINT
minetest.register_craftitem("fake_fire:flint", {
	description = "flint",
	inventory_image = "flint.png",
	stack_max = 99,
	liquids_pointable = false,
})

-- FLINT
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:flint',
	recipe = {
			"default:gravel",
			"default:gravel",
	}
})

-- FLINT & STEEL
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:flint_and_steel',
	recipe = {
		"fake_fire:flint",
		"default:steel_ingot",
	}
})

-- EMBERS
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:embers',
	recipe = {
			"default:torch",
			"group:wood",
	}
})

-- STONE CHIMNEY TOP
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:smokeless_chimney_top_stone',
	recipe = {
			"default:torch",
			"stairs:slab_stone",
	}
})

-- SANDSTONE CHIMNEY TOP
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:smokeless_chimney_top_sandstone',
	recipe = {
			"default:torch",
			"stairs:slab_sandstone",
	}
})

-- Cobble to Gravel
minetest.register_craft({
	output = 'default:gravel',
	recipe = {
		{'default:cobble'},
	}
})

-- Gravel to Sand
minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'default:gravel'},
	}
})

-- Desert Sand to Sand
minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'default:desert_sand'},
	}
})

-- Sand to Desert Sand
minetest.register_craft({
	output = 'default:desert_sand',
	recipe = {
		{'default:sand'},
	}
})

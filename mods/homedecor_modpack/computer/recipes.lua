
-- Copyright (C) 2012-2013 Diego Martínez <kaeza@users.sf.net>
-- License is WTFPL (see README.txt).

minetest.register_craft({
	output = "computer:shefriendSOO",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:glass", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "group:wood", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:slaystation",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "group:wood", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:vanio",
	recipe = {
		{ "homedecor:plastic_sheeting", "", "" },
		{ "default:glass", "", "" },
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:specter",
	recipe = {
		{ "", "", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:slaystation2",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:steel_ingot", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:admiral64",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "group:wood", "group:wood", "group:wood" }
	}
})

minetest.register_craft({
	output = "computer:admiral128",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	}
})

minetest.register_craft({
	output = "computer:wee",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:copper_ingot", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:piepad",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:glass", "homedecor:plastic_sheeting" }
	}
})

--new stuff

minetest.register_craft({
	output = "computer:monitor",
	recipe = {
		{ "homedecor:plastic_sheeting", "default:glass","" },
		{ "homedecor:plastic_sheeting", "default:glass","" },
		{ "homedecor:plastic_sheeting", "default:mese_crystal_fragment", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:router",
	recipe = {
		{ "default:steel_ingot","","" },
		{ "default:steel_ingot" ,"homedecor:plastic_sheeting", "homedecor:plastic_sheeting" },
		{ "default:mese_crystal_fragment","homedecor:plastic_sheeting", "homedecor:plastic_sheeting"  }
	}
})

minetest.register_craft({
	output = "computer:tower",
	recipe = {
		{ "homedecor:plastic_sheeting", "default:steel_ingot", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:mese_crystal", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:steel_ingot", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:printer",
	recipe = {
		{ "homedecor:plastic_sheeting", "default:steel_ingot","" },
		{ "homedecor:plastic_sheeting", "default:mese_crystal", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "default:coal_lump", "homedecor:plastic_sheeting" }
	}
})

minetest.register_craft({
	output = "computer:printer",
	recipe = {
		{ "homedecor:plastic_sheeting", "default:steel_ingot","" },
		{ "homedecor:plastic_sheeting", "default:mese_crystal", "homedecor:plastic_sheeting" },
		{ "homedecor:plastic_sheeting", "dye:black", "homedecor:plastic_sheeting", }
	}
})

minetest.register_craft({
	output = "computer:server",
	recipe = {
		{ "computer:tower", "computer:tower", "computer:tower", },
		{ "computer:tower", "computer:tower", "computer:tower" },
		{ "computer:tower", "computer:tower", "computer:tower" }
	}
})

minetest.register_craft({
	output = "computer:tetris_arcade",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:power_crystal", "homedecor:plastic_sheeting", },
		{ "dye:black", "default:glass", "dye:black" },
		{ "homedecor:plastic_sheeting", "homedecor:power_crystal", "homedecor:plastic_sheeting" }
	}
})

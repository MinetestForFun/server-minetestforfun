
minetest.register_craft({
	output = "christmas_craft:christmas_lights 4",
	recipe = {
		{"farming:string","default:mese_crystal", "farming:string"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:christmas_leaves 4",
	recipe = {
		{"default:leaves","default:leaves"},
		{"default:leaves","default:leaves"},
	}
})

minetest.register_craft({
	output = "christmas_craft:christmas_wreath ",
	recipe = {
		{"christmas_craft:christmas_leaves","christmas_craft:christmas_leaves","christmas_craft:christmas_leaves"},
		{"christmas_craft:christmas_leaves","","christmas_craft:christmas_leaves"},
		{"christmas_craft:christmas_leaves","christmas_craft:red_ribbon","christmas_craft:christmas_leaves"},
	}
})

minetest.register_craft({
	output = "christmas_craft:snow_block",
	recipe = {
		{"christmas_craft:snowball","christmas_craft:snowball"},
		{"christmas_craft:snowball","christmas_craft:snowball"},
	}
})

minetest.register_craft({
	output = "christmas_craft:snowman",
	recipe = {
		{"default:coal_lump","christmas_craft:snowball","default:coal_lump"},
		{"christmas_craft:snowball","christmas_craft:snowball","christmas_craft:snowball"},
		{"default:coal_lump","default:coal_lump","default:coal_lump"},
	}
})


minetest.register_craft({
	output = "christmas_craft:christmas_star ",
	recipe = {
		{"","default:gold_ingot",""},
		{"default:gold_ingot","default:gold_ingot","default:gold_ingot"},
		{"default:gold_ingot","","default:gold_ingot"},
	}
})

minetest.register_craft({
	output = "christmas_craft:snowball 4",
	recipe = {
		{"christmas_craft:snow_block"},
	}
})


--------------------------
-- baubles               -
--------------------------

minetest.register_craft({
	output = "christmas_craft:red_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:red", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:yellow_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:yellow", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:green_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:green", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:blue_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:blue", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:orange_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:orange", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:pink_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:pink", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:violet_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","dye:violet", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = "christmas_craft:silver_baubles 8",
	recipe = {
		{"default:glass","default:gold_ingot", "default:glass"},
		{"default:glass","", "default:glass"},
		{"default:glass","default:glass", "default:glass"},
	}
})

--------------------------
-- presents              - 
--------------------------

-- paper colour craft --

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_red',
	recipe = {'dye:red','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_blue',
	recipe = {'dye:blue','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_green',
	recipe = {'dye:green','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_yellow',
	recipe = {'dye:yellow','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_yellow',
	recipe = {'dye:yellow','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_violet',
	recipe = {'dye:violet','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_orange',
	recipe = {'dye:orange','default:paper'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:paper_pink',
	recipe = {'dye:pink','default:paper'},
})

-- ribbon craft --

minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:red_ribbon',
	recipe = {'dye:red','farming:string'},
})

-- wish list craft --
minetest.register_craft({
	type = "shapeless",
	output = 'christmas_craft:wish_list',
	recipe = {'default:stick','default:mese_crystal','default:paper','dye:black'},
})

-- present box --

minetest.register_craft({
	output = "christmas_craft:present_box",
	recipe = {
		{"default:paper","default:paper", "default:paper"},
		{"default:paper","christmas_craft:wish_list", "default:paper"},
		{"default:paper","default:paper", "default:paper"},
	}
})

-- present craft --

minetest.register_craft({
	output = "christmas_craft:Christmas_present",
	recipe = {
		{"default:paper","christmas_craft:red_ribbon", "default:paper"},
		{"default:paper","christmas_craft:present_box", "default:paper"},
		{"default:paper","christmas_craft:red_ribbon", "default:paper"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_red",
	recipe = {
		{"christmas_craft:paper_red","christmas_craft:red_ribbon", "christmas_craft:paper_red"},
		{"christmas_craft:paper_red","christmas_craft:present_box", "christmas_craft:paper_red"},
		{"christmas_craft:paper_red","christmas_craft:red_ribbon", "christmas_craft:paper_red"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_blue",
	recipe = {
		{"christmas_craft:paper_blue","christmas_craft:red_ribbon", "christmas_craft:paper_blue"},
		{"christmas_craft:paper_blue","christmas_craft:present_box", "christmas_craft:paper_blue"},
		{"christmas_craft:paper_blue","christmas_craft:red_ribbon", "christmas_craft:paper_blue"},
	}
})


minetest.register_craft({
	output = "christmas_craft:Christmas_present_green",
	recipe = {
		{"christmas_craft:paper_green","christmas_craft:red_ribbon", "christmas_craft:paper_green"},
		{"christmas_craft:paper_green","christmas_craft:present_box", "christmas_craft:paper_green"},
		{"christmas_craft:paper_green","christmas_craft:red_ribbon", "christmas_craft:paper_green"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_yellow",
	recipe = {
		{"christmas_craft:paper_yellow","christmas_craft:red_ribbon", "christmas_craft:paper_yellow"},
		{"christmas_craft:paper_yellow","christmas_craft:present_box", "christmas_craft:paper_yellow"},
		{"christmas_craft:paper_yellow","christmas_craft:red_ribbon", "christmas_craft:paper_yellow"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_orange",
	recipe = {
		{"christmas_craft:paper_orange","christmas_craft:red_ribbon", "christmas_craft:paper_orange"},
		{"christmas_craft:paper_orange","christmas_craft:present_box", "christmas_craft:paper_orange"},
		{"christmas_craft:paper_orange","christmas_craft:red_ribbon", "christmas_craft:paper_orange"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_pink",
	recipe = {
		{"christmas_craft:paper_pink","christmas_craft:red_ribbon", "christmas_craft:paper_pink"},
		{"christmas_craft:paper_pink","christmas_craft:present_box", "christmas_craft:paper_pink"},
		{"christmas_craft:paper_pink","christmas_craft:red_ribbon", "christmas_craft:paper_pink"},
	}
})

minetest.register_craft({
	output = "christmas_craft:Christmas_present_violet",
	recipe = {
		{"christmas_craft:paper_violet","christmas_craft:red_ribbon", "christmas_craft:paper_violet"},
		{"christmas_craft:paper_violet","christmas_craft:present_box", "christmas_craft:paper_violet"},
		{"christmas_craft:paper_violet","christmas_craft:red_ribbon", "christmas_craft:paper_violet"},
	}
})






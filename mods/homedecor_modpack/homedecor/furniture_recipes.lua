
minetest.register_craft({
	output = "homedecor:table", "homedecor:chair 2",
	recipe = {
		{ "group:wood","group:wood", "group:wood" },
		{ "group:stick", "", "group:stick" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_mahogany",
	recipe = {
		"homedecor:table",
		"dye:brown",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_mahogany",
	recipe = {
		"homedecor:table",
		"unifieddyes:dark_orange",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "homedecor:table_white",
	recipe = {
		"homedecor:table",
		"dye:white",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_mahogany",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_white",
	burntime = 30,
})

minetest.register_craft({
	output = "homedecor:chair 2",
	recipe = {
		{ "group:stick",""},
		{ "group:wood","group:wood" },
		{ "group:stick","group:stick" },
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:chair",
	burntime = 15,
})

local chaircolors = { "black", "red", "pink", "violet", "blue", "dark_green" }

for _, color in ipairs(chaircolors) do

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:chair_"..color,
		recipe = {
			"homedecor:chair",
			"wool:white",
			"dye:"..color
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:chair_"..color,
		recipe = {
			"homedecor:chair",
			"wool:"..color
		},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "homedecor:chair_"..color,
		burntime = 15,
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:armchair",
	burntime = 30,
})

minetest.register_craft({
	output = "homedecor:table_lamp_off",
	recipe = {
		{"default:paper","default:torch" ,"default:paper"},
		{"","group:stick",""},
		{"","stairs:slab_wood",""},
	},
})

minetest.register_craft({
	output = "homedecor:table_lamp_off",
	recipe = {
		{"default:paper","default:torch" ,"default:paper"},
		{"","group:stick",""},
		{"","moreblocks:slab_wood",""},
	},
})

minetest.register_craft({
	output = "homedecor:standing_lamp_bottom_off",
	recipe = {
		{"homedecor:table_lamp_off"},
		{"group:stick"},
		{"group:stick"},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "homedecor:table_lamp_off",
	burntime = 10,
})

local lamp_colors = { "blue", "green", "pink", "red", "violet" }

for _, color in ipairs(lamp_colors) do

	minetest.register_craft({
		output = "homedecor:table_lamp_"..color.."_off",
		recipe = {
			{"wool:"..color,"default:torch" ,"wool:"..color},
			{"","group:stick",""},
			{"","stairs:slab_wood",""},
		},
	})

	minetest.register_craft({
		output = "homedecor:table_lamp_"..color.."_off",
		recipe = {
			{"wool:"..color,"default:torch" ,"wool:"..color},
			{"","group:stick",""},
			{"","moreblocks:slab_wood",""},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:table_lamp_"..color.."_off",
		recipe = {
			"dye:"..color,
			"homedecor:table_lamp_off",
		},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "homedecor:table_lamp_"..color.."_off",
		burntime = 10,
	})

	minetest.register_craft({
		output = "homedecor:standing_lamp_bottom_"..color.."_off",
		recipe = {
			{"homedecor:table_lamp_"..color.."_off"},
			{"group:stick"},
			{"group:stick"},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:standing_lamp_bottom_"..color.."_off",
		recipe = {
			"homedecor:standing_lamp_bottom_off",
			"dye:"..color
		},
	})

end

minetest.register_craft({
	output = "homedecor:toilet",
	recipe = {
		{"","","bucket:bucket_water"},
		{ "building_blocks:Marble","building_blocks:Marble", "building_blocks:Marble" },
		{ "", "bucket:bucket_empty", "" },
	},
})

minetest.register_craft({
	output = "homedecor:sink",
	recipe = {
		{ "building_blocks:Marble","bucket:bucket_empty", "building_blocks:Marble" },
	},
})

minetest.register_craft({
	output = "homedecor:taps",
	recipe = {
		{ "default:steel_ingot","bucket:bucket_water", "default:steel_ingot" },
	},
})

minetest.register_craft({
	output = "homedecor:shower_tray",
	recipe = {
		{ "building_blocks:Marble","bucket:bucket_water", "building_blocks:Marble" },
	},
})

minetest.register_craft({
	output = "homedecor:shower_head",
	recipe = {
		{"default:steel_ingot", "bucket:bucket_water"},
	},
})

minetest.register_craft({
	output = "homedecor:bars 6",
	recipe = {
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" },
		{ "homedecor:pole_wrought_iron","homedecor:pole_wrought_iron","homedecor:pole_wrought_iron" },
	},
})

minetest.register_craft({
	output = "homedecor:L_binding_bars 3",
	recipe = {
		{ "homedecor:bars","" },
		{ "homedecor:bars","homedecor:bars" },
	},
})

minetest.register_craft({
	output = "homedecor:torch_wall 10",
	recipe = {
		{ "default:coal_lump" },
		{ "default:steel_ingot" },
	},
})

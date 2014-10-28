-- Naturally spawning blocks
minetest.register_craft({
	output = "darkage:chalk",
	recipe = {
		{"darkage:chalk_powder","darkage:chalk_powder"},
		{"darkage:chalk_powder","darkage:chalk_powder"},
	}
})

minetest.register_craft({
	output = "darkage:mud",
	recipe = {
		{"darkage:mud_lump","darkage:mud_lump"},
		{"darkage:mud_lump","darkage:mud_lump"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:shale",
	recipe = "darkage:mud",
})

minetest.register_craft({
	output = "darkage:silt 3",
	recipe = {
		{"default:sand","default:sand"},
		{"default:clay_lump","default:clay_lump"},
	}
})

minetest.register_craft({
	output = "darkage:silt",
	recipe = {
		{"darkage:silt_lump","darkage:silt_lump"},
		{"darkage:silt_lump","darkage:silt_lump"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:schist",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:shale",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:mud 5",
	recipe = "darkage:silt",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:slate_cobble",
})

minetest.register_craft({
	output = "darkage:ors 4",
	recipe = {
		{"default:sandstone","default:sandstone"},
		{"default:iron_lump","default:sandstone"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:ors",
	recipe = "darkage:ors_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:gneiss_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:basalt",
	recipe = "darkage:basalt_cobble",
})

-- Cobble

-- Other Blocks

minetest.register_craft({
	output = "darkage:straw 2",
	recipe = {
	{"default:dry_shrub","default:dry_shrub"},
		{"default:dry_shrub","default:dry_shrub"},
	}
})

minetest.register_craft({
	output = "darkage:straw 2",
	recipe = {
		{"darkage:dry_leaves","darkage:dry_leaves"},
		{"darkage:dry_leaves","darkage:dry_leaves"},
	}
})

minetest.register_craft({
	output = "darkage:straw_bale",
	recipe = {
		{"darkage:straw","darkage:straw"},
		{"darkage:straw","darkage:straw"},
	}
})

minetest.register_craft({
	output = "darkage:slate_tile 4",
	recipe = {
		{"darkage:slate","darkage:slate"},
		{"darkage:slate","darkage:slate"},
		{"darkage:adobe","darkage:adobe"},
	}
})

minetest.register_craft({
	output = "darkage:marble_tile 4",
	recipe = {
		{"darkage:marble","darkage:marble"},
		{"darkage:marble","darkage:marble"},
		{"darkage:adobe","darkage:adobe"},
	}
})

minetest.register_craft({
	output = "darkage:stone_brick 9",
	recipe = {
		{"default:cobble","default:cobble","default:cobble"},
		{"default:cobble","default:cobble","default:cobble"},
		{"default:cobble","default:cobble","default:cobble"},
	}
})

minetest.register_craft({
	output = "darkage:reinforced_chalk",
	recipe = {
		{"group:stick","","group:stick"},
		{"","darkage:chalk",""},
		{"group:stick","","group:stick"},
	}
})

minetest.register_craft({
	output = "darkage:adobe 4",
	recipe = {
		{"default:sand","default:sand"},
		{"default:clay_lump","darkage:straw"},
	}
})

minetest.register_craft({
	output = "darkage:lamp",
	recipe = {
		{"group:stick","","group:stick"},
		{"","default:torch",""},
		{"group:stick","","group:stick"},
	}
})

minetest.register_craft({
	output = "darkage:cobble_with_plaster 2",
	recipe = {
		{"default:cobble","darkage:chalk_powder"},
		{"default:cobble","darkage:chalk_powder"},
	}
})

minetest.register_craft({
	output = "darkage:cobble_with_plaster 2",
	recipe = {
		{"darkage:chalk_powder","default:cobble"},
		{"darkage:chalk_powder","default:cobble"},
	}
})

minetest.register_craft({
	output = "darkage:darkdirt 4",
	recipe = {
		{"default:dirt","default:dirt"},
		{"default:gravel","default:gravel"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:dry_leaves",
	recipe = "default:leaves",
})

-- Storage blocks (boxes, shelves, ect.)
minetest.register_craft({
	output = "darkage:box",
	recipe = {
		{"default:wood","","default:wood"},
		{"","",""},
		{"default:wood","","default:wood"},
	}
})

minetest.register_craft({
	output = "darkage:wood_shelves 2",
	recipe = {
		{"darkage:box"},
		{"darkage:box"},
	}
})

-- Glass / Glow Glass
minetest.register_craft({
	output = "darkage:glass",
		recipe = {
		{"darkage:glow_glass"},
	}
})

minetest.register_craft({
	output = "darkage:glass 8",
	recipe = {
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
	}
})

minetest.register_craft({
	output = "darkage:glow_glass",
	recipe = {
		{"darkage:glass"},
		{"default:torch"},
	}
})

-- Reinforced Wood
minetest.register_craft({
	output = "darkage:reinforced_wood",
	recipe = {
		{"group:stick","","group:stick"},
		{"","default:wood",""},
		{"group:stick","","group:stick"},
	}
})

minetest.register_craft({
	output = "darkage:reinforced_wood_left",
	recipe = {
		{"default:stick","darkage:reinforced_wood",""},
	}
})

minetest.register_craft({
	output = "darkage:reinforced_wood_right",
	recipe = {
		{"","darkage:reinforced_wood","default:stick"},
	}
})

-- Wood based deco items
minetest.register_craft({
	output = "darkage:wood_bars 2",
	recipe = {
		{"default:stick","","default:stick"},
		{"default:stick","","default:stick"},
		{"default:stick","","default:stick"},
	}
})

minetest.register_craft({
	output = "darkage:wood_grille 2",
	recipe = {
		{"","darkage:wood_bars",""},
		{"darkage:wood_bars","","darkage:wood_bars"},
		{"","darkage:wood_bars",""},
	}
})

minetest.register_craft({
	output = "darkage:wood_frame",
	recipe = {
		{"group:stick","","group:stick"},
		{"","group:wood",""},
		{"group:stick","","group:stick"},
	}
})

-- Metal based deco items
minetest.register_craft({
	output = "darkage:chain 2",
	recipe = {
		{"darkage:iron_stick"},
		{"darkage:iron_stick"},
		{"darkage:iron_stick"},
	}
})

minetest.register_craft({
	output = "darkage:iron_bars 2",
	recipe = {
		{"darkage:iron_stick","","darkage:iron_stick"},
		{"darkage:iron_stick","","darkage:iron_stick"},
		{"darkage:iron_stick","","darkage:iron_stick"},
	}
})

minetest.register_craft({
	output = "darkage:iron_grille 2",
	recipe = {
		{"","darkage:iron_bars",""},
		{"darkage:iron_bars","","darkage:iron_bars"},
		{"","darkage:iron_bars",""},
	}
})

-- Craft items
minetest.register_craft({
	output = "darkage:chalk_powder 4",
	recipe = {
		{"darkage:chalk"},
	}
})

minetest.register_craft({
	output = "darkage:mud_lump 4",
	recipe = {
		{"darkage:mud"},
	}
})

minetest.register_craft({
	output = "darkage:silt_lump 4",
		recipe = {
		{"darkage:silt"},
	}
})

minetest.register_craft({
	output = "darkage:iron_stick 3",
	recipe = {
		{"default:steel_ingot"},
		{"default:steel_ingot"},
		{"default:steel_ingot"},
	}
})

-- Minetest 0.4.7 mod: framedglass

minetest.register_craft({
	output = 'framedglass:wooden_framed_glass 4',
	recipe = {
		{'default:glass', 'default:glass', 'default:stick'},
		{'default:glass', 'default:glass', 'default:stick'},
		{'default:stick', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:steel_framed_glass 4',
	recipe = {
		{'default:glass', 'default:glass', 'default:steel_ingot'},
		{'default:glass', 'default:glass', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:wooden_framed_obsidian_glass 4',
	recipe = {
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:stick'},
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:stick'},
		{'default:stick', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:steel_framed_obsidian_glass 4',
	recipe = {
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})

minetest.register_node("framedglass:wooden_framed_glass", {
	description = "Wooden-framed Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"framedglass_woodenglass_face_streaks_frame.png","framedglass_glass_face_streaks.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("framedglass:steel_framed_glass", {
	description = "Steel-framed Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"framedglass_steelglass_face_streaks_frame.png","framedglass_glass_face_streaks.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("framedglass:wooden_framed_obsidian_glass", {
	description = "Wooden-framed Obsidian Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"framedglass_woodenglass_face_clean_frame.png","framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("framedglass:steel_framed_obsidian_glass", {
	description = "Steel-framed Obsidian Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"framedglass_steelglass_face_clean_frame.png","framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

function add_coloured_framedglass(name, desc, dye)
	minetest.register_node( "framedglass:steel_framed_obsidian_glass"..name, {
		description = "Steel-framed "..desc.." Obsidian Glass",
		tiles = {"framedglass_".. name.. "glass_frame.png", "framedglass_".. name.. "glass.png"},
		drawtype = "glasslike_framed_optional",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		use_texture_alpha = true,
		groups = {cracky=3},
		sounds = default.node_sound_glass_defaults(),
	})

	minetest.register_craft({
		type = "shapeless",
		output = "framedglass:steel_framed_obsidian_glass"..name,
		recipe = {
			"framedglass:steel_framed_glass",
			"group:basecolor_white",
			dye
		}
	})

end

add_coloured_framedglass ("red","Red","group:basecolor_red")
add_coloured_framedglass ("green","Green","group:basecolor_green")
add_coloured_framedglass ("blue","Blue","group:basecolor_blue")
add_coloured_framedglass ("cyan","Cyan","group:basecolor_cyan")
add_coloured_framedglass ("darkgreen","Dark Green","group:unicolor_dark_green")
add_coloured_framedglass ("violet","Violet","group:excolor_violet")
add_coloured_framedglass ("pink","Pink","group:unicolor_light_red")
add_coloured_framedglass ("yellow","Yellow","group:basecolor_yellow")
add_coloured_framedglass ("orange","Orange","group:basecolor_orange")
add_coloured_framedglass ("brown","Brown","group:unicolor_dark_orange")
add_coloured_framedglass ("white","White","group:basecolor_white")
add_coloured_framedglass ("grey","Grey","group:basecolor_grey")
add_coloured_framedglass ("darkgrey","Dark Grey","group:excolor_darkgrey")
add_coloured_framedglass ("black","Black","group:basecolor_black")


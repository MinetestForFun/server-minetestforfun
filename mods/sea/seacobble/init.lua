-- NODES


minetest.register_node("seacobble:seacobble", {
	description = "Sea cobblestone",
	tiles = {"seacobble_seacobble.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_cyan", {
	description = "Sea cobblestone cyan",
	tiles = {"seacobble_seacobble_cyan.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_magenta", {
	description = "Sea cobblestone magenta",
	tiles = {"seacobble_seacobble_magenta.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_lime", {
	description = "Sea cobblestone lime",
	tiles = {"seacobble_seacobble_lime.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_aqua", {
	description = "Sea cobblestone aqua",
	tiles = {"seacobble_seacobble_aqua.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_skyblue", {
	description = "Sea cobblestone skyblue",
	tiles = {"seacobble_seacobble_skyblue.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seacobble:seacobble_redviolet", {
	description = "Sea cobblestone redviolet",
	tiles = {"seacobble_seacobble_redviolet.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})


-- STAIRS


stairs.register_stair_and_slab("seacobble", "seacobble:seacobble",
		{cracky=3, stone=2},
		{"seacobble_seacobble.png"},
		"Seacobble stair",
		"Seacobble slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_cyan", "seacobble:seacobble_cyan",
		{cracky=3, stone=2},
		{"seacobble_seacobble_cyan.png"},
		"Seacobble stair cyan",
		"Seacobble slab cyan",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_magenta", "seacobble:seacobble_magenta",
		{cracky=3, stone=2},
		{"seacobble_seacobble_magenta.png"},
		"Seacobble stair magenta",
		"Seacobble slab magenta",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_lime", "seacobble:seacobble_lime",
		{cracky=3, stone=2},
		{"seacobble_seacobble_lime.png"},
		"Seacobble stair lime",
		"Seacobble slab lime",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_aqua", "seacobble:seacobble_aqua",
		{cracky=3, stone=2},
		{"seacobble_seacobble_aqua.png"},
		"Seacobble stair aqua",
		"Seacobble slab aqua",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_skyblue", "seacobble:seacobble_skyblue",
		{cracky=3, stone=2},
		{"seacobble_seacobble_skyblue.png"},
		"Seacobble stair skyblue ",
		"Seacobble slab skyblue",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seacobble_redviolet", "seacobble:seacobble_redviolet",
		{cracky=3, stone=2},
		{"seacobble_seacobble_redviolet.png"},
		"Seacobble stair redviolet",
		"Seacobble slab redviolet",
		default.node_sound_stone_defaults())


-- CRAFTING


local register_seacobble_craft = function(output,recipe)
    minetest.register_craft({
        type = 'shapeless',
        output = output,
        recipe = recipe,
	})
end

register_seacobble_craft("seacobble:seacobble", {'clams:crushedwhite', 'default:cobble'})

register_seacobble_craft("seacobble:seacobble_cyan", {'seacobble:seacobble', 'dye:cyan'})
register_seacobble_craft("seacobble:seacobble_magenta", {'seacobble:seacobble', 'dye:magenta'})
register_seacobble_craft("seacobble:seacobble_lime", {'seacobble:seacobble', 'dye:lime'})
register_seacobble_craft("seacobble:seacobble_aqua", {'seacobble:seacobble', 'dye:aqua'})
register_seacobble_craft("seacobble:seacobble_skyblue", {'seacobble:seacobble', 'dye:skyblue'})
register_seacobble_craft("seacobble:seacobble_redviolet", {'seacobble:seacobble', 'dye:redviolet'})

register_seacobble_craft("seacobble:seacobble_cyan", {'clams:crushedwhite', 'default:cobble','dye:cyan'})
register_seacobble_craft("seacobble:seacobble_magenta", {'clams:crushedwhite', 'default:cobble','dye:magenta'})
register_seacobble_craft("seacobble:seacobble_lime", {'clams:crushedwhite', 'default:cobble','dye:lime'})
register_seacobble_craft("seacobble:seacobble_aqua", {'clams:crushedwhite', 'default:cobble','dye:aqua'})
register_seacobble_craft("seacobble:seacobble_skyblue", {'clams:crushedwhite', 'default:cobble','dye:skyblue'})
register_seacobble_craft("seacobble:seacobble_redviolet", {'clams:crushedwhite', 'default:cobble','dye:redviolet'})
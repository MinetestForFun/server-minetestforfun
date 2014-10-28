-- NODES


minetest.register_node("seastonebrick:seastonebrick", {
	description = "Seastone brick",
	tiles = {"seastonebrick_seastonebrick.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("seastonebrick:seastonebrick_cyan", {
	description = "Seastone brick cyan",
	tiles = {"seastonebrick_seastonebrick_cyan.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastonebrick:seastonebrick_magenta", {
	description = "Seastone brick magenta",
	tiles = {"seastonebrick_seastonebrick_magenta.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastonebrick:seastonebrick_lime", {
	description = "Seastone brick lime",
	tiles = {"seastonebrick_seastonebrick_lime.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastonebrick:seastonebrick_aqua", {
	description = "Seastone brick aqua",
	tiles = {"seastonebrick_seastonebrick_aqua.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastonebrick:seastonebrick_skyblue", {
	description = "Seastone brick skyblue",
	tiles = {"seastonebrick_seastonebrick_skyblue.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("seastonebrick:seastonebrick_redviolet", {
	description = "Seastone brick redviolet",
	tiles = {"seastonebrick_seastonebrick_redviolet.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})


-- STAIRS


stairs.register_stair_and_slab("seastonebrick", "seastonebrick:seastonebrick",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick.png"},
		"Seastonebrick stair",
		"Seastonebrick slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_cyan", "seastonebrick:seastonebrick_cyan",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_cyan.png"},
		"Seastonebrick stair cyan",
		"Seastonebrick slab cyan",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_magenta", "seastonebrick:seastonebrick_magenta",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_magenta.png"},
		"Seastonebrick stair magenta",
		"Seastonebrick slab magenta",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_lime", "seastonebrick:seastonebrick_lime",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_lime.png"},
		"Seastonebrick stair lime",
		"Seastonebrick slab lime",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_aqua", "seastonebrick:seastonebrick_aqua",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_aqua.png"},
		"Seastonebrick stair aqua",
		"Seastonebrick slab aqua",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_skyblue", "seastonebrick:seastonebrick_skyblue",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_skyblue.png"},
		"Seastonebrick stair skyblue ",
		"Seastonebrick slab skyblue",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("seastonebrick_redviolet", "seastonebrick:seastonebrick_redviolet",
		{cracky=3, stone=1},
		{"seastonebrick_seastonebrick_redviolet.png"},
		"Seastonebrick stair redviolet",
		"Seastonebrick slab redviolet",
		default.node_sound_stone_defaults())


-- CRAFTING


local register_blockbrick_craft = function(output,recipe)
    minetest.register_craft({
       output = output,
       recipe = recipe,
	})
end

register_blockbrick_craft("seastonebrick:seastonebrick", {{'seastone:seastone', 'seastone:seastone'}, {'seastone:seastone', 'seastone:seastone'}})
register_blockbrick_craft("seastonebrick:seastonebrick_cyan", {{'seastone:seastone_cyan', 'seastone:seastone_cyan'}, {'seastone:seastone_cyan', 'seastone:seastone_cyan'}})
register_blockbrick_craft("seastonebrick:seastonebrick_magenta", {{'seastone:seastone_magenta', 'seastone:seastone_magenta'}, {'seastone:seastone_magenta', 'seastone:seastone_magenta'}})
register_blockbrick_craft("seastonebrick:seastonebrick_lime", {{'seastone:seastone_lime', 'seastone:seastone_lime'}, {'seastone:seastone_lime', 'seastone:seastone_lime'}})
register_blockbrick_craft("seastonebrick:seastonebrick_aqua", {{'seastone:seastone_aqua', 'seastone:seastone_aqua'}, {'seastone:seastone_aqua', 'seastone:seastone_aqua'}})
register_blockbrick_craft("seastonebrick:seastonebrick_skyblue", {{'seastone:seastone_skyblue', 'seastone:seastone_skyblue'}, {'seastone:seastone_skyblue', 'seastone:seastone_skyblue'}})
register_blockbrick_craft("seastonebrick:seastonebrick_redviolet", {{'seastone:seastone_redviolet', 'seastone:seastone_redviolet'}, {'seastone:seastone_redviolet', 'seastone:seastone_redviolet'}})
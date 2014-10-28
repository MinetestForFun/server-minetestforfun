-- NODES


minetest.register_node("seaglass:seaglass", {
	description = "Standard seaglass on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, shine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglass_yellow", {
	description = "Seaglass yellow on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_yellow.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_yellow.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff_yellow',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_yellow=1, shine=1, yellowshine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglass_red", {
	description = "Seaglass red on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_red.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_red.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff_red',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_red=1, shine=1, redshine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglass_blue", {
	description = "Seaglass blue on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_blue.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_blue.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff_blue',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_blue=1, shine=1, blueshine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglass_white", {
	description = "Seaglass white on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_white.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_white.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff_white',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_white=1, shine=1, whiteshine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglass_black", {
	description = "Seaglass black on",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_black.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_black.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	drop = 'seaglass:seaglassoff_black',
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_black=1, shine=1, blackshine=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff", {
	description = "Standard seaglass off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff_yellow", {
	description = "Seaglass yellow off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_yellow.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_yellow.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_yellow=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff_red", {
	description = "Seaglass red off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_red.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_red.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_red=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff_blue", {
	description = "Seaglass blue off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_blue.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_blue.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_blue=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff_white", {
	description = "Seaglass white off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_white.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_white.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_white=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("seaglass:seaglassoff_black", {
	description = "Seaglass black off",
	drawtype = "glasslike",
	tiles = {"seaglass_seaglass_black.png"},
	inventory_image = minetest.inventorycube("seaglass_seaglass_black.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, color_black=1, noshine=1},
	sounds = default.node_sound_glass_defaults(),
})


-- STAIRS


stairsshine.register_stair_and_slab("seaglass", "seaglass:seaglass",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, shine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass.png"},
		"Seaglass stair on",
		"Seaglass slab on",
		default.node_sound_glass_defaults())

stairsshine.register_stair_and_slab("seaglass_yellow", "seaglass:seaglass_yellow",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_yellow=1, shine=1, yellowshine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass_yellow.png"},
		"seaglass stair on yellow",
		"seaglass slab on yellow",
		default.node_sound_glass_defaults())

stairsshine.register_stair_and_slab("seaglass_red", "seaglass:seaglass_red",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_red=1, shine=1, redshine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass_red.png"},
		"Seaglass stair on red",
		"Seaglass slab on red",
		default.node_sound_glass_defaults())

stairsshine.register_stair_and_slab("seaglass_blue", "seaglass:seaglass_blue",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_blue=1, shine=1, blueshine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass_blue.png"},
		"Seaglass stair on blue",
		"Seaglass slab on blue",
		default.node_sound_glass_defaults())

stairsshine.register_stair_and_slab("seaglass_white", "seaglass:seaglass_white",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_white=1, shine=1, whiteshine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass_white.png"},
		"Seaglass stair on white",
		"Seaglass slab on white",
		default.node_sound_glass_defaults())

stairsshine.register_stair_and_slab("seaglass_black", "seaglass:seaglass_black",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_black=1, shine=1, blackshine=1, not_in_creative_inventory=1},
		{"seaglass_seaglass_black.png"},
		"Seaglass stair on black ",
		"Seaglass slab on black",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff", "seaglass:seaglassoff",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, nocolor=1, noshine=1},
		{"seaglass_seaglass.png"},
		"Seaglass stair off",
		"Seaglass slab off",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff_yellow", "seaglass:seaglassoff_yellow",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_yellow=1, noshine=1},
		{"seaglass_seaglass_yellow.png"},
		"seaglass stair off yellow",
		"seaglass slab off yellow",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff_red", "seaglass:seaglassoff_red",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_red=1, noshine=1},
		{"seaglass_seaglass_red.png"},
		"Seaglass stair off red",
		"Seaglass slab off red",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff_blue", "seaglass:seaglassoff_blue",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_blue=1, noshine=1},
		{"seaglass_seaglass_blue.png"},
		"Seaglass stair off blue",
		"Seaglass slab off blue",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff_white", "seaglass:seaglassoff_white",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_white=1, noshine=1},
		{"seaglass_seaglass_white.png"},
		"Seaglass stair off white",
		"Seaglass slab off white",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("seaglassoff_black", "seaglass:seaglassoff_black",
		{snappy=2,cracky=3,oddly_breakable_by_hand=3, color_black=1, noshine=1},
		{"seaglass_seaglass_black.png"},
		"Seaglass stair off black ",
		"Seaglass slab off black",
		default.node_sound_glass_defaults())


-- CRAFTING


local register_seaglass_craft = function(output,recipe)
    minetest.register_craft({
        type = 'shapeless',
        output = output,
        recipe = recipe,
	})
end

register_seaglass_craft("seaglass:seaglassoff", {'clams:collectedalgae', 'default:glass'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'clams:collectedalgae', 'default:glass', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'clams:collectedalgae', 'default:glass', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'clams:collectedalgae', 'default:glass', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'clams:collectedalgae', 'default:glass', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'clams:collectedalgae', 'default:glass', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglass', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglass', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglass', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglass', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglass', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglassoff', 'dye:yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglassoff', 'dye:red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglassoff', 'dye:blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglassoff', 'dye:white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglassoff', 'dye:black'})

register_seaglass_craft("seaglass:seaglassoff", {'seaglass:seaglass'})
register_seaglass_craft("seaglass:seaglassoff_yellow", {'seaglass:seaglass_yellow'})
register_seaglass_craft("seaglass:seaglassoff_red", {'seaglass:seaglass_red'})
register_seaglass_craft("seaglass:seaglassoff_blue", {'seaglass:seaglass_blue'})
register_seaglass_craft("seaglass:seaglassoff_white", {'seaglass:seaglass_white'})
register_seaglass_craft("seaglass:seaglassoff_black", {'seaglass:seaglass_black'})

register_seaglass_craft("seaglass:seaglass", {'seaglass:seaglassoff'})
register_seaglass_craft("seaglass:seaglass_yellow", {'seaglass:seaglassoff_yellow'})
register_seaglass_craft("seaglass:seaglass_red", {'seaglass:seaglassoff_red'})
register_seaglass_craft("seaglass:seaglass_blue", {'seaglass:seaglassoff_blue'})
register_seaglass_craft("seaglass:seaglass_white", {'seaglass:seaglassoff_white'})
register_seaglass_craft("seaglass:seaglass_black", {'seaglass:seaglassoff_black'})

register_seaglass_craft("stairsshine:stair_seaglass", {'stairs:stair_seaglassoff'})
register_seaglass_craft("stairsshine:stair_seaglass_yellow", {'stairs:stair_seaglassoff_yellow'})
register_seaglass_craft("stairsshine:stair_seaglass_red", {'stairs:stair_seaglassoff_red'})
register_seaglass_craft("stairsshine:stair_seaglass_blue", {'stairs:stair_seaglassoff_blue'})
register_seaglass_craft("stairsshine:stair_seaglass_white", {'stairs:stair_seaglassoff_white'})
register_seaglass_craft("stairsshine:stair_seaglass_black", {'stairs:stair_seaglassoff_black'})

register_seaglass_craft("stairs:stair_seaglassoff", {'stairsshine:stair_seaglass'})
register_seaglass_craft("stairs:stair_seaglassoff_yellow", {'stairsshine:stair_seaglass_yellow'})
register_seaglass_craft("stairs:stair_seaglassoff_red", {'stairsshine:stair_seaglass_red'})
register_seaglass_craft("stairs:stair_seaglassoff_blue", {'stairsshine:stair_seaglass_blue'})
register_seaglass_craft("stairs:stair_seaglassoff_white", {'stairsshine:stair_seaglass_white'})
register_seaglass_craft("stairs:stair_seaglassoff_black", {'stairsshine:stair_seaglass_black'})

register_seaglass_craft("stairsshine:slab_seaglass", {'stairs:slab_seaglassoff'})
register_seaglass_craft("stairsshine:slab_seaglass_yellow", {'stairs:slab_seaglassoff_yellow'})
register_seaglass_craft("stairsshine:slab_seaglass_red", {'stairs:slab_seaglassoff_red'})
register_seaglass_craft("stairsshine:slab_seaglass_blue", {'stairs:slab_seaglassoff_blue'})
register_seaglass_craft("stairsshine:slab_seaglass_white", {'stairs:slab_seaglassoff_white'})
register_seaglass_craft("stairsshine:slab_seaglass_black", {'stairs:slab_seaglassoff_black'})

register_seaglass_craft("stairs:slab_seaglassoff", {'stairsshine:slab_seaglass'})
register_seaglass_craft("stairs:slab_seaglassoff_yellow", {'stairsshine:slab_seaglass_yellow'})
register_seaglass_craft("stairs:slab_seaglassoff_red", {'stairsshine:slab_seaglass_red'})
register_seaglass_craft("stairs:slab_seaglassoff_blue", {'stairsshine:slab_seaglass_blue'})
register_seaglass_craft("stairs:slab_seaglassoff_white", {'stairsshine:slab_seaglass_white'})
register_seaglass_craft("stairs:slab_seaglassoff_black", {'stairsshine:slab_seaglass_black'})


-- FUNCTIONS


local on_lamp_puncher = function (pos, node, puncher)
	if node.name == "seaglass:seaglass" then
		minetest.add_node(pos, {name="seaglass:seaglassoff"})
		nodeupdate(pos)
			elseif node.name == "seaglass:seaglassoff" then
			minetest.add_node(pos, {name="seaglass:seaglass"})
			nodeupdate(pos)
	elseif node.name == "seaglass:seaglass_yellow" then
		minetest.add_node(pos, {name="seaglass:seaglassoff_yellow"})
		nodeupdate(pos)
	elseif node.name == "seaglass:seaglassoff_yellow" then
			minetest.add_node(pos, {name="seaglass:seaglass_yellow"})
			nodeupdate(pos)
	elseif node.name == "seaglass:seaglass_red" then
		minetest.add_node(pos, {name="seaglass:seaglassoff_red"})
		nodeupdate(pos)
	elseif node.name == "seaglass:seaglassoff_red" then
			minetest.add_node(pos, {name="seaglass:seaglass_red"})
			nodeupdate(pos)
	elseif node.name == "seaglass:seaglass_blue" then
		minetest.add_node(pos, {name="seaglass:seaglassoff_blue"})
		nodeupdate(pos)
	elseif node.name == "seaglass:seaglassoff_blue" then
			minetest.add_node(pos, {name="seaglass:seaglass_blue"})
			nodeupdate(pos)
	elseif node.name == "seaglass:seaglass_white" then
		minetest.add_node(pos, {name="seaglass:seaglassoff_white"})
		nodeupdate(pos)
	elseif node.name == "seaglass:seaglassoff_white" then
			minetest.add_node(pos, {name="seaglass:seaglass_white"})
			nodeupdate(pos)
	elseif node.name == "seaglass:seaglass_black" then
		minetest.add_node(pos, {name="seaglass:seaglassoff_black"})
		nodeupdate(pos)
	elseif node.name == "seaglass:seaglassoff_black" then
			minetest.add_node(pos, {name="seaglass:seaglass_black"})
			nodeupdate(pos)

	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass", param2 = 23})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_yellow" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_yellow", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_yellow" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_yellow", param2 = 23})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_red" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_red", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_red" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_red", param2 = 23})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_blue" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_blue", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_blue" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_blue", param2 = 23})
			nodeupdate(pos)

	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_white" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_white", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_white" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_white", param2 = 23})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 0 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 0})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 0 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 0})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 1 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 1})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 1 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 1})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 2 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 2})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 2 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 2})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 3 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 3})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 3 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 3})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 21 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 21})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 21 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 21})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 22 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 22})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 22 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 22})
			nodeupdate(pos)
	elseif node.name == "stairsshine:stair_seaglass_black" and node.param2 == 23 then
		minetest.add_node(pos, {name="stairs:stair_seaglassoff_black", param2 = 23})
		nodeupdate(pos)
			elseif node.name == "stairs:stair_seaglassoff_black" and node.param2 == 23 then
			minetest.add_node(pos, {name="stairsshine:stair_seaglass_black", param2 = 23})
			nodeupdate(pos)

	elseif node.name == "stairsshine:slab_seaglass" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass"})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_yellow" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_yellow", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_yellow" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_yellow", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_yellow" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_yellow"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_yellow" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_yellow"})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_red" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_red", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_red" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_red", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_red" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_red"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_red" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_red"})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_blue" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_blue", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_blue" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_blue", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_blue" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_blue"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_blue" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_blue"})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_white" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_white", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_white" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_white", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_white" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_white"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_white" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_white"})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_black" and node.param2 == 20 then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_black", param2 = 20})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_black" and node.param2 == 20 then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_black", param2 = 20})
			nodeupdate(pos)
	elseif node.name == "stairsshine:slab_seaglass_black" then
		minetest.add_node(pos, {name="stairs:slab_seaglassoff_black"})
		nodeupdate(pos)
			elseif node.name == "stairs:slab_seaglassoff_black" then
			minetest.add_node(pos, {name="stairsshine:slab_seaglass_black"})
			nodeupdate(pos) else
			return
	end
end

minetest.register_on_punchnode(on_lamp_puncher)



-- ALIASES


minetest.register_alias("clams:yellowlightglass","seaglass:seaglassoff_yellow")
minetest.register_alias("clams:redlightglass","seaglass:seaglassoff_red")
minetest.register_alias("clams:bluelightglass","seaglass:seaglassoff_blue")
minetest.register_alias("clams:whitelightglass","seaglass:seaglassoff_white")
minetest.register_alias("clams:blacklightglass","seaglass:seaglassoff_black")
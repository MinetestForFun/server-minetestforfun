local S = homedecor.gettext

minetest.register_node("homedecor:toilet", {
    description = S("Toilet"),
    tiles = { "forniture_marble.png" },
    drawtype = "nodebox",
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10,  0.00,  0.50, },
            { -0.30, -0.20, -0.30,  0.30,  0.00,  0.35, },
            { -0.25,  0.00, -0.25,  0.25,  0.05,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
            { -0.05,  0.40,  0.35,  0.05,  0.45,  0.45, },
        },
    },
    groups = {cracky=3,},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "homedecor:toilet_open"
        minetest.set_node(pos, node)
    end,
})

minetest.register_node("homedecor:toilet_open", {
    tiles = {
        "forniture_marble_top_toilet.png",
		"forniture_marble.png"
    },
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10, -0.20,  0.50, },
            { -0.10, -0.20,  0.30,  0.10,  0.00,  0.50, },
            { -0.30, -0.20,  0.10,  0.30,  0.00,  0.35, },
            { -0.30, -0.20, -0.30, -0.10, -0.15,  0.10, },
            { -0.10, -0.20, -0.30,  0.10, -0.15, -0.10, },
            {  0.10, -0.20, -0.30,  0.30, -0.15,  0.10, },
            { -0.30, -0.15, -0.30, -0.20,  0.00,  0.10, },
            { -0.20, -0.15, -0.30,  0.20,  0.00, -0.20, },
            {  0.20, -0.15, -0.30,  0.30,  0.00,  0.10, },
            { -0.25,  0.00,  0.20,  0.25,  0.50,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
        },
    },
    drop = "homedecor:toilet",
    groups = {cracky = 3,},
    --sounds = {dig = "3dforniture_dig_toilet",  gain=0.5},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "homedecor:toilet"
        minetest.set_node(pos, node)
		minetest.sound_play("homedecor_toilet_flush", {
			pos=pos,
			max_hear_distance = 5,
			gain = 1,
		})
    end,
})

--Sink
minetest.register_node("homedecor:sink", {
    description = S("Sink"),
    tiles = {
        "forniture_marble_top_sink.png",
		"forniture_marble.png"
    },
    inventory_image="3dforniture_inv_sink.png",
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.15,  0.35,  0.20,  0.15,  0.40,  0.50, },
            { -0.25,  0.40,  0.40,  0.25,  0.45,  0.50, },
            { -0.25,  0.40,  0.15, -0.15,  0.45,  0.40, },
            {  0.15,  0.40,  0.15,  0.25,  0.45,  0.40, },
            { -0.15,  0.40,  0.15,  0.15,  0.45,  0.20, },
            { -0.30,  0.45,  0.40,  0.30,  0.50,  0.50, },
            { -0.30,  0.45,  0.10, -0.25,  0.50,  0.40, },
            {  0.25,  0.45,  0.10,  0.30,  0.50,  0.40, },
            { -0.25,  0.45,  0.10,  0.25,  0.50,  0.15, },
	    {-0.1, -0.5, 0.3, 0.1, 0.4, 0.5},
        },
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.3,-0.5,0.1, 0.3,0.5,0.5},
    },
    groups = {cracky=2,},
    sounds = default.node_sound_stone_defaults(),
})

--Taps
minetest.register_node("homedecor:taps", {
    description = S("Taps"),
    tiles = { "forniture_metal.png" },
    inventory_image="3dforniture_inv_taps.png",
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.25, -0.450,  0.49,  0.25, -0.30,  0.50, },
            { -0.05, -0.400,  0.25,  0.05, -0.35,  0.50, },
            { -0.05, -0.425,  0.25,  0.05, -0.40,  0.30, },
            { -0.20, -0.400,  0.45, -0.15, -0.35,  0.50, },
            { -0.20, -0.450,  0.40, -0.15, -0.30,  0.45, },
            { -0.25, -0.400,  0.40, -0.10, -0.35,  0.45, },
            {  0.15, -0.400,  0.45,  0.20, -0.35,  0.50, },
            {  0.15, -0.450,  0.40,  0.20, -0.30,  0.45, },
            {  0.10, -0.400,  0.40,  0.25, -0.35,  0.45, },
        },
    },
    selection_box = {
        type = "fixed",
        fixed = { -0.25, -0.45, 0.25, 0.25, -0.3, 0.5 },
    },
    groups = {cracky=2,},
    sounds = default.node_sound_stone_defaults(),
})

--Shower Tray
minetest.register_node("homedecor:shower_tray", {
    description = S("Shower Tray"),
    tiles = {
		"forniture_marble_base_ducha_top.png",
		"forniture_marble.png"
    },
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "facedir",
    legacy_facedir_simple = true,
    node_box = {
        type = "fixed",
        fixed = {
            { -0.50, -0.50, -0.50,  0.50, -0.45,  0.50, },
            { -0.50, -0.45, -0.50,  0.50, -0.40, -0.45, },
            { -0.50, -0.45,  0.45,  0.50, -0.40,  0.50, },
            { -0.50, -0.45, -0.45, -0.45, -0.40,  0.45, },
            {  0.45, -0.45, -0.45,  0.50, -0.40,  0.45, },
        },
    },
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 },
    },
    groups = {cracky=2,},
    sounds = default.node_sound_stone_defaults(),
})

--Shower Head
minetest.register_node("homedecor:shower_head", {
    description = S("Shower Head"),
    tiles = { "forniture_metal.png" },
    inventory_image="3dforniture_inv_shower_head.png",
    drawtype = "nodebox",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.10, -0.50,  0.10,  0.10, -0.40,  0.30, },
            { -0.05, -0.40,  0.15,  0.05, -0.30,  0.25, },
            { -0.05, -0.35,  0.25,  0.05, -0.30,  0.50, },
            { -0.10, -0.40,  0.49,  0.10, -0.25,  0.50, },
        },
    },
    selection_box = {
        type = "fixed",
        fixed = { -0.1, -0.5, 0.1, 0.1, -0.25, 0.5 },
    },
    groups = {cracky=2,},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_alias("3dforniture:toilet", "homedecor:toilet")
minetest.register_alias("3dforniture:toilet_open", "homedecor:toilet_open")
minetest.register_alias("3dforniture:sink", "homedecor:sink")
minetest.register_alias("3dforniture:taps", "homedecor:taps")
minetest.register_alias("3dforniture:shower_tray", "homedecor:shower_tray")
minetest.register_alias("3dforniture:shower_head", "homedecor:shower_head")
minetest.register_alias("3dforniture:table_lamp", "homedecor:table_lamp_off")

minetest.register_alias("toilet", "homedecor:toilet")
minetest.register_alias("sink", "homedecor:sink")
minetest.register_alias("taps", "homedecor:taps")
minetest.register_alias("shower_tray", "homedecor:shower_tray")
minetest.register_alias("shower_head", "homedecor:shower_head")
minetest.register_alias("table_lamp", "homedecor:table_lamp_off")

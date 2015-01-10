minetest.register_node("homedecor:power_outlet", {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	description = "Power Outlet",
	tiles = {
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_edges.png",
		"homedecor_outlet_back.png",
		"homedecor_outlet_edges.png"
	},
	inventory_image = "homedecor_outlet_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125, -0.3125, 0.4375, 0.125, 0, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875, -0.375, 0.375, 0.1875, 0.0625, 0.5},
		}
	},
	groups = {cracky=3,dig_immediate=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("homedecor:light_switch", {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	description = "Light switch",
	tiles = {
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_edges.png",
		"homedecor_light_switch_back.png",
		"homedecor_light_switch_front.png"
	},
	inventory_image = "homedecor_light_switch_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125,   -0.5,    0.4375,  0.125,   -0.1875, 0.5 },
			{ -0.03125, -0.3125, 0.40625, 0.03125, -0.25,   0.5 },

		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875,   -0.5625,    0.375,  0.1875,   -0.1250, 0.5 },
		}
	},
	groups = {cracky=3,dig_immediate=2},
	sounds = default.node_sound_stone_defaults()
})


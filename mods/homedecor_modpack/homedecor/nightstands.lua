-- This file supplies nightstands

local S = homedecor.gettext

homedecor.register("nightstand_oak_one_drawer", {
	description = S("Oak Nightstand with One Drawer"),
	tiles = { 'homedecor_nightstand_oak_top.png',
			'homedecor_nightstand_oak_bottom.png',
			'homedecor_nightstand_oak_right.png',
			'homedecor_nightstand_oak_left.png',
			'homedecor_nightstand_oak_back.png',
			'homedecor_nightstand_oak_1_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16,     0, -30/64,  8/16,  8/16,   8/16 },	-- top half
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64}, 	-- drawer face
			{ -8/16, -8/16, -30/64, -7/16,     0,   8/16 },	-- left
			{  7/16, -8/16, -30/64,  8/16,     0,   8/16 },	-- right
			{ -8/16, -8/16,   7/16,  8/16,     0,   8/16 },	-- back
			{ -8/16, -8/16, -30/64,  8/16, -7/16,   8/16 }	-- bottom
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("One-drawer Nightstand"),
	inventory = {
		size=8,
	},
})

homedecor.register("nightstand_oak_two_drawers", {
	description = S("Oak Nightstand with Two Drawers"),
	tiles = { 'homedecor_nightstand_oak_top.png',
			'homedecor_nightstand_oak_bottom.png',
			'homedecor_nightstand_oak_right.png',
			'homedecor_nightstand_oak_left.png',
			'homedecor_nightstand_oak_back.png',
			'homedecor_nightstand_oak_2_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 },	-- top drawer face
			{ -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 },	-- bottom drawer face

		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Two-drawer Nightstand"),
	inventory = {
		size=16,
	},
})

homedecor.register("nightstand_mahogany_one_drawer", {
	description = S("Mahogany Nightstand with One Drawer"),
	tiles = { 'homedecor_nightstand_mahogany_top.png',
			'homedecor_nightstand_mahogany_bottom.png',
			'homedecor_nightstand_mahogany_right.png',
			'homedecor_nightstand_mahogany_left.png',
			'homedecor_nightstand_mahogany_back.png',
			'homedecor_nightstand_mahogany_1_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16,     0, -30/64,  8/16,  8/16,   8/16 },	-- top half
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64}, 	-- drawer face
			{ -8/16, -8/16, -30/64, -7/16,     0,   8/16 },	-- left
			{  7/16, -8/16, -30/64,  8/16,     0,   8/16 },	-- right
			{ -8/16, -8/16,   7/16,  8/16,     0,   8/16 },	-- back
			{ -8/16, -8/16, -30/64,  8/16, -7/16,   8/16 }	-- bottom
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("One-drawer Nightstand"),
	inventory = {
		size=8,
	},
})

homedecor.register("nightstand_mahogany_two_drawers", {
	description = S("Mahogany Nightstand with Two Drawers"),
	tiles = { 'homedecor_nightstand_mahogany_top.png',
			'homedecor_nightstand_mahogany_bottom.png',
			'homedecor_nightstand_mahogany_right.png',
			'homedecor_nightstand_mahogany_left.png',
			'homedecor_nightstand_mahogany_back.png',
			'homedecor_nightstand_mahogany_2_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 },	-- top drawer face
			{ -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 },	-- bottom drawer face

		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Two-drawer Nightstand"),
	inventory = {
		size=16,
	},
})

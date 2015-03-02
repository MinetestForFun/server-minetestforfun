-- Various home electronics

local S = homedecor.gettext

homedecor.register("speaker", {
	description = S("Large Stereo Speaker"),
	tiles = { 'homedecor_speaker_top.png',
			'homedecor_speaker_bottom.png',
			'homedecor_speaker_right.png',
			'homedecor_speaker_left.png',
			'homedecor_speaker_back.png',
			'homedecor_speaker_front.png'},
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("speaker_small", {
	description = S("Small Surround Speaker"),
	tiles = {
		'homedecor_speaker_top.png',
		'homedecor_speaker_bottom.png',
		'homedecor_speaker_right.png',
		'homedecor_speaker_left.png',
		'homedecor_speaker_back.png',
		'homedecor_speaker_front.png'
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, 0, 0.2, 0, 0.4 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, 0, 0.2, 0, 0.4 }
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("stereo", {
	description = S("Stereo Receiver"),
	tiles = { 'homedecor_stereo_top.png',
			'homedecor_stereo_bottom.png',
			'homedecor_stereo_left.png^[transformFX',
			'homedecor_stereo_left.png',
			'homedecor_stereo_back.png',
			'homedecor_stereo_front.png'},
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("projection_screen", {
	description = S("Projection Screen Material"),
	drawtype = 'signlike',
	tiles = { 'homedecor_projection_screen.png' },
	wield_image = 'homedecor_projection_screen_inv.png',
	inventory_image = 'homedecor_projection_screen_inv.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	paramtype2 = 'wallmounted',
	selection_box = {
		type = "wallmounted",
		--wall_side = = <default>
	},
})

homedecor.register("television", {
	description = S("Small CRT Television"),
	tiles = { 'homedecor_television_top.png',
		  'homedecor_television_bottom.png',
		  'homedecor_television_left.png^[transformFX',
		  'homedecor_television_left.png',
		  'homedecor_television_back.png',
		   { name="homedecor_television_front_animated.png",
			  animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=80.0
			  }
		   }
	},
	light_source = LIGHT_MAX - 1,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("dvd_vcr", {
	description = S("DVD and VCR"),
	tiles = {
		"homedecor_dvdvcr_top.png",
		"homedecor_dvdvcr_bottom.png",
		"homedecor_dvdvcr_sides.png",
		"homedecor_dvdvcr_sides.png^[transformFX",
		"homedecor_dvdvcr_back.png",
		"homedecor_dvdvcr_front.png",
	},
	inventory_image = "homedecor_dvdvcr_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.25, 0.3125, -0.375, 0.1875},
			{-0.25, -0.5, -0.25, 0.25, -0.1875, 0.125},
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("telephone", {
	tiles = {
		"homedecor_telephone_sides.png^[transformR180",
		"homedecor_telephone_sides.png",
		"homedecor_telephone_sides.png",
		"homedecor_telephone_sides.png",
		"homedecor_telephone_sides.png",
		"homedecor_telephone_sides.png"
	},
	inventory_image = "homedecor_telephone_inv.png",
	description = "Telephone",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875,     -0.5,       -0.1875,     0.1875,     -0.4375,    0.15},      --  NodeBox1
			{-0.125,      -0.5,       -0.130,      0.125,      -0.3675,     0.15},      --  NodeBox2
			{-0.175,   -0.4375,  -0.175,   0.175,   -0.42,  0.15},    --  NodeBox3
			{-0.16,   -0.42,       -0.16,   0.16,   -0.4025,  0.15},      --  NodeBox4
			{-0.145,   -0.4025,  -0.145,   0.145,   -0.385,  0.15},    --  NodeBox5
			{-0.11,   -0.385,  -0.115,   0.11,   -0.35,  0.15},    --  NodeBox6
			{-0.095,  -0.5,       -0.1,  0.095,  -0.3325,  0.15},      --  NodeBox7
			{-0.075,  -0.345,  0.15,    0.075,   -0.32,  -0.075},  --  NodeBox8
			{0.04,   -0.375,     0.0125,           0.0625,     -0.23,  0.11},       --  NodeBox9
			{-0.0625,     -0.375,     0.0125,           -0.04,  -0.23,  0.11},       --  NodeBox10
			{-0.2075,   -0.25,      0.0375,   0.2075,   -0.21,    0.0875},   --  NodeBox11
			{0.125,       -0.3,    0,           0.25,       -0.25,      0.125},       --  NodeBox12
			{-0.25,       -0.3,    0,           -0.125,     -0.25,      0.125},       --  NodeBox13
			{0.125,    -0.275,  0.017,   0.23,   -0.225,   0.11},    --  NodeBox14
			{-0.23,   -0.275,  0.017,   -0.125,  -0.225,   0.11},    --  NodeBox15
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.1875, 0.25, -0.21, 0.15 }
	}
})


-- Various home electronics

local S = homedecor.gettext

homedecor.register("speaker", {
	description = S("Large Stereo Speaker"),
	mesh="homedecor_speaker_large.obj",
	tiles = {
		"homedecor_speaker_sides.png",
		"homedecor_speaker_front.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:speaker_open", param2 = node.param2})
	end
})

homedecor.register("speaker_open", {
	description = S("Large Stereo Speaker, open front"),
	mesh="homedecor_speaker_large_open.obj",
	tiles = {
		"homedecor_speaker_sides.png",
		"homedecor_speaker_driver.png",
		"homedecor_speaker_open_front.png",
		"homedecor_generic_metal_black.png"
	},
	groups = { snappy = 3, not_in_creative_inventory=1 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "homedecor:speaker", param2 = node.param2})
	end
})

local spk_cbox = {
	type = "fixed",
	fixed = { -3/16, -8/16, 1/16, 3/16, -2/16, 7/16 }
}

homedecor.register("speaker_small", {
	description = S("Small Surround Speaker"),
	mesh="homedecor_speaker_small.obj",
	tiles = {
		"homedecor_speaker_sides.png",
		"homedecor_speaker_front.png"
	},
	selection_box = spk_cbox,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
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
	sounds = default.node_sound_wood_defaults(),
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
	light_source = default.LIGHT_MAX - 1,
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

local tel_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.1875, 0.25, -0.21, 0.15 }
}

homedecor.register("telephone", {
	mesh = "homedecor_telephone.obj",
	tiles = {
		"homedecor_telephone_dial.png",
		"homedecor_telephone_base.png",
		"homedecor_telephone_handset.png",
		"homedecor_telephone_cord.png",
	},
	inventory_image = "homedecor_telephone_inv.png",
	description = "Telephone",
	groups = {snappy=3},
	selection_box = tel_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_abm({
	nodenames = "homedecor:telephone",
	label = "sfx",
	interval = 30,
	chance = 15,
	action = function(pos, node)
		minetest.sound_play("homedecor_telephone_ringing", {
		pos = pos,
		gain = 1.0,
		max_hear_distance = 5
	})
	end
})

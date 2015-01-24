-- This file adds fences of various types

local signs_modpath = minetest.get_modpath("signs_lib")

local sign_post_model = {
	type = "fixed",
	fixed = {
			{-0.4375, -0.25, -0.1875, 0.4375, 0.375, -0.125},
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
	}
}

if signs_modpath then
	sign_post_model = signs_lib.sign_post_model.nodebox
end

local S = homedecor.gettext

homedecor.register("fence_brass", {
	description = S("Brass Fence/railing"),
	drawtype = "fencelike",
	tiles = {"homedecor_tile_brass.png"},
	inventory_image = "homedecor_fence_brass.png",
	selection_box = homedecor.nodebox.bar_y(1/7),
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("fence_wrought_iron", {
	description = S("Wrought Iron Fence/railing"),
	drawtype = "fencelike",
	tiles = {"homedecor_tile_wrought_iron.png"},
	inventory_image = "homedecor_fence_wrought_iron.png",
	selection_box = homedecor.nodebox.bar_y(1/7),
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
})

-- brass/wrought iron with signs:

homedecor.register("fence_brass_with_sign", {
	description = S("Brass Fence/railing with sign"),
	tiles = {
		"homedecor_sign_brass_post_top.png",
		"homedecor_sign_brass_post_bottom.png",
		"homedecor_sign_brass_post_side.png",
		"homedecor_sign_brass_post_side.png",
		"homedecor_sign_brass_post_back.png",
		"homedecor_sign_brass_post_front.png",
	},
	wield_image = "homedecor_sign_brass_post.png",
	node_box = sign_post_model,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	drop = {
		max_items = 2,
		items = {
			{ items = { "default:sign_wall" }},
			{ items = { "homedecor:fence_brass" }},
		},
	},
})

homedecor.register("fence_wrought_iron_with_sign", {
	description = S("Wrought Iron Fence/railing with sign"),
		tiles = {
		"homedecor_sign_wrought_iron_post_top.png",
		"homedecor_sign_wrought_iron_post_bottom.png",
		"homedecor_sign_wrought_iron_post_side.png",
		"homedecor_sign_wrought_iron_post_side.png",
		"homedecor_sign_wrought_iron_post_back.png",
		"homedecor_sign_wrought_iron_post_front.png",
	},
	wield_image = "homedecor_sign_wrought_iron_post.png",
	node_box = sign_post_model,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	drop = {
		max_items = 2,
		items = {
			{ items = { "default:sign_wall" }},
			{ items = { "homedecor:fence_wrought_iron" }},
		},
	},
})

-- other types of fences

homedecor.register("fence_picket", {
	description = S("Unpainted Picket Fence"),
	tiles = {
		"homedecor_blanktile.png",
		"homedecor_blanktile.png",
		"homedecor_fence_picket.png",
		"homedecor_fence_picket.png",
		"homedecor_fence_picket_backside.png",
		"homedecor_fence_picket.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.498, 0.5, 0.5, 0.498 }
	},
})

homedecor.register("fence_picket_corner", {
	description = S("Unpainted Picket Fence Corner"),
	tiles = {
		"homedecor_blanktile.png",
		"homedecor_blanktile.png",
		"homedecor_fence_picket.png",
		"homedecor_fence_picket_backside.png",
		"homedecor_fence_picket_backside.png",
		"homedecor_fence_picket.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
	type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.4, 0.5, 0.4 }
		}
	},
	node_box = {
	type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.498, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.498, 0.5, 0.5 }
		}
	},
})

homedecor.register("fence_picket_white", {
	description = S("White Picket Fence"),
	tiles = {
		"homedecor_blanktile.png",
		"homedecor_blanktile.png",
		"homedecor_fence_picket_white.png",
		"homedecor_fence_picket_white.png",
		"homedecor_fence_picket_white_backside.png",
		"homedecor_fence_picket_white.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.498, 0.5, 0.5, 0.498 }
	},
})

homedecor.register("fence_picket_corner_white", {
	description = S("White Picket Fence Corner"),
	tiles = {
		"homedecor_blanktile.png",
		"homedecor_blanktile.png",
		"homedecor_fence_picket_white.png",
		"homedecor_fence_picket_white_backside.png",
		"homedecor_fence_picket_white_backside.png",
		"homedecor_fence_picket_white.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
	type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.4, 0.5, 0.4 }
		}
	},
	node_box = {
	type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.498, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.498, 0.5, 0.5 }
		}
	},
})

homedecor.register("fence_privacy", {
	description = S("Wooden Privacy Fence"),
	tiles = {
		"homedecor_fence_privacy_tb.png",
		"homedecor_fence_privacy_tb.png",
		"homedecor_fence_privacy_sides.png",
		"homedecor_fence_privacy_sides.png",
		"homedecor_fence_privacy_backside.png",
		"homedecor_fence_privacy_front.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 5/16, 0.5, 0.5, 8/16 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 5/16, -5/16,  8/16, 7/16 },	-- left part
			{ -4/16, -8/16, 5/16,  3/16,  8/16, 7/16 },	-- middle part
			{  4/16, -8/16, 5/16,  8/16,  8/16, 7/16 },	-- right part
			{ -8/16, -2/16, 7/16,  8/16,  2/16, 8/16 },	-- connecting rung
		}
	},
})

homedecor.register("fence_privacy_corner", {
	description = S("Wooden Privacy Fence Corner"),
	tiles = {
		"homedecor_fence_privacy_corner_top.png",
		"homedecor_fence_privacy_corner_bottom.png",
		"homedecor_fence_privacy_corner_right.png",
		"homedecor_fence_privacy_backside2.png",
		"homedecor_fence_privacy_backside.png",
		"homedecor_fence_privacy_corner_front.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 5/16,   0.5, 0.5,  0.5 },
			{ -0.5, -0.5, -0.5, -5/16, 0.5, 5/16 },
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -7/16, -8/16, 5/16, -5/16, 8/16, 7/16 },	-- left part
			{ -4/16, -8/16, 5/16,  3/16, 8/16, 7/16 },	-- middle part
			{  4/16, -8/16, 5/16,  8/16, 8/16, 7/16 },	-- right part
			{ -8/16, -2/16, 7/16,  8/16, 2/16, 8/16 },	-- back-side connecting rung

			{ -7/16, -8/16,  4/16, -5/16, 8/16,  7/16 },	-- back-most part
			{ -7/16, -8/16, -4/16, -5/16, 8/16,  3/16 },	-- middle part
			{ -7/16, -8/16, -8/16, -5/16, 8/16, -5/16 },	-- front-most part
			{ -8/16, -2/16, -8/16, -7/16, 2/16,  7/16 },	-- left-side connecting rung
		}
	},
})

homedecor.register("fence_barbed_wire", {
	description = S("Barbed Wire Fence"),
	tiles = {"homedecor_fence_barbed_wire.png"},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.375, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 6/16, -6/16, 8/16, 8/16 },	-- left post
			{  6/16, -8/16, 6/16,  8/16, 8/16, 8/16 }, 	-- right post
			{ -6/16, -8/16, 7/16,  6/16, 8/16, 7/16 }	-- the wire
		}
	},
})

homedecor.register("fence_barbed_wire_corner", {
	description = S("Barbed Wire Fence Corner"),
	tiles = {
		"homedecor_fence_barbed_wire.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.375, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.375, 0.5, 0.375 }
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16,  6/16, -6/16, 8/16,  8/16 },	-- left post
			{  6/16, -8/16,  6/16,  8/16, 8/16,  8/16 }, 	-- right post
			{ -6/16, -8/16,  7/16,  6/16, 8/16,  7/16 },	-- the wire

			{  -8/16, -8/16, -8/16, -6/16, 8/16, -6/16 },	-- front post
			{  -7/16, -8/16, -6/16, -7/16, 8/16,  6/16 }	-- more wire
		}
	},
})

homedecor.register("fence_chainlink", {
	description = S("Chainlink Fence"),
	tiles = {
		"homedecor_fence_chainlink_tb.png",
		"homedecor_fence_chainlink_tb.png",
		"homedecor_fence_chainlink_sides.png",
		"homedecor_fence_chainlink_sides.png",
		"homedecor_fence_chainlink_fb.png",
		"homedecor_fence_chainlink_fb.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.375, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16,  6/16, -7/16,  8/16,  8/16 },	-- left post
			{  7/16, -8/16,  6/16,  8/16,  8/16,  8/16 }, 	-- right post
			{ -8/16,  7/16, 13/32,  8/16,  8/16, 15/32 },	-- top piece
			{ -8/16, -8/16, 13/32,  8/16, -7/16, 15/32 },	-- bottom piece
			{ -8/16, -8/16,  7/16,  8/16,  8/16,  7/16 }	-- the chainlink itself
		}
	},
})

homedecor.register("fence_chainlink_corner", {
	description = S("Chainlink Fence Corner"),
	tiles = {
		"homedecor_fence_chainlink_corner_top.png",
		"homedecor_fence_chainlink_corner_top.png",
		"homedecor_fence_chainlink_corner_front.png",
		"homedecor_fence_chainlink_corner_front.png",
		"homedecor_fence_chainlink_corner_front.png",
		"homedecor_fence_chainlink_corner_front.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.375, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.375, 0.5, 0.375 }
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{  -8/16, -8/16,  6/16,  -6/16,  8/16,  8/16 },	-- left post, rear
			{  -8/16, -8/16, -8/16,  -6/16,  8/16, -7/16 }, -- left post, front
			{   7/16, -8/16,  6/16,   8/16,  8/16,  8/16 }, -- right post, rear
			{  -8/16,  7/16, 13/32,   8/16,  8/16, 15/32 },	-- top piece, rear
			{  -8/16, -8/16, 13/32,   8/16, -7/16, 15/32 },	-- bottom piece, rear
			{ -15/32,  7/16, -8/16, -13/32,  8/16,  8/16 },	-- top piece, side
			{ -15/32, -8/16, -8/16, -13/32, -7/16,  8/16 },	-- bottom piece, side
			{  -8/16, -8/16,  7/16,   8/16,  8/16,  7/16 },	-- the chainlink itself, rear
			{  -7/16, -8/16, -8/16,  -7/16,  8/16,  8/16 }	-- the chainlink itself, side
		}
	},
})

homedecor.register("fence_wrought_iron_2", {
	description = S("Wrought Iron fence (type 2)"),
	tiles = {
		"homedecor_fence_wrought_iron_2_tb.png",
		"homedecor_fence_wrought_iron_2_tb.png",
		"homedecor_fence_wrought_iron_2_sides.png",
		"homedecor_fence_wrought_iron_2_sides.png",
		"homedecor_fence_wrought_iron_2_fb.png",
		"homedecor_fence_wrought_iron_2_fb.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.42, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16,  14/32, -7.75/16,  8/16,  16/32 }, -- left post
			{  7.75/16, -8/16,  14/32,  8/16,  8/16,  16/32 }, -- right post
			{ -8/16,  7.75/16, 14/32,  8/16,  8/16, 16/32 }, -- top piece
			{ -8/16,  -0.015625, 14.75/32,  8/16,  0.015625, 15.25/32 }, -- cross piece
			{ -0.015625, -8/16,  14.75/32,  0.015625,  8/16,  15.25/32 }, -- cross piece
			{ -8/16, -8/16, 14/32,  8/16, -7.75/16, 16/32 }, -- bottom piece
			{ -8/16, -8/16,  15/32,  8/16,  8/16,  15/32 }	-- the grid itself
		}
	},
})

homedecor.register("fence_wrought_iron_2_corner", {
	description = S("Wrought Iron fence (type 2) Corner"),
	tiles = {
		"homedecor_fence_corner_wrought_iron_2_tb.png",
		"homedecor_fence_corner_wrought_iron_2_tb.png",
		"homedecor_fence_corner_wrought_iron_2_lr.png",
		"homedecor_fence_corner_wrought_iron_2_lr.png^[transformFX",
		"homedecor_fence_corner_wrought_iron_2_fb.png^[transformFX",
		"homedecor_fence_corner_wrought_iron_2_fb.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.42, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, -0.5, -0.42, 0.5, 0.5 }
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.453125, -0.453125, 0.5, 0.5 }, -- corner edge
			{ -7.5/16,  7.75/16, 14/32,  8/16,  8/16, 16/32 },	-- top piece
			{ -7.5/16, -8/16, 14/32,  8/16, -7.75/16, 16/32 },	-- bottom piece
			{ -16/32,  7.75/16, -8/16, -14/32,  8/16,  8/16 },	-- top piece, side
			{ -16/32, -8/16, -8/16, -14/32, -7.75/16,  8/16 },	-- bottom piece, side
			{ -7.5/16, -8/16,  7.5/16,  8/16,  8/16,  7.5/16 },	-- the grid itself
			{ -7.5/16, -8/16, -8/16,  -7.5/16,  8/16,  7.5/16 },	-- the grid itself, side
			{ -15.5/32, -0.5, -0.5, -14.5/32, 0.5, -0.484375 }, -- left post side
			{  7.75/16, -8/16,  14.5/32,  8/16,  8/16,  15.5/32 }, -- right post
			{ -8/16,  -0.015625, 14.75/32,  8/16,  0.015625, 15.25/32 }, -- cross piece
			{ -0.015625, -8/16,  14.75/32,  0.015625,  8/16,  15.25/32 }, -- cross piece
			{ -15.25/32, -0.5, -0.015625, -14.75/32, 0.5, 0.015625 }, -- cross piece side
			{ -15.25/32, -0.015625, -0.5, -14.75/32, 0.015625, 0.5 } -- cross piece side
		}
	},
})

if signs_modpath then
	signs_lib.register_fence_with_sign("homedecor:fence_brass", "homedecor:fence_brass_with_sign")
	signs_lib.register_fence_with_sign("homedecor:fence_wrought_iron", "homedecor:fence_wrought_iron_with_sign")
end


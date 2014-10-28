-- Various kinds of tables

local S = homedecor.gettext

local materials = {
	{"glass","Glass"},
	{"wood","Wood"}
}

for i in ipairs(materials) do
	local m = materials[i][1]
	local d = materials[i][2]
	local s = nil

	if m == "glass" then
		s = default.node_sound_glass_defaults()
	else
		s = default.node_sound_wood_defaults()
	end

-- small square tables

	minetest.register_node("homedecor:"..m.."_table_small_square_b", {
		description = S(d.." Table (Small, Square)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_square_tb.png',
			'homedecor_'..m..'_table_small_square_tb.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png'
		},
		wield_image = 'homedecor_'..m..'_table_small_square_tb.png',
		inventory_image = 'homedecor_'..m..'_table_small_square_tb.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",

		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4375, -0.5, -0.5,     0.4375, -0.4375, 0.5    },
				{ -0.5,    -0.5, -0.4375,  0.5,    -0.4375, 0.4375 }
			},
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
		},
		on_place = minetest.rotate_node
	})

	minetest.register_node('homedecor:'..m..'_table_small_square_t', {
		description = S(d.." Table (Small, Square)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_square_tb.png',
			'homedecor_'..m..'_table_small_square_tb.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png'
		},
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",

		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4375, 0.4375, -0.5,     0.4375, 0.5, 0.5    },
				{ -0.5,    0.4375, -0.4375,  0.5,    0.5, 0.4375 }
			},
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5,  0.4375, -0.5,  0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_small_square_b'
	})

	minetest.register_node('homedecor:'..m..'_table_small_square_s', {
		description = S(d.." Table (Small, Square)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_edges.png',
			'homedecor_'..m..'_table_small_square_tb.png',
			'homedecor_'..m..'_table_small_square_tb.png',
		},
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",

		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4375, -0.5,    0.4375, 0.4375, 0.5,    0.5 },
				{ -0.5,    -0.4375, 0.4375, 0.5,    0.4375, 0.5 }
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_small_square_b'
	})

-- small round tables

	minetest.register_node('homedecor:'..m..'_table_small_round_b', {
		description = S(d.." Table (Small, Round)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_round_tb.png',
			'homedecor_'..m..'_table_small_round_tb.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png'
		},
		wield_image = 'homedecor_'..m..'_table_small_round_tb.png',
		inventory_image = 'homedecor_'..m..'_table_small_round_tb.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.25,   -0.5, -0.5,    0.25,   -0.4375, 0.5    },
				{ -0.375,  -0.5, -0.4375, 0.375,  -0.4375, 0.4375 },
				{ -0.5,    -0.5, -0.25,   0.5,    -0.4375, 0.25   },
				{ -0.4375, -0.5, -0.375,  0.4375, -0.4375, 0.375  },
				{ -0.25,   -0.5, -0.5,    0.25,   -0.4375, 0.5    },
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		},
		on_place = minetest.rotate_node
	})

	minetest.register_node('homedecor:'..m..'_table_small_round_t', {
		description = S(d.." Table (Small, Round)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_round_tb.png',
			'homedecor_'..m..'_table_small_round_tb.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png'
		},
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.25,   0.4375, -0.5,    0.25,   0.5, 0.5    },
				{ -0.375,  0.4375, -0.4375, 0.375,  0.5, 0.4375 },
				{ -0.5,    0.4375, -0.25,   0.5,    0.5, 0.25   },
				{ -0.4375, 0.4375, -0.375,  0.4375, 0.5, 0.375  },
				{ -0.25,   0.4375, -0.5,    0.25,   0.5, 0.5    },
			}
		},
		selection_box = {
			type = "fixed",
			fixed =    { -0.5, 0.4375, -0.5, 0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_small_round_b'
	})

	minetest.register_node('homedecor:'..m..'_table_small_round_s', {
		description = S(d.." Table (Small, Round)"),
		drawtype = 'nodebox',
		tiles = {
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_edges.png',
			'homedecor_'..m..'_table_small_round_tb.png',
			'homedecor_'..m..'_table_small_round_tb.png',
		},
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.25,   -0.5,    0.4375,  0.25,   0.5,    0.5 },
				{ -0.375,  -0.4375, 0.4375,  0.375,  0.4375, 0.5 },
				{ -0.5,    -0.25,   0.4375,  0.5,    0.25,   0.5 },
				{ -0.4375, -0.375,  0.4375,  0.4375, 0.375,  0.5 },
				{ -0.25,   -0.5,    0.4375,  0.25,   0.5,    0.5 },
			}
		},
		selection_box = {
			type = "fixed",
			fixed =   { -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_small_round_b'
	})

-- Large square table pieces

	minetest.register_node('homedecor:'..m..'_table_large_b', {
		description = S(d.." Table Piece (large)"),
		drawtype = 'nodebox',
		tiles = { 
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png'
		},
		wield_image = 'homedecor_'..m..'_table_large_tb.png',
		inventory_image = 'homedecor_'..m..'_table_large_tb.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		},
		on_place = minetest.rotate_node
	})

	minetest.register_node('homedecor:'..m..'_table_large_t', {
		description = S(d.." Table Piece (large)"),
		drawtype = 'nodebox',
		tiles = { 
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png'
		},
		wield_image = 'homedecor_'..m..'_table_large_tb.png',
		inventory_image = 'homedecor_'..m..'_table_large_tb.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed =    { -0.5, 0.4375, -0.5, 0.5, 0.5, 0.5 },
		},
		selection_box = {
			type = "fixed",
			fixed =    { -0.5, 0.4375, -0.5, 0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_large_b'
	})

	minetest.register_node('homedecor:'..m..'_table_large_s', {
		description = S(d.." Table Piece (large)"),
		drawtype = 'nodebox',
		tiles = { 
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_tb.png',
		},
		wield_image = 'homedecor_'..m..'_table_large_tb.png',
		inventory_image = 'homedecor_'..m..'_table_large_tb.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3, not_in_creative_inventory=1 },
		sounds = s,
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed =   { -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 },
		},
		selection_box = {
			type = "fixed",
			fixed =   { -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 },
		},
		drop = 'homedecor:'..m..'_table_large_b'
	})

	minetest.register_alias('homedecor:'..m..'_table_large', 'homedecor:'..m..'_table_large_b')
	minetest.register_alias('homedecor:'..m..'_table_small_square', 'homedecor:'..m..'_table_small_square_b')
	minetest.register_alias('homedecor:'..m..'_table_small_round', 'homedecor:'..m..'_table_small_round_b')

end

minetest.register_node('homedecor:utility_table_top', {
	description = S("Utility Table"),
	tiles = {
		'homedecor_utility_table_tb.png',
		'homedecor_utility_table_tb.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png'
	},
	wield_image = 'homedecor_utility_table_tb.png',
	inventory_image = 'homedecor_utility_table_tb.png',
	drawtype = "nodebox",
	sunlight_propagates = false,
	paramtype = "light",
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "wallmounted",
	node_box = {
		type = "wallmounted",
		wall_bottom = { -0.5, -0.5,    -0.5,  0.5,   -0.4375, 0.5 },
		wall_top =    { -0.5,  0.4375, -0.5,  0.5,    0.5,    0.5 },
		wall_side =   { -0.5, -0.5,    -0.5, -0.4375, 0.5,    0.5 },
	},
        selection_box = {
		type = "wallmounted",
		wall_bottom = { -0.5, -0.5,    -0.5,  0.5,   -0.4375, 0.5 },
		wall_top =    { -0.5,  0.4375, -0.5,  0.5,    0.5,    0.5 },
		wall_side =   { -0.5, -0.5,    -0.5, -0.4375, 0.5,    0.5 },
	},
})

-- Various kinds of table legs

minetest.register_node("homedecor:table_legs_brass", {
        description = S("Brass Table Legs"),
        drawtype = "plantlike",
        tiles = {"homedecor_table_legs_brass.png"},
        inventory_image = "homedecor_table_legs_brass.png",
        wield_image = "homedecor_table_legs_brass.png",
        paramtype = "light",
        walkable = false,
        groups = {snappy=3},
        sounds = default.node_sound_leaves_defaults(),
	walkable = true,
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node("homedecor:table_legs_wrought_iron", {
        description = S("Wrought Iron Table Legs"),
        drawtype = "plantlike",
        tiles = {"homedecor_table_legs_wrought_iron.png"},
        inventory_image = "homedecor_table_legs_wrought_iron.png",
        wield_image = "homedecor_table_legs_wrought_iron.png",
        paramtype = "light",
        walkable = false,
        groups = {snappy=3},
        sounds = default.node_sound_leaves_defaults(),
	walkable = true,
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node('homedecor:utility_table_legs', {
	description = S("Legs for Utility Table"),
	drawtype = "plantlike",
	tiles = { 'homedecor_utility_table_legs.png' },
	inventory_image = 'homedecor_utility_table_legs_inv.png',
	wield_image = 'homedecor_utility_table_legs.png',
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node("homedecor:desk", {
	drawtype = "nodebox",
	description = "Desk",
	tiles = {
		"homedecor_desk_top_l.png",
		"homedecor_desk_bottom_l.png",
		"homedecor_desk_rside_l.png",
		"homedecor_desk_lside_l.png",
		"homedecor_desk_back_l.png",
		"homedecor_desk_front_l.png"
	},
	inventory_image = "homedecor_desk_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.375, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, 0.5, 0.5, 0.5},
			{-0.4375, -0.4375, -0.5, 0.3125, -0.0625, -0.4375},
			{-0.4375, 0, -0.5, 0.3125, 0.375, 0.5},
			{0.3125, -0.375, 0.4375, 0.5, 0.25, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 1.5, 0.5, 0.5 }
	},
	groups = { snappy = 3 },
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:desk", "homedecor:desk_r", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:desk_r" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:desk_r", {
	drawtype = "nodebox",
	tiles = {
		"homedecor_desk_top_r.png",
		"homedecor_desk_bottom_r.png",
		"homedecor_desk_rside_r.png",
		"homedecor_desk_lside_r.png",
		"homedecor_desk_back_r.png",
		"homedecor_desk_front_r.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.4375, 0.5, 0.5, 0.5},
			{0.375, -0.5, -0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.3125, -0.4375, 0.5, 0.375, 0.5},
			{-0.5, 0.3125, -0.4375, -0.4375, 0.5, 0.5},
			{-0.5, -0.375, 0.4375, 0.4375, 0.25, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0,0,0,0,0,0 }
	},
	groups = { snappy = 3, not_in_creative_inventory=1 }
})


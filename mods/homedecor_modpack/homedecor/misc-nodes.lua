-- Various misc. nodes

local S = homedecor.gettext

homedecor.register("ceiling_paint", {
	description = S("Textured Ceiling Paint"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_paint.png' },
	inventory_image = 'homedecor_ceiling_paint_roller.png',
	wield_image = 'homedecor_ceiling_paint_roller.png',
	sunlight_propagates = true,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
        selection_box = {
			type = "wallmounted",
                         --wall_top = <default>
                         --wall_bottom = <default>
                         --wall_side = <default>
                        },
})

homedecor.register("ceiling_tile", {
	description = S("Drop-Ceiling Tile"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_tile.png' },
	wield_image = 'homedecor_ceiling_tile.png',
	inventory_image = 'homedecor_ceiling_tile.png',
	sunlight_propagates = true,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
        selection_box = {
			type = "wallmounted",
                         --wall_top = <default>
                         --wall_bottom = <default>
                         --wall_side = <default>
                        },
})

homedecor.register("rug_small", {
	description = S("Small Throw Rug"),
	drawtype = 'signlike',
	tiles = { 'homedecor_rug_small.png' },
	wield_image = 'homedecor_rug_small.png',
	inventory_image = 'homedecor_rug_small.png',
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
        selection_box = {
			type = "wallmounted",
                         --wall_top = <default>
                         --wall_bottom = <default>
                         --wall_side = <default>
                        },
})

homedecor.register("rug_large", {
	description = S("Large Area Rug"),
	drawtype = 'signlike',
	tiles = { 'homedecor_rug_large.png' },
	wield_image = 'homedecor_rug_large.png',
	inventory_image = 'homedecor_rug_large.png',
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
        selection_box = {
			type = "wallmounted",
                         --wall_top = <default>
                         --wall_bottom = <default>
                         --wall_side = <default>
                        },
	})

homedecor.register("flower_pot_terracotta", {
	description = S("Terracotta Flower Pot"),
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_terracotta.png" },
	groups = { snappy = 3, potting_soil=1},
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("flower_pot_black", {
	description = S("Black Plastic Flower Pot"),
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_black.png" },
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("flower_pot_green", {
	description = S("Green Plastic Flower Pot"),
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_green.png" },
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_leaves_defaults(),
})

homedecor.register("pole_brass", {
    description = S("Brass Pole"),
	mesh = "homedecor_round_pole.obj",
    tiles = {"homedecor_tile_brass2.png"},
    inventory_image = "homedecor_pole_brass_inv.png",
    wield_image = "homedecor_pole_brass_inv.png",
    selection_box = {
            type = "fixed",
            fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
    },
    collision_box = {
            type = "fixed",
            fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
    },
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

homedecor.register("pole_wrought_iron", {
    description = S("Wrought Iron Pole"),
    tiles = {"homedecor_tile_wrought_iron2.png"},
    inventory_image = "homedecor_pole_wrought_iron_inv.png",
    wield_image = "homedecor_pole_wrought_iron_inv.png",
    selection_box = {
            type = "fixed",
            fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
    },
	node_box = {
		type = "fixed",
                fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
	},
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

local welcome_mat_colors = { "green", "brown", "grey" }

for _, color in ipairs(welcome_mat_colors) do
	homedecor.register("welcome_mat_"..color, {
		description = "Welcome Mat ("..color..")",
		tiles = {
			"homedecor_welcome_mat_"..color..".png",
			"homedecor_welcome_mat_bottom.png",
			"homedecor_welcome_mat_"..color..".png",
		},
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.25},
		}),
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.375, 0.5, -0.46875, 0.375 }
		}
	})
end

homedecor.register("chimney", {
	description = "Chimney",
	tiles = {
		"homedecor_chimney_top.png",
		"homedecor_chimney_bottom.png",
		"homedecor_chimney_sides.png",
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, -0.1875},
			{-0.25, -0.5, 0.1875, 0.25, 0.5, 0.25},
			{-0.25, -0.5, -0.25, -0.1875, 0.5, 0.25},
			{0.1875, -0.5, -0.25, 0.25, 0.5, 0.25},
		}
	},
	selection_box = homedecor.nodebox.bar_y(0.25),
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

homedecor.register("fishtank", {
	description = "Fishtank",
	tiles = {
		"homedecor_fishtank_top.png",
		"homedecor_fishtank_bottom.png",
		"homedecor_fishtank_right.png",
		"homedecor_fishtank_left.png",
		"homedecor_fishtank_back.png",
		"homedecor_fishtank_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,    -0.5,    -0.375,  0.5,    -0.4375, 0.375},
			{-0.4375, -0.4375, -0.3125, 0.4375,  0.1875, 0.3125},
			{-0.4375,  0.1875, -0.1875, 0.4375,  0.25,   0.1875},
			{-0.1875,  0.0625,  0.0625, 0.1875,  0.25,   0.375},
			{ 0.125,  -0.5,     0.25,   0.1875,  0.1875, 0.375},
			{-0.375,   0.25,   -0.125,  0.375,   0.3125, 0.125},
		}
	},
	use_texture_alpha = true,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.375, 0.5, 0.3125, 0.375 }
	},
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		fdir = minetest.get_node(pos).param2
		minetest.add_node(pos, {name = "homedecor:fishtank_lighted", param2 = fdir})
	end
})

homedecor.register("fishtank_lighted", {
	description = "Fishtank",
	tiles = {
		"homedecor_fishtank_top.png",
		"homedecor_fishtank_bottom.png",
		"homedecor_fishtank_right_lighted.png",
		"homedecor_fishtank_left_lighted.png",
		"homedecor_fishtank_back_lighted.png",
		"homedecor_fishtank_front_lighted.png"
	},
	light_source = LIGHT_MAX-4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,    -0.5,    -0.375,  0.5,    -0.4375, 0.375},
			{-0.4375, -0.4375, -0.3125, 0.4375,  0.1875, 0.3125},
			{-0.4375,  0.1875, -0.1875, 0.4375,  0.25,   0.1875},
			{-0.1875,  0.0625,  0.0625, 0.1875,  0.25,   0.375},
			{ 0.125,  -0.5,     0.25,   0.1875,  0.1875, 0.375},
			{-0.375,   0.25,   -0.125,  0.375,   0.3125, 0.125},
		}
	},
	use_texture_alpha = true,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.375, 0.5, 0.3125, 0.375 }
	},
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		fdir = minetest.get_node(pos).param2
		minetest.add_node(pos, {name = "homedecor:fishtank", param2 = fdir})
	end
})

homedecor.register("cardboard_box_big", {
	description = S("Cardboard box (big)"),
	tiles = {
		'homedecor_cardbox_big_tb.png',
		'homedecor_cardbox_big_tb.png',
		'homedecor_cardbox_big_sides.png',
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Cardboard box"),
	inventory = {
		size=24,
	},
})

homedecor.register("cardboard_box", {
	description = S("Cardboard box"),
	tiles = {
		'homedecor_cardbox_tb.png',
		'homedecor_cardbox_tb.png',
		'homedecor_cardbox_sides.png',
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125},
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Cardboard box"),
	inventory = {
		size=8,
	},
})

homedecor.register("dvd_cd_cabinet", {
	description = "DVD/CD cabinet",
	tiles = {
		"homedecor_dvdcd_cabinet_top.png",
		"homedecor_dvdcd_cabinet_top.png",
		"homedecor_dvdcd_cabinet_sides.png",
		"homedecor_dvdcd_cabinet_sides.png^[transformFX",
		"homedecor_dvdcd_cabinet_back.png",
		"homedecor_dvdcd_cabinet_front.png",
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0, 0.5, 0.5, 0.5},
			{-0.0625, -0.5, 0, 0.0625, 0.5, 0.5},
			{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
			{-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, 0.0625, 0.5, 0.5, 0.4375},
			{-0.375, -0.5, 0.02756, -0.125, 0.5, 0.5},
			{0.125, -0.5, 0.01217, 0.375, 0.5, 0.5},
		}
	},
	selection_box = homedecor.nodebox.slab_z(0.5),
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("filing_cabinet", {
	description = S("Filing Cabinet"),
	tiles = {
		'forniture_wood.png',
		'homedecor_filing_cabinet_bottom.png',
		'forniture_wood.png',
		'forniture_wood.png',
		'forniture_wood.png',
		'homedecor_filing_cabinet_front.png'
	},
        selection_box = { type = "regular" },
        node_box = {
                type = "fixed",
		fixed = {
			{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
			{ -7/16, -7/16, -8/16,  7/16,  7/16,   8/16 },	-- drawer
		}
        },
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Filing cabinet"),
	inventory = {
		size=16,
	},
})

homedecor.register("doghouse_base", {
	tiles = {
		"homedecor_doghouse_base_top.png",
		"homedecor_doghouse_base_bottom.png",
		"homedecor_doghouse_base_side.png",
		"homedecor_doghouse_base_side.png",
		"homedecor_doghouse_base_side.png",
		"homedecor_doghouse_base_front.png"
	},
	description = "Doghouse",
	inventory_image = "homedecor_doghouse_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, -0.4375, 0.4375, -0.3125, -0.3125}, -- NodeBox1
			{0.3125, -0.5, 0.3125, 0.4375, -0.3125, 0.4375}, -- NodeBox2
			{-0.4375, -0.5, 0.3125, -0.3125, -0.3125, 0.4375}, -- NodeBox3
			{-0.4375, -0.5, -0.4375, -0.3125, -0.3125, -0.3125}, -- NodeBox4
			{-0.4375, -0.3125, -0.4375, -0.375, 0.5, 0.4375}, -- NodeBox5
			{-0.4375, 0.3125, -0.375, 0.4375, 0.5, -0.3125}, -- NodeBox6
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.25, 0.4375}, -- NodeBox7
			{-0.375, -0.3125, -0.375, -0.1875, 0.4375, -0.3125}, -- NodeBox8
			{0.1875, -0.3125, -0.375, 0.4375, 0.5, -0.3125}, -- NodeBox9
			{0.375, -0.25, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox10
			{-0.4375, -0.3125, 0.375, 0.4375, 0.5, 0.4375}, -- NodeBox11
		}
	},
	selection_box = homedecor.nodebox.slab_y(1.5),
	groups = {snappy=3},
	expand = { top="homedecor:doghouse_roof" },
})

homedecor.register("doghouse_roof", {
	tiles = {
		"homedecor_doghouse_roof_top.png",
		"homedecor_doghouse_roof_bottom.png",
		"homedecor_doghouse_roof_side.png",
		"homedecor_doghouse_roof_side.png",
		"homedecor_doghouse_roof_front.png",
		"homedecor_doghouse_roof_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.4375, -0.4375, 0.5}, -- NodeBox17
			{-0.4375, -0.4375, -0.5, -0.375, -0.375, 0.5}, -- NodeBox18
			{-0.375, -0.375, -0.5, -0.3125, -0.3125, 0.5}, -- NodeBox19
			{-0.3125, -0.3125, -0.5, -0.25, -0.25, 0.5}, -- NodeBox20
			{-0.25, -0.25, -0.5, -0.1875, -0.1875, 0.5}, -- NodeBox21
			{-0.1875, -0.1875, -0.5, -0.125, -0.125, 0.5}, -- NodeBox22
			{-0.125, -0.125, -0.5, -0.0625, -0.0625, 0.5}, -- NodeBox23
			{-0.0625, -0.0625, -0.5, 0.0625, 0, 0.5}, -- NodeBox24
			{0.0625, -0.125, -0.5, 0.125, -0.0625, 0.5}, -- NodeBox25
			{0.125, -0.1875, -0.5, 0.1875, -0.125, 0.5}, -- NodeBox26
			{0.1875, -0.25, -0.5, 0.25, -0.1875, 0.5}, -- NodeBox27
			{0.25, -0.3125, -0.5, 0.3125, -0.25, 0.5}, -- NodeBox28
			{0.3125, -0.375, -0.5, 0.375, -0.3125, 0.5}, -- NodeBox29
			{0.375, -0.4375, -0.5, 0.4375, -0.375, 0.5}, -- NodeBox30
			{0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox31
			{-0.4375, -0.5, -0.375, 0.4375, -0.4375, 0.4375}, -- NodeBox32
			{-0.375, -0.4375, -0.375, 0.375, -0.375, 0.4375}, -- NodeBox33
			{-0.3125, -0.375, -0.375, 0.3125, -0.3125, 0.4375}, -- NodeBox34
			{-0.25, -0.3125, -0.375, 0.25, -0.25, 0.4375}, -- NodeBox35
			{-0.1875, -0.25, -0.375, 0.1875, -0.1875, 0.4375}, -- NodeBox36
			{-0.125, -0.1875, -0.375, 0.125, -0.125, 0.4375}, -- NodeBox37
			{0.0625, -0.125, -0.375, -0.0625, -0.0625, 0.4375}, -- NodeBox38
		}
	},
	selection_box = homedecor.nodebox.null,
	groups = {snappy=3, not_in_creative_inventory=1},
})

homedecor.register("pool_table", {
	tiles = {
		"homedecor_pool_table_top1.png",
		"homedecor_pool_table_bottom1.png",
		"homedecor_pool_table_sides1.png",
		"homedecor_pool_table_sides1.png^[transformFX",
		"homedecor_pool_table_end1.png",
		"homedecor_pool_table_end1.png"
	},
	description = "Pool Table",
	inventory_image = "homedecor_pool_table_inv.png",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375,   -0.5,     -0.375,   -0.25,    0.1875,   -0.25},    --  NodeBox1
			{0.25,     -0.5,     -0.375,   0.375,    0.1875,   -0.25},    --  NodeBox2
			{-0.25,    -0.125,   -0.3125,  0.25,     -0.0625,  0},        --  NodeBox3
			{-0.3125,  -0.0625,  -0.3125,  -0.25,    0.1875,   0},        --  NodeBox4
			{0.25,     -0.0625,  -0.3125,  0.3125,   0.1875,   0},        --  NodeBox5
			{-0.3125,  -0.125,   0,        0.3125,   0.1875,   0.0625},   --  NodeBox6
			{0.25,     -0.125,   -0.25,    0.3125,   0.1875,   0.5},      --  NodeBox7
			{-0.3125,  -0.125,   -0.25,    -0.25,    0.1875,   0.5},      --  NodeBox8
			{-0.5,     0.1875,   -0.5,     -0.4375,  0.25,     0.5},      --  NodeBox9
			{-0.5,     0.1875,   -0.5,     0.5,      0.25,     -0.4375},  --  NodeBox10
			{0.4375,   0.1875,   -0.5,     0.5,      0.25,     0.5},      --  NodeBox11
			{-0.3125,  0.1875,   -0.3125,  0.3125,   0.25,     0.5},      --  NodeBox12
			{-0.4375,  0.1875,   -0.3125,  0.4375,   0.25,     0.4375},   --  NodeBox13
			{-0.3125,  0.1875,   -0.5,     0.3125,   0.25,     -0.3125},  --  NodeBox14
			{-0.25,    -0.125,   -0.325,   0.25,     0,        -0.3125},  --  NodeBox15
			{0.25,     0.125,    -0.4375,  0.4375,   0.1875,   0.5},      --  NodeBox16
			{-0.4375,  0.125,    -0.4375,  -0.25,    0.1875,   0.5},      --  NodeBox17
			{-0.5,     0.25,     -0.5,     -0.4375,  0.3125,   0.5},      --  NodeBox18
			{-0.5,     0.25,     -0.5,     0.5,      0.3125,   -0.4375},  --  NodeBox19
			{0.4375,   0.25,     -0.5,     0.5,      0.3125,   0.5},      --  NodeBox20
			{-0.4375,  0.25,     -0.3125,  -0.375,   0.3125,   0.4375},   --  NodeBox23
			{-0.3125,  0.25,     -0.4375,  0.3125,   0.3125,   -0.375},   --  NodeBox24
			{0.375,    0.25,     -0.3125,  0.4375,   0.3125,   0.4375},   --  NodeBox25
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.3125, 1.5 }
	},
	expand = { forward="homedecor:pool_table_2" },
})

homedecor.register("pool_table_2", {
	tiles = {
		"homedecor_pool_table_top1.png^[transformR180",
		"homedecor_pool_table_bottom1.png",
		"homedecor_pool_table_sides1.png^[transformFX",
		"homedecor_pool_table_sides1.png",
		"homedecor_pool_table_end1.png",
		"homedecor_pool_table_end1.png"
	},
	groups = {snappy=3, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375,   -0.5,     0.25,     -0.25,    0.1875,   0.375},   --  NodeBox1
			{0.25,     -0.5,     0.25,     0.375,    0.1875,   0.375},   --  NodeBox2
			{-0.25,    -0.125,   0,        0.25,     -0.0625,  0.3125},  --  NodeBox3
			{-0.3125,  -0.0625,  0,        -0.25,    0.1875,   0.3125},  --  NodeBox4
			{0.25,     -0.0625,  0,        0.3125,   0.1875,   0.3125},  --  NodeBox5
			{-0.3125,  -0.125,   -0.0625,  0.3125,   0.1875,   0},       --  NodeBox6
			{0.25,     -0.125,   -0.5,     0.3125,   0.1875,   0.25},    --  NodeBox7
			{-0.3125,  -0.125,   -0.5,     -0.25,    0.1875,   0.25},    --  NodeBox8
			{-0.5,     0.1875,   -0.5,     -0.4375,  0.25,     0.5},     --  NodeBox9
			{-0.5,     0.1875,   0.4375,   0.5,      0.25,     0.5},     --  NodeBox10
			{0.4375,   0.1875,   -0.5,     0.5,      0.25,     0.5},     --  NodeBox11
			{-0.3125,  0.1875,   -0.5,     0.3125,   0.25,     0.3125},  --  NodeBox12
			{-0.4375,  0.1875,   -0.4375,  0.4375,   0.25,     0.3125},  --  NodeBox13
			{-0.3125,  0.1875,   0.3125,   0.3125,   0.25,     0.5},     --  NodeBox14
			{-0.25,    -0.125,   0.3125,   0.25,     0,        0.325},   --  NodeBox15
			{0.25,     0.125,    -0.5,     0.4375,   0.1875,   0.4375},  --  NodeBox16
			{-0.4375,  0.125,    -0.5,     -0.25,    0.1875,   0.4375},  --  NodeBox17
			{-0.5,     0.25,     -0.5,     -0.4375,  0.3125,   0.5},     --  NodeBox18
			{-0.5,     0.25,     0.4375,   0.5,      0.3125,   0.5},     --  NodeBox19
			{0.4375,   0.25,     -0.5,     0.5,      0.3125,   0.5},     --  NodeBox20
			{-0.4375,  0.25,     -0.4375,  -0.375,   0.3125,   0.3125},  --  NodeBox23
			{-0.3125,  0.25,     0.375,    0.3125,   0.3125,   0.4375},  --  NodeBox24
			{0.375,    0.25,     -0.4375,  0.4375,   0.3125,   0.3125},  --  NodeBox25
		}
	},
	selection_box = homedecor.nodebox.null,
})

local trash_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.125, 0.25 }
}

homedecor.register("trash_can", {
	drawtype = "mesh",
	mesh = "homedecor_trash_can.obj",
	tiles = { "homedecor_trash_can.png" },
	inventory_image = "homedecor_trash_can_inv.png",
	description = "Trash Can",
        groups = {snappy=3},
	selection_box = trash_cbox,
	collision_box = trash_cbox,
})

homedecor.register("well_base", {
	tiles = {
		"homedecor_well_base_top.png",
		"default_cobble.png"
	},
	inventory_image = "homedecor_well_inv.png",
	description = "Water well",
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.4375, 0.3125, 0.5, -0.3125}, -- NodeBox1
			{0.3125, -0.5, -0.3125, 0.4375, 0.5, 0.3125}, -- NodeBox2
			{-0.4375, -0.5, -0.3125, -0.3125, 0.5, 0.3125}, -- NodeBox3
			{-0.3125, -0.5, 0.3125, 0.3125, 0.5, 0.4375}, -- NodeBox4
			{0.25, -0.5, -0.375, 0.375, 0.5, -0.25}, -- NodeBox5
			{0.25, -0.5, 0.25, 0.375, 0.5, 0.375}, -- NodeBox6
			{-0.375, -0.5, -0.375, -0.25, 0.5, -0.25}, -- NodeBox7
			{-0.375, -0.5, 0.25, -0.25, 0.5, 0.375}, -- NodeBox8
			{-0.3125, -0.5, -0.5, 0.3125, -0.3125, -0.4375}, -- NodeBox9
			{0.4375, -0.5, -0.3125, 0.5, -0.3125, 0.3125}, -- NodeBox10
			{-0.3125, -0.5, 0.4375, 0.3125, -0.3125, 0.5}, -- NodeBox11
			{-0.5, -0.5, -0.3125, -0.4375, -0.3125, 0.3125}, -- NodeBox12
			{0.3125, -0.5, -0.4375, 0.4375, -0.3125, -0.3125}, -- NodeBox13
			{0.3125, -0.5, 0.3125, 0.4375, -0.3125, 0.4375}, -- NodeBox14
			{-0.4375, -0.5, 0.3125, -0.3125, -0.3125, 0.4375}, -- NodeBox15
			{-0.4375, -0.5, -0.4375, -0.3125, -0.3125, -0.3125}, -- NodeBox16
			{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125}, -- NodeBox17
		}
	},
	selection_box = homedecor.nodebox.slab_y(2),
	expand = { top="homedecor:well_top" },
})

homedecor.register("well_top", {
	tiles = {
		"homedecor_well_roof_top.png",
		"homedecor_well_roof_wood.png",
		"homedecor_well_roof_side3.png",
		"homedecor_well_roof_side3.png",
		"homedecor_well_roof_side2.png",
		"homedecor_well_roof_side1.png"
	},
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, 0.375, 0.0625, 0.4375, 0.4375}, -- NodeBox1
			{-0.0625, -0.5, -0.4375, 0.0625, 0.4375, -0.375}, -- NodeBox2
			{-0.125, 0.375, -0.5, 0.125, 0.4375, 0.5}, -- NodeBox3
			{0.125, 0.3125, -0.5, 0.1875, 0.375, 0.5}, -- NodeBox4
			{-0.1875, 0.3125, -0.5, -0.125, 0.375, 0.5}, -- NodeBox5
			{0.1875, 0.25, -0.5, 0.25, 0.3125, 0.5}, -- NodeBox6
			{-0.25, 0.25, -0.5, -0.1875, 0.3125, 0.5}, -- NodeBox7
			{0.25, 0.1875, -0.5, 0.3125, 0.25, 0.5}, -- NodeBox8
			{-0.3125, 0.1875, -0.5, -0.25, 0.25, 0.5}, -- NodeBox9
			{0.3125, 0.125, -0.5, 0.375, 0.1875, 0.5}, -- NodeBox10
			{-0.375, 0.125, -0.5, -0.3125, 0.1875, 0.5}, -- NodeBox11
			{0.375, 0.0625, -0.5, 0.4375, 0.125, 0.5}, -- NodeBox12
			{-0.375, 0.0625, -0.5, -0.4375, 0.125, 0.5}, -- NodeBox13
			{0.4375, 0, -0.5, 0.5, 0.0625, 0.5}, -- NodeBox14
			{-0.5, 0, -0.5, -0.4375, 0.0625, 0.5}, -- NodeBox15
			{-0.0625, 0.4375, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox16
			{-0.125, 0.125, -0.4375, 0.125, 0.1875, -0.375}, -- NodeBox17
			{0.125, 0.1875, -0.4375, 0.1875, 0.25, -0.375}, -- NodeBox18
			{-0.1875, 0.1875, -0.4375, -0.125, 0.25, -0.375}, -- NodeBox19
			{-0.125, 0.125, 0.375, 0.125, 0.1875, 0.4375}, -- NodeBox20
			{0.125, 0.1875, 0.375, 0.1875, 0.25, 0.4375}, -- NodeBox21
			{-0.1875, 0.1875, 0.375, -0.125, 0.25, 0.4375}, -- NodeBox22
			{-0.0165975, -0.159751, -0.375, 0.0165974, -0.125, 0.375}, -- NodeBox23
			{-0.00414942, -0.465, -0.008299, 0.008299, -0.159751, 0.004149}, -- NodeBox24
			{-0.0625, -0.0625, -0.5, 0.0625, 0, -0.4646}, -- NodeBox25
			{0.0625, -0.125, -0.5, 0.125, -0.0625, -0.4646}, -- NodeBox26
			{0.125, -0.25, -0.5, 0.1875, -0.125, -0.4646}, -- NodeBox27
			{0.0625, -0.3125, -0.5, 0.125, -0.25, -0.4646}, -- NodeBox28
			{-0.0625, -0.375, -0.5, 0.0625, -0.3125, -0.4646}, -- NodeBox29
			{-0.0625, -0.3125, -0.5, -0.125, -0.25, -0.4646}, -- NodeBox30
			{-0.1875, -0.25, -0.5, -0.125, -0.125, -0.4646}, -- NodeBox31
			{-0.125, -0.125, -0.5, -0.0625, -0.0625, -0.4646}, -- NodeBox32
			{-0.016598, -0.3125, -0.48, 0.020747, -0.0625, -0.49}, -- NodeBox33
			{-0.125, -0.209544, -0.48, 0.125, -0.172199, -0.49}, -- NodeBox34
                        {-0.0165975, -0.200, -0.477178, 0.020747, -0.175349, -0.435685}, -- NodeBox35
                        {0.1, -0.75, -0.125, 0.125, -0.5, 0.125}, -- NodeBox36
			{-0.125, -0.75, -0.125, -0.1, -0.5, 0.125}, -- NodeBox37
			{-0.125, -0.75, -0.125, 0.125, -0.729253, 0.125}, -- NodeBox38
			{-0.125, -0.75, -0.125, 0.125, -0.5, -0.1}, -- NodeBox39
			{-0.125, -0.75, 0.1, 0.125, -0.5, 0.125}, -- NodeBox40
			{-0.0165975,-0.465, -0.125, 0.0165974, -0.451245, 0.125}, -- NodeBox41
			{-0.0165975, -0.51, 0.112033, 0.0165974, -0.46, 0.125}, -- NodeBox42
			{-0.0165975, -0.51, -0.125, 0.0165974, -0.46, -0.112033}, -- NodeBox43
		}
	},
	selection_box = homedecor.nodebox.null,
})

homedecor.register("coatrack_wallmount", {
	tiles = { "forniture_wood.png" },
	inventory_image = "homedecor_coatrack_wallmount_inv.png",
	description = "Coatrack (wallmounted)",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0, 0.4375, 0.375, 0.14, 0.5}, -- NodeBox1
			{-0.3025, 0.0475, 0.375, -0.26, 0.09, 0.4375}, -- NodeBox2
			{0.26, 0.0475, 0.375, 0.3025, 0.09, 0.4375}, -- NodeBox3
			{0.0725, 0.0475, 0.375, 0.115, 0.09, 0.4375}, -- NodeBox4
			{-0.115, 0.0475, 0.375, -0.0725, 0.09, 0.4375}, -- NodeBox5
			{0.24, 0.025, 0.352697, 0.3225, 0.115, 0.375}, -- NodeBox6
			{-0.3225, 0.025, 0.352697, -0.24, 0.115, 0.375}, -- NodeBox7
			{-0.135, 0.025, 0.352697, -0.0525, 0.115, 0.375}, -- NodeBox8
			{0.0525, 0.025, 0.352697, 0.135, 0.115, 0.375}, -- NodeBox9
		}
	},
})

homedecor.register("coat_tree", {
	tiles = { "forniture_wood.png" },
	inventory_image = "homedecor_coatrack_inv.png",
	description = "Coat tree",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0, -0.5, 0, 0.0625, 1.5, 0.0625}, -- NodeBox1
			{-0.125, -0.5, -0.125, 0.1875, -0.4375, 0.1875}, -- NodeBox2
			{0.1875, -0.5, -0.0625, 0.22, -0.4375, 0.125}, -- NodeBox3
			{-0.0625, -0.5, 0.188, 0.125, -0.4375, 0.22}, -- NodeBox4
			{-0.16, -0.5, -0.0625, -0.125, -0.4375, 0.125}, -- NodeBox5
			{-0.0625, -0.5, -0.16, 0.125, -0.4375, -0.125}, -- NodeBox6
			{-0.25, 1.1875, 0, 0.3125, 1.25, 0.0625}, -- NodeBox7
			{0, 1.1875, -0.25, 0.0625, 1.25, 0.3125}, -- NodeBox8
			{-0.0207468, 1.4375, -0.0207468, 0.0829876, 1.5, 0.0829876}, -- NodeBox9
		}
	},
})

local cutlery_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16, -8/16, -6/16, 5/16, -7/16, 2/16 },
		{ -2/16, -8/16,  2/16, 2/16, -4/16, 6/16 }
	}
}

homedecor.register("cutlery_set", {
	drawtype = "mesh",
	mesh = "homedecor_cutlery_set.obj",
	tiles = { "homedecor_cutlery_set.png"	},
	inventory_image = "homedecor_cutlery_set_inv.png",
	description = "Cutlery set",
	groups = {snappy=3},
	selection_box = cutlery_cbox,
	collision_box = cutlery_cbox
})

local bottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0, 0.125}
	}
}

homedecor.register("bottle_brown", {
	tiles = { "homedecor_bottle_brown.png" },
	inventory_image = "homedecor_bottle_brown_inv.png",
	description = "Brown bottle",
	mesh = "homedecor_bottle.obj",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = bottle_cbox,
	selection_box = bottle_cbox
})

homedecor.register("bottle_green", {
	tiles = { "homedecor_bottle_green.png" },
	inventory_image = "homedecor_bottle_green_inv.png",
	description = "Green bottle",
	mesh = "homedecor_bottle.obj",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = bottle_cbox,
	selection_box = bottle_cbox
})

-- 4-bottle sets

local fbottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.375, -0.5, -0.3125, 0.375, 0, 0.3125 }
	}
}

homedecor.register("4_bottles_brown", {
	tiles = { "homedecor_bottle_brown.png" },
	inventory_image = "homedecor_4_bottles_brown_inv.png",
	description = "Four brown bottles",
	mesh = "homedecor_4_bottles.obj",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

homedecor.register("4_bottles_green", {
	tiles = { "homedecor_bottle_green.png" },
	inventory_image = "homedecor_4_bottles_green_inv.png",
	description = "Four green bottles",
	mesh = "homedecor_4_bottles.obj",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

homedecor.register("4_bottles_multi", {
	tiles = { "homedecor_4_bottles_multi.png" },
	inventory_image = "homedecor_4_bottles_multi_inv.png",
	description = "Four misc brown/green bottles",
	mesh = "homedecor_4_bottles_multi.obj",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

homedecor.register("dartboard", {
	description = "Dartboard",
	mesh = "homedecor_dartboard.obj",
	tiles = { "homedecor_dartboard.png" },
	inventory_image = "homedecor_dartboard_inv.png",
	wield_image = "homedecor_dartboard_inv.png",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

homedecor.register("piano_left", {
	tiles = {
		"homedecor_piano_top_left.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_front_left.png",
	},
	inventory_image = "homedecor_piano_inv.png",
	description = "Piano",
        groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.0625, -0.125, -0.4375, 0.25, 0.1875}, -- NodeBox2
			{-0.5, -0.5, -0.125, -0.4375, -0.375, 0.1875}, -- NodeBox3
			{-0.5, -0.375, -0.0625, -0.4375, 0.0625, 0}, -- NodeBox4
			{-0.5, 0.0625, -0.0625, 0.5, 0.1875, 0.1875}, -- NodeBox5
			{-0.4375, 0.1875, 0.15, 0.5, 0.4375, 0.1875}, -- NodeBox6
			{0.3594, -0.5, 0, 0.4062, -0.46875, 0.25}, -- left-most pedal
			{0.4844, -0.5, 0, 0.5, -0.46875, 0.25}, -- half of center pedal
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.125, 1.5, 0.5, 0.5 }
	},
	expand = { right="homedecor:piano_right" },
})

homedecor.register("piano_right", {
	tiles = {
		"homedecor_piano_top_right.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_front_right.png",
	},
        groups = { snappy = 3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.4375, -0.5, -0.125, 0.5, -0.375, 0.1875}, -- NodeBox2
			{0.4375, 0.0625, -0.125, 0.5, 0.25, 0.1875}, -- NodeBox3
			{0.4375, -0.375, -0.0625, 0.5, 0.0625, 0}, -- NodeBox4
			{-0.5, 0.0625, -0.0625, 0.4375, 0.1875, 0.1875}, -- NodeBox5
			{-0.5, 0.1875, 0.15, 0.4375, 0.4375, 0.1875}, -- NodeBox6
			{-0.5, -0.5, 0, -0.4688, -0.46875, 0.25}, -- half of center pedal
			{-0.3905, -0.5, 0, -0.3438, -0.46875, 0.25}, -- right-most pedal

		}
	},
	selection_box = homedecor.nodebox.null
})

-- convert old pool tables into newer model

minetest.register_abm({
	nodenames = { "homedecor:pool_table2" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local swap_fdir = { 2, 3, 0, 1 }
		local fdir = swap_fdir[node.param2+1]
		minetest.set_node(pos, {name = "homedecor:pool_table_2", param2 = fdir})
	end
})

homedecor.register("trophy", {
        description = "Trophy",
	tiles = {
		"default_gold_block.png"
	},
	inventory_image = "homedecor_trophy_inv.png",
        groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.1875, -0.4375, 0.1875}, -- NodeBox1
			{-0.0625, -0.4375, -0.0625, 0.125, -0.375, 0.125}, -- NodeBox2
			{-0.02, -0.375, -0.02, 0.0825, -0.1875, 0.0825}, -- NodeBox3
			{-0.0625, -0.1875, -0.0625, 0.125, -0.125, 0.125}, -- NodeBox4
			{-0.125, -0.1875, -0.0625, -0.0625, 0.125, 0.125}, -- NodeBox5
			{0.125, -0.1875, -0.0625, 0.1875, 0.125, 0.125}, -- NodeBox6
			{-0.125, -0.1875, 0.125, 0.1875, 0.125, 0.1875}, -- NodeBox7
			{-0.125, -0.1875, -0.125, 0.1875, 0.125, -0.0625}, -- NodeBox8
			{-0.0625, -0.25, -0.0625, 0.125, -0.1875, 0.125}, -- NodeBox9
			{0.1875, 0.05, 0, 0.23, 0.0925, 0.0625}, -- NodeBox10
			{0.1875, -0.15, 0, 0.23, -0.11, 0.0625}, -- NodeBox11
			{0.23, -0.15, 0, 0.2725, 0.0925, 0.0625}, -- NodeBox12
			{-0.1675, -0.15, 0, -0.125, -0.11, 0.0625}, -- NodeBox13
			{-0.1675, 0.05, 0, -0.125, 0.0925, 0.0625}, -- NodeBox14
			{-0.21, -0.15, 0, -0.1675, 0.0925, 0.0625}, -- NodeBox15
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.21, -0.5, -0.125, 0.2725, 0.125, 0.1875 }
	}
})

homedecor.register("sportbench", {
	description = "Sport bench",
	tiles = {
		"homedecor_sportbench_top.png",
		"wool_black.png",
		"homedecor_sportbench_left.png^[transformFX",
		"homedecor_sportbench_left.png",
		"homedecor_sportbench_bottom.png",
		"homedecor_sportbench_front.png"
	},
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.3125, -0.5, 0.1875, -0.25, 0.5}, -- NodeBox1
			{-0.1875, -0.5, -0.5, -0.125, -0.3125, -0.4375}, -- NodeBox2
			{0.125, -0.5, -0.5, 0.1875, -0.3125, -0.4375}, -- NodeBox3
			{0.1875, -0.5, 0.375, 0.25, 0.375, 0.4375}, -- NodeBox4
			{-0.25, -0.5, 0.375, -0.1875, 0.375, 0.4375}, -- NodeBox5
			{-0.5, 0.125, 0.36, 0.5, 0.14, 0.375}, -- NodeBox6
			{0.3125, 0, 0.225, 0.35, 0.285, 0.5}, -- NodeBox7
			{-0.35, 0, 0.225, -0.3125, 0.285, 0.5}, -- NodeBox8
			{-0.1875, -0.375, 0.375, 0.1875, -0.3125, 0.4375}, -- NodeBox9
			{-0.23, 0.11, 0.33, -0.2075, 0.125, 0.375}, -- NodeBox10
			{0.2075, 0.11, 0.33, 0.23, 0.125, 0.375}, -- NodeBox11
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.5, 0.4, 0.375, 0.5 }
	}
})

homedecor.register("skateboard", {
        description = "Skateboard",
	tiles = {
		"homedecor_skateboard_top.png",
		"homedecor_skateboard_bottom.png",
		"homedecor_skateboard_sides.png"
	},
	inventory_image = "homedecor_skateboard_inv.png",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.4375, -0.1875, 0.4375, -0.415, 0.125}, -- NodeBox1
			{-0.375, -0.5, 0.0625, -0.3125, -0.4375, 0.125}, -- NodeBox2
			{-0.375, -0.5, -0.1875, -0.3125, -0.4375, -0.125}, -- NodeBox3
			{0.3125, -0.5, 0.0625, 0.375, -0.4375, 0.125}, -- NodeBox4
			{0.3125, -0.5, -0.1875, 0.375, -0.4375, -0.125}, -- NodeBox5
			{-0.5, -0.4375, -0.16, -0.4375, -0.415, 0.0975}, -- NodeBox6
			{0.4375, -0.4375, -0.16, 0.5, -0.415, 0.0975}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.2, 0.5, -0.40, 0.125 }
	},
	on_place = minetest.rotate_node
})

homedecor.register("stonepath", {
	description = "Garden stone path",
	tiles = {
		"default_stone.png"
	},
	inventory_image = "homedecor_stonepath_inv.png",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.3125, -0.3125, -0.48, 0.4375}, -- NodeBox1
			{-0.25, -0.5, 0.125, 0, -0.48, 0.375}, -- NodeBox2
			{0.125, -0.5, 0.125, 0.4375, -0.48, 0.4375}, -- NodeBox3
			{-0.4375, -0.5, -0.125, -0.25, -0.48, 0.0625}, -- NodeBox4
			{-0.0625, -0.5, -0.25, 0.25, -0.48, 0.0625}, -- NodeBox5
			{0.3125, -0.5, -0.25, 0.4375, -0.48, -0.125}, -- NodeBox6
			{-0.3125, -0.5, -0.375, -0.125, -0.48, -0.1875}, -- NodeBox7
			{0.125, -0.5, -0.4375, 0.25, -0.48, -0.3125}, -- NodeBox8
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.4375, -0.5, -0.4375, 0.4375, -0.4, 0.4375 }
	}
})

homedecor.register("barbecue", {
	description = "Barbecue",
	tiles = {
		{name="homedecor_barbecue_top.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		"forniture_black_metal.png",
	},
	groups = { snappy=3 },
	light_source = 9,
	node_box = {
		type = "fixed",
		fixed = {
                        {-0.5, -0.5, 0.25, -0.4375, 0.0625, 0.3125}, -- NodeBox1
			{0.4375, -0.5, 0.25, 0.5, 0.0625, 0.3125}, -- NodeBox2
			{-0.5, -0.5, -0.3125, -0.4375, 0.0625, -0.25}, -- NodeBox3
			{0.4375, -0.5, -0.3125, 0.5, 0.0625, -0.25}, -- NodeBox4
			{-0.5, 0.0625, -0.3125, 0.5, 0.375, 0.3125}, -- NodeBox5
			{-0.375, 0.5, -0.25, -0.313, 0.5, 0.251}, -- NodeBox6
			{-0.25, 0.5, -0.25, -0.188, 0.5, 0.251}, -- NodeBox7
			{-0.125, 0.5, -0.25, -0.063, 0.5, 0.251}, -- NodeBox8
			{0, 0.5, -0.25, 0.062, 0.5, 0.251}, -- NodeBox9
			{0.125, 0.5, -0.25, 0.187, 0.5, 0.251}, -- NodeBox10
			{0.25, 0.5, -0.25, 0.312, 0.5, 0.251}, -- NodeBox11
			{0.375, 0.5, -0.25, 0.437, 0.5, 0.251}, -- NodeBox12
			{-0.5, 0.375, 0.251, 0.5, 0.5, 0.3125}, -- NodeBox13
			{-0.5, 0.0625, -0.3125, 0.5, 0.5, -0.25}, -- NodeBox14
			{-0.5, 0.0625, -0.3125, -0.438, 0.5, 0.3125}, -- NodeBox15
			{0.4375, 0.0625, -0.3125, 0.5, 0.5, 0.3125}, -- NodeBox16
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.3125, 0.5, 0.625, 0.3125 }
        },
	expand = { top="homedecor:barbecue_meat" },
})

homedecor.register("barbecue_meat", {
	tiles = {
		"homedecor_barbecue_meat.png",
	},
	groups = { snappy=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.125, -0.0625, -0.4375, 0.125}, -- NodeBox1
			{0.125, -0.5, -0.125, 0.3125, -0.4375, 0.125}, -- NodeBox2
		}
	},
	selection_box = homedecor.nodebox.null
})

homedecor.register("beer_tap", {
	description = "Beer tap",
	tiles = {
		"homedecor_beertap_front.png",
		"homedecor_beertap_front.png",
		"homedecor_beertap_right.png",
		"homedecor_beertap_right.png^[transformFX",
		"homedecor_beertap_front.png",
		"homedecor_beertap_front.png"
	},
	inventory_image = "homedecor_beertap_inv.png",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.4375, 0.25, -0.48, 0}, -- NodeBox1
			{-0.0625, -0.48, -0.1875, 0.0625, 0.125, -0.0625}, -- NodeBox2
			{-0.1875, 0, -0.375, -0.125, 0.0315, -0.125}, -- NodeBox3
			{-0.1875, 0, -0.1875, 0.1875, 0.0315, -0.125}, -- NodeBox4
			{0.125, 0, -0.375, 0.1875, 0.0315, -0.125}, -- NodeBox5
			{0.135, 0.0315, -0.3225, 0.1775, 0.235, -0.29}, -- NodeBox6
			{-0.1775, 0.0315, -0.3225, -0.135, 0.235, -0.29}, -- NodeBox7
			{-0.1675, -0.0825, -0.355, -0.145, 0, -0.3325}, -- NodeBox8
			{0.145, -0.0825, -0.355, 0.1675, 0, -0.3325}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.4375, 0.25, 0.235, 0 }
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		local wielditem = puncher:get_wielded_item()
		local inv = puncher:get_inventory()

		local wieldname = wielditem:get_name()
		if wieldname == "vessels:drinking_glass" then
			if inv:room_for_item("main", "homedecor:beer_mug 1") then
				wielditem:take_item()
				puncher:set_wielded_item(wielditem)
				inv:add_item("main", "homedecor:beer_mug 1")
				minetest.chat_send_player(puncher:get_player_name(), "Ahh, a frosty cold beer - look in your inventory for it!")
			else
				minetest.chat_send_player(puncher:get_player_name(), "No room in your inventory to add a beer mug!")
			end
		end
	end
})

local beer_cbox = {
	type = "fixed",
	fixed = { -5/32, -8/16, -9/32 , 7/32, -2/16, 1/32 }
}

homedecor.register("beer_mug", {
	description = "Beer mug",
	drawtype = "mesh",
	mesh = "homedecor_beer_mug.obj",
	tiles = { "homedecor_beer_mug.png" },
	inventory_image = "homedecor_beer_mug_inv.png",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	sounds = default.node_sound_glass_defaults(),
	selection_box = beer_cbox,
	collision_box = beer_cbox
})

homedecor.register("tool_cabinet_bottom", {
	description = "Metal tool cabinet and work table",
	tiles = {
		"homedecor_tool_cabinet_bottom_top.png",
		"homedecor_tool_cabinet_bottom_sides.png",
		"homedecor_tool_cabinet_bottom_sides.png",
		"homedecor_tool_cabinet_bottom_sides.png",
		"homedecor_tool_cabinet_bottom_sides.png",
		"homedecor_tool_cabinet_bottom_front.png"
	},
	inventory_image = "homedecor_tool_cabinet_inv.png",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, -0.4375, -0.375, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.5, -0.4375, -0.375, -0.4375}, -- NodeBox2
			{0.4375, -0.5, 0.4375, 0.5, -0.375, 0.5}, -- NodeBox3
			{0.4375, -0.5, -0.5, 0.5, -0.375, -0.4375}, -- NodeBox4
			{-0.5, -0.375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
		}
	},
	selection_box = homedecor.nodebox.slab_y(2),
	expand = { top="homedecor:tool_cabinet_top" },
})

homedecor.register("tool_cabinet_top", {
	tiles = {
		"homedecor_tool_cabinet_top_top.png",
		"homedecor_tool_cabinet_top_bottom.png",
		"homedecor_tool_cabinet_top_right.png",
		"homedecor_tool_cabinet_top_left.png",
		"homedecor_tool_cabinet_top_back.png",
		"homedecor_tool_cabinet_top_front.png"
	},
	groups = { snappy=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.4375, -0.1875, -0.4375, 0.125}, -- NodeBox2
			{-0.375, -0.4375, 0, -0.3125, 0.1875, 0.0625}, -- NodeBox3
			{-0.4375, -0.1875, -0.375, -0.25, 0.125, 0.125}, -- NodeBox4
			{-0.25, -0.0625, -0.3125, -0.22, 0.3125, -0.2825}, -- NodeBox5
			{-0.375, -0.1875, -0.25, -0.3125, -0.218, -0.3125}, -- NodeBox6
			{-0.35, -0.32, -0.285, -0.3375, -0.218, -0.2725}, -- NodeBox7
			{0, -0.3125, 0.375, 0.0625, 0.1875, 0.4375}, -- NodeBox8
			{0.125, 0.1875, 0.375, 0.1875, 0.25, 0.4375}, -- NodeBox9
			{-0.0625, 0.1875, 0.375, 0.125, 0.3125, 0.4375}, -- NodeBox10
			{0.343, -0.125, 0.42, 0.375, 0.125, 0.4375}, -- NodeBox11
			{0.3125, 0.095, 0.42, 0.343, 0.1575, 0.4375}, -- NodeBox12
			{0.375, 0.095, 0.42, 0.405, 0.1575, 0.4375}, -- NodeBox13
			{0.3125, -0.155, 0.42, 0.343, -0.093, 0.4375}, -- NodeBox14
			{0.375, -0.155, 0.42, 0.405, -0.093, 0.4375}, -- NodeBox15
		}
	},
	selection_box = homedecor.nodebox.null
})

homedecor.register("swing", {
	description = "Tree's swing",
	tiles = {
		"homedecor_swing_top.png",
		"homedecor_swing_top.png^[transformR180",
		"homedecor_swing_top.png"
	},
	inventory_image = "homedecor_swing_inv.png",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, 0.33, -0.125,  0.3125, 0.376, 0.1875}, -- NodeBox1
			{-0.3125, 0.376, 0.025, -0.3,    0.5,   0.0375}, -- NodeBox2
			{ 0.3,    0.376, 0.025,  0.3125, 0.5,   0.0375}, -- NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.3125, 0.33, -0.125, 0.3125, 0.5, 0.1875 }
	},
	on_place = function(itemstack, placer, pointed_thing)
		isceiling, pos = homedecor.find_ceiling(itemstack, placer, pointed_thing)
		if isceiling then
			local height = 0

			for i = 0, 4 do	-- search up to 5 spaces downward from the ceiling for the first non-buildable-to node...
				height = i
				local testpos = { x=pos.x, y=pos.y-i-1, z=pos.z }
				local testnode = minetest.get_node(testpos)
				local testreg = core.registered_nodes[testnode.name]

				if not testreg.buildable_to then
					if i < 1 then
						minetest.chat_send_player(placer:get_player_name(), "No room under there to hang a swing.")
						return
					else
						break
					end
				end
			end

			for j = 0, height do -- then fill that space with ropes...
				local testpos = { x=pos.x, y=pos.y-j, z=pos.z }
				local testnode = minetest.get_node(testpos)
				local testreg = core.registered_nodes[testnode.name]
				minetest.set_node(testpos, { name = "homedecor:swing_rope", param2 = fdir })
			end

			minetest.set_node({ x=pos.x, y=pos.y-height, z=pos.z }, { name = "homedecor:swing", param2 = fdir })

			if not homedecor.expect_infinite_stacks then
				itemstack:take_item()
				return itemstack
			end

		else
			minetest.chat_send_player(placer:get_player_name(), "You have to point at the bottom side of an overhanging object to place a swing.")
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		for i = 0, 4 do
			local testpos = { x=pos.x, y=pos.y+i+1, z=pos.z }
			if minetest.get_node(testpos).name == "homedecor:swing_rope" then
				minetest.remove_node(testpos)
			else
				return
			end
		end
	end
})

homedecor.register("swing_rope", {
	tiles = {
		"homedecor_swingrope_sides.png"
	},
	groups = { not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.025, -0.3, 0.5, 0.0375}, -- NodeBox1
			{0.3, -0.5, 0.025, 0.3125, 0.5, 0.0375}, -- NodeBox2
		}
	},
	selection_box = homedecor.nodebox.null
})

local bookcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"grey",
	"brown"
}

local BOOK_FORMNAME = "homedecor:book_form"

for c in ipairs(bookcolors) do
	local color = bookcolors[c]
	local color_d = S(bookcolors[c])

	local function book_dig(pos, node, digger)
		if minetest.is_protected(pos, digger:get_player_name()) then return end
		local meta = minetest.get_meta(pos)
		local stack = ItemStack({
			name = "homedecor:book_"..color,
			metadata = meta:get_string("text"),
		})
		stack = digger:get_inventory():add_item("main", stack)
		if not stack:is_empty() then
			minetest.item_drop(stack, digger, pos)
		end
		minetest.remove_node(pos)
	end

homedecor.register("book_"..color, {
	description = S("Book (%s)"):format(color_d),
	tiles = {
		"homedecor_book_"..color.."_top.png",
		"homedecor_book_"..color.."_bottom.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_"..color.."_bottom.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png"
	},
	inventory_image = "homedecor_book_"..color.."_inv.png",
	wield_image = "homedecor_book_"..color.."_inv.png",
	groups = { snappy=3, oddly_breakable_by_hand=3, book=1 },
	stack_max = 1,
	node_box = {
		type = "fixed",
		fixed = {
			{0, -0.5, -0.375, 0.3125, -0.4375, 0.0625},
		}
	},
	on_rightclick = function(pos, node, clicker)
		local fdir = node.param2
		minetest.swap_node(pos, { name = "homedecor:book_open_"..color, param2 = fdir })
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local plname = placer:get_player_name()
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		local n = minetest.registered_nodes[node.name]
		if not n.buildable_to then
			pos = pointed_thing.above
			node = minetest.get_node(pos)
			n = minetest.registered_nodes[node.name]
			if not n.buildable_to then return end
		end
		if minetest.is_protected(pos, plname) then return end
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		minetest.set_node(pos, {
			name = "homedecor:book_"..color,
			param2 = fdir,
		})
		local text = itemstack:get_metadata() or ""
		local meta = minetest.get_meta(pos)
		meta:set_string("text", text)
		local data = minetest.deserialize(text) or {}
		if data.title and data.title ~= "" then
			meta:set_string("infotext", data.title)
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
	on_dig = book_dig,
	on_use = function(itemstack, user, pointed_thing)
		local player_name = user:get_player_name()
		local data = minetest.deserialize(itemstack:get_metadata())
		local title, text, owner = "", "", player_name
		if data then
			title, text, owner = data.title, data.text, data.owner
		end
		local formspec
		if owner == player_name then
			formspec = "size[8,8]"..default.gui_bg..default.gui_bg_img..
				"field[0.5,1;7.5,0;title;Book title :;"..
					minetest.formspec_escape(title).."]"..
				"textarea[0.5,1.5;7.5,7;text;Book content :;"..
					minetest.formspec_escape(text).."]"..
				"button_exit[2.5,7.5;3,1;save;Save]"
		else
			formspec = "size[8,8]"..default.gui_bg..
			"button_exit[7,0.25;1,0.5;close;x]"..
			default.gui_bg_img..
				"label[1,0.5;"..minetest.formspec_escape(title).."]"..
				"label[0.5,1.5;"..minetest.formspec_escape(text).."]"
		end
		minetest.show_formspec(user:get_player_name(), BOOK_FORMNAME, formspec)
	end,
})

homedecor.register("book_open_"..color, {
	tiles = {
		"homedecor_book_open_top.png",
		"homedecor_book_open_"..color.."_bottom.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png"
	},
	groups = { snappy=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.375, 0.3125, -0.47, 0.0625}, -- NodeBox1
		}
	},
	drop = "homedecor:book_"..color,
	on_dig = book_dig,
	on_rightclick = function(pos, node, clicker)
		local fdir = node.param2
		minetest.swap_node(pos, { name = "homedecor:book_"..color, param2 = fdir })
	end,
})

end

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= BOOK_FORMNAME or not fields.save then
		return
	end
	local stack = player:get_wielded_item()
	if minetest.get_item_group(stack:get_name(), "book") == 0 then
		return
	end
	local data = minetest.deserialize(stack:get_metadata()) or {}
	data.title, data.text, data.owner =
		fields.title, fields.text, player:get_player_name()
	stack:set_metadata(minetest.serialize(data))
	player:set_wielded_item(stack)
end)

homedecor.register("calendar", {
	description = "Calendar",
	drawtype = "signlike",
	tiles = {"homedecor_calendar.png"},
	inventory_image = "homedecor_calendar.png",
	wield_image = "homedecor_calendar.png",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

local globe_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.3, 0.3, 0.3, 0.3 }
}

homedecor.register("desk_globe", {
	description = "Desk globe",
	mesh = "homedecor_desk_globe.obj",
	tiles = {"homedecor_desk_globe.png"},
	inventory_image = "homedecor_desk_globe_inv.png",
	selection_box = globe_cbox,
	collision_box = globe_cbox,
	groups = {choppy=2},
	sounds = default.node_sound_defaults(),
})

local wine_cbox = homedecor.nodebox.slab_z(0.25)
homedecor.register("wine_rack", {
	description = "Wine Rack",
	mesh = "homedecor_wine_rack.obj",
	tiles = {"homedecor_wine_rack.png"},
	inventory_image = "homedecor_wine_rack_inv.png",
	groups = {choppy=2},
	selection_box = wine_cbox,
	collision_box = wine_cbox,
	sounds = default.node_sound_defaults(),
})


local S = homedecor.gettext

homedecor.register("ceiling_paint", {
	description = S("Textured Ceiling Paint"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_paint.png' },
	inventory_image = 'homedecor_ceiling_paint_roller.png',
	wield_image = 'homedecor_ceiling_paint_roller.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

homedecor.register("ceiling_tile", {
	description = S("Drop-Ceiling Tile"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_tile.png' },
	wield_image = 'homedecor_ceiling_tile.png',
	inventory_image = 'homedecor_ceiling_tile.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

local rug_sizes = {"small", "large"}

for _, s in ipairs(rug_sizes) do
homedecor.register("rug_"..s, {
	description = S("Throw Rug ("..s..")"),
	drawtype = 'signlike',
	tiles = {"homedecor_rug_"..s..".png"},
	wield_image = "homedecor_rug_"..s..".png",
	inventory_image = "homedecor_rug_"..s..".png",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
        selection_box = { type = "wallmounted" },
})
end

local pot_colors = {"black", "green", "terracotta"}

for _, p in ipairs(pot_colors) do
homedecor.register("flower_pot_"..p, {
	description = S("Flower Pot ("..p..")"),
	mesh = "homedecor_flowerpot.obj",
	tiles = {
		"homedecor_flower_pot_"..p..".png",
		"homedecor_potting_soil.png"
	},
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_stone_defaults(),
})
end

homedecor.register("pole_brass", {
    description = S("Brass Pole"),
	mesh = "homedecor_round_pole.obj",
    tiles = {"homedecor_generic_metal_brass.png^homedecor_generic_metal_lines_overlay.png",},
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
    tiles = { "homedecor_generic_metal_wrought_iron.png^homedecor_generic_metal_lines_overlay.png" },
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
	mesh = "homedecor_chimney.obj",
	tiles = {
		"homedecor_chimney_tb.png",
		"default_brick.png"
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
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		fdir = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "homedecor:fishtank_lighted", param2 = fdir})
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
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		fdir = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "homedecor:fishtank", param2 = fdir})
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
	infotext=S("Cardboard box"),
	inventory = {
		size=8,
	},
})

homedecor.register("dvd_cd_cabinet", {
	description = "DVD/CD cabinet",
	mesh = "homedecor_dvd_cabinet.obj",
	tiles = {
		"default_wood.png",
		"homedecor_dvdcd_cabinet_front.png",
		"homedecor_dvdcd_cabinet_back.png"
	},
	selection_box = homedecor.nodebox.slab_z(0.5),
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("filing_cabinet", {
	description = S("Filing Cabinet"),
	mesh = "homedecor_filing_cabinet.obj",
	tiles = {
		"homedecor_generic_wood_beech.png",
		"homedecor_filing_cabinet_front.png",
		"homedecor_filing_cabinet_bottom.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Filing cabinet"),
	inventory = {
		size=16,
	},
})

local pooltable_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.3125, 1.5 }
}

homedecor.register("pool_table", {
	mesh = "homedecor_pool_table.obj",
	tiles = {
		"homedecor_pool_table_cue.png",
		"homedecor_pool_table_baize.png",
		"homedecor_pool_table_pockets.png",
		"homedecor_pool_table_balls.png",
		"homedecor_generic_wood_luxury_brown3.png"
	},
	description = "Pool Table",
	inventory_image = "homedecor_pool_table_inv.png",
	groups = {snappy=3},
	selection_box = pooltable_cbox,
	collision_box = pooltable_cbox,
	expand = { forward="air" },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_alias("homedecor:pool_table_2", "air")

homedecor.register("coatrack_wallmount", {
	tiles = { "homedecor_generic_wood_beech.png" },
	inventory_image = "homedecor_coatrack_wallmount_inv.png",
	description = "Coatrack (wallmounted)",
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
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
	mesh = "homedecor_coatrack.obj",
	tiles = {
		"homedecor_generic_wood_beech.png",
		"homedecor_generic_wood_neutral.png"
	},
	inventory_image = "homedecor_coatrack_inv.png",
	description = "Coat tree",
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	expand = { top="air" },
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
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
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
})

local bottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0, 0.125}
	}
}

local fbottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.375, -0.5, -0.3125, 0.375, 0, 0.3125 }
	}
}

local bottle_colors = {"brown", "green"}

for _, b in ipairs(bottle_colors) do

	homedecor.register("bottle_"..b, {
		tiles = { "homedecor_bottle_"..b..".png" },
		inventory_image = "homedecor_bottle_"..b.."_inv.png",
		description = "Bottle ("..b..")",
		mesh = "homedecor_bottle.obj",
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = bottle_cbox
	})

	-- 4-bottle sets

	homedecor.register("4_bottles_"..b, {
		tiles = {
			"homedecor_bottle_"..b..".png",
			"homedecor_bottle_"..b..".png"
		},
		inventory_image = "homedecor_4_bottles_"..b.."_inv.png",
		description = "Four "..b.." bottles",
		mesh = "homedecor_4_bottles.obj",
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = fbottle_cbox
	})
end

homedecor.register("4_bottles_multi", {
	tiles = {
		"homedecor_bottle_brown.png",
		"homedecor_bottle_green.png"
	},
	inventory_image = "homedecor_4_bottles_multi_inv.png",
	description = "Four misc brown/green bottles",
	mesh = "homedecor_4_bottles.obj",
	groups = {snappy=3},
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
	selection_box = fbottle_cbox
})

homedecor.register("dartboard", {
	description = "Dartboard",
	mesh = "homedecor_dartboard.obj",
	tiles = { "homedecor_dartboard.png" },
	inventory_image = "homedecor_dartboard_inv.png",
	wield_image = "homedecor_dartboard_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

local piano_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.125, 1.5, 0.5, 0.5 }
}

homedecor.register("piano", {
	mesh = "homedecor_piano.obj",
	tiles = {
		"homedecor_piano_keys.png",
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_wood_luxury_black.png"
	},
	inventory_image = "homedecor_piano_inv.png",
	description = "Piano",
	groups = { snappy = 3 },
	selection_box = piano_cbox,
	collision_box = piano_cbox,
	expand = { right="air" },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_alias("homedecor:piano_left", "homedecor:piano")
minetest.register_alias("homedecor:piano_right", "air")

local tr_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.5, -0.1875, 0.3125, 0.125, 0.1875 }
}

homedecor.register("trophy", {
	description = "Trophy",
	mesh = "homedecor_trophy.obj",
	tiles = {
		"default_wood.png",
		"homedecor_generic_metal_gold.png"
	},
	inventory_image = "homedecor_trophy_inv.png",
	groups = { snappy=3 },
	walkable = false,
	selection_box = tr_cbox,
})

local sb_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.5, 0.4, 0.375, 0.5 }
}

homedecor.register("sportbench", {
	description = "Sport bench",
	mesh = "homedecor_sport_bench.obj",
	tiles = {
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor_generic_metal_bright.png",
		"homedecor_generic_metal_black.png",
		"wool_black.png"
	},
	inventory_image = "homedecor_sport_bench_inv.png",
	groups = { snappy=3 },
	selection_box = sb_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

local skate_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.15, 0.5, -0.3, 0.15 }
}

homedecor.register("skateboard", {
	drawtype = "mesh",
	mesh = "homedecor_skateboard.obj",
	tiles = { "homedecor_skateboard.png" },
	inventory_image = "homedecor_skateboard_inv.png",
	description = "Skateboard",
	groups = {snappy=3},
	selection_box = skate_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
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
	walkable = false,
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
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
	selection_box = beer_cbox
})

homedecor.register("tool_cabinet", {
	description = "Metal tool cabinet and work table",
	mesh = "homedecor_tool_cabinet.obj",
	tiles = {
		"homedecor_generic_metal_red.png",
		"homedecor_tool_cabinet_drawers.png",
		"homedecor_generic_metal_green.png",
		"homedecor_generic_metal_neutral.png",
		"homedecor_generic_metal_bright.png",
		"homedecor_tool_cabinet_misc.png",
	},
	inventory_image = "homedecor_tool_cabinet_inv.png",
	groups = { snappy=3 },
	selection_box = homedecor.nodebox.slab_y(2),
	expand = { top="air" },
	inventory = {
		size=24,
	}
})

minetest.register_alias("homedecor:tool_cabinet_bottom", "homedecor:tool_cabinet")
minetest.register_alias("homedecor:tool_cabinet_top", "air")

homedecor.register("calendar", {
	description = "Calendar",
	mesh = "homedecor_calendar.obj",
	tiles = {"homedecor_calendar.png"},
	inventory_image = "homedecor_calendar_inv.png",
	wield_image = "homedecor_calendar_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_side =   { -8/16, -8/16, -4/16, -5/16,  5/16, 4/16 },
		wall_bottom = { -4/16, -8/16, -8/16,  4/16, -5/16, 5/16 },
		wall_top =    { -4/16,  5/16, -8/16,  4/16,  8/16, 5/16 }
	},
	groups = {choppy=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local date = os.date("%Y-%m-%d") -- ISO 8601 format
		meta:set_string("infotext", "Date (right-click to update):\n"..date)
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		local date = os.date("%Y-%m-%d")
		meta:set_string("infotext", "Date (right-click to update):\n"..date)
	end
})

local globe_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.3, 0.3, 0.3, 0.3 }
}

homedecor.register("desk_globe", {
	description = "Desk globe",
	mesh = "homedecor_desk_globe.obj",
	tiles = {
		"homedecor_generic_wood_red.png",
		"homedecor_generic_metal_neutral.png",
		"homedecor_earth.png"
	},
	inventory_image = "homedecor_desk_globe_inv.png",
	selection_box = globe_cbox,
	collision_box = globe_cbox,
	groups = {choppy=2},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

local wine_cbox = homedecor.nodebox.slab_z(0.25)
homedecor.register("wine_rack", {
	description = "Wine Rack",
	mesh = "homedecor_wine_rack.obj",
	tiles = {
		"homedecor_generic_wood_red.png",
		"homedecor_bottle_brown.png",
		"homedecor_bottle_brown2.png",
		"homedecor_bottle_brown3.png",
		"homedecor_bottle_brown4.png"
	},
	inventory_image = "homedecor_wine_rack_inv.png",
	groups = {choppy=2},
	selection_box = wine_cbox,
	collision_box = wine_cbox,
	sounds = default.node_sound_defaults(),
})

local pframe_cbox = {
	type = "fixed",
	fixed = { -0.18, -0.5, -0.08, 0.18, -0.08, 0.18 }
}
local n = { 1, 2 }

for _, i in ipairs(n) do
	homedecor.register("picture_frame"..i, {
		description = S("Picture Frame"),
		mesh = "homedecor_picture_frame.obj",
		tiles = {
			"homedecor_picture_frame_image"..i..".png",
			"homedecor_picture_frame_edges.png",
			"homedecor_picture_frame_back.png",
		},
		inventory_image = "homedecor_picture_frame"..i.."_inv.png",
		wield_image = "homedecor_picture_frame"..i.."_inv.png",
		groups = {snappy = 3},
		selection_box = pframe_cbox,
		walkable = false,
		sounds = default.node_sound_glass_defaults()
	})
end

for i = 1,20 do
	homedecor.register("painting_"..i, {
		description = "Decorative painting #"..i,
		tiles = {
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_edges.png",
			"homedecor_painting_back.png",
			"homedecor_painting"..i..".png"
		},
		node_box = {
			type = "fixed",
			fixed = {
				{ -32/64, -32/64, 28/64, -30/64,  32/64, 32/64 }, -- left edge
				{  30/64, -32/64, 28/64,  32/64,  32/64, 32/64 }, -- right edge
				{ -32/64,  30/64, 28/64,  32/64,  32/64, 32/64 }, -- top edge
				{ -32/64, -30/64, 28/64,  32/64, -32/64, 32/64 }, -- bottom edge
				{ -32/64, -32/64, 29/64,  32/64,  32/64, 29/64 }  -- the canvas
			}
		},
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

homedecor.banister_materials = {
	{	"wood",
		"wood",
		"default_wood.png",
		"default_wood.png",
		"group:wood",
		"group:stick",
		"",
		""
	},
	{	"white_dark",
		"dark topped",
		"homedecor_generic_wood_white.png",
		"homedecor_generic_wood_dark.png",
		"group:wood",
		"group:stick",
		"dye:brown",
		"dye:white"
	},
	{	"brass",
		"brass",
		"homedecor_generic_wood_white.png",
		"homedecor_generic_metal_brass.png",
		"technic:brass_ingot",
		"group:stick",
		"",
		"dye:white"
	},
	{	"wrought_iron",
		"wrought iron",
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor:pole_wrought_iron",
		"homedecor:pole_wrought_iron",
		"",
		""
	}
}

for _, side in ipairs({"left", "right"}) do

	for i in ipairs(homedecor.banister_materials) do

		local name = homedecor.banister_materials[i][1]
		local cbox = {
			type = "fixed",
			fixed = { -9/16, -3/16, 5/16, 9/16, 24/16, 8/16}
		}

		local onplace = nil
		groups = { snappy = 3, not_in_creative_inventory = 1}

		if side == "left" then
			onplace = homedecor.place_banister
			groups = { snappy = 3 }
		end

		homedecor.register("banister_"..name.."_"..side, {
			description = S("Banister for Stairs ("..homedecor.banister_materials[i][2]..", "..side.." side)"),
			mesh = "homedecor_banister_"..side..".obj",
			tiles = {
				homedecor.banister_materials[i][3],
				homedecor.banister_materials[i][4]
			},
			inventory_image = "homedecor_banister_"..name.."_inv.png",
			groups = groups,
			selection_box = cbox,
			collision_box = cbox,
			on_place = onplace,
			drop = "homedecor:banister_"..name.."_left",
		})
	end
end

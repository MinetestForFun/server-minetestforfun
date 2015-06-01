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

local rug_types = {
	{ "small",   "homedecor_small_rug.obj" },
	{ "large",   { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 } },
	{ "persian", { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 } }
}

for i in ipairs(rug_types) do
	s = rug_types[i][1]
	m = rug_types[i][2]

	local mesh = m
	local nodebox = nil
	local tiles = { "homedecor_rug_"..s..".png", "wool_grey.png" }

	if type(m) == "table" then
		mesh = nil
		nodebox = {
			type = "fixed",	
			fixed = m
		}
		tiles = {
			"homedecor_rug_"..s..".png",
			"wool_grey.png",
			"homedecor_rug_"..s..".png"
		}
	end

	homedecor.register("rug_"..s, {
		description = S("Rug ("..s..")"),
		mesh = mesh,
		tiles = tiles,
		node_box = nodebox,
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
		"default_dirt.png^[colorize:#000000:175"
	},
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_stone_defaults(),
})
end

local flowers_list = {
	{ "Rose",				"rose", 			"flowers:rose" },
	{ "Tulip",				"tulip", 			"flowers:tulip" },
	{ "Yellow Dandelion",	"dandelion_yellow",	"flowers:dandelion_yellow" },
	{ "White Dandelion",	"dandelion_white",	"flowers:dandelion_white" },
	{ "Blue Geranium",		"geranium",			"flowers:geranium" },
	{ "Viola",				"viola",			"flowers:viola" },
	{ "Cactus",				"cactus",			"default:cactus" },
	{ "Bonsai",				"bonsai",			"default:sapling" }
}

for i in ipairs(flowers_list) do
	local flowerdesc	= flowers_list[i][1]
	local flower		= flowers_list[i][2]
	local craftwith		= flowers_list[i][3]
	
	homedecor.register("potted_"..flower, {
		description = S("Potted flower ("..flowerdesc..")"),
		mesh = "homedecor_flowerpot_small.obj",
		tiles = {"homedecor_potted_"..flower..".png", "homedecor_potted.png"},
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.4, 0.2 }
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "homedecor:potted_"..flower,
		recipe = { craftwith, "homedecor:flower_pot_small" }
	})

	minetest.register_alias("flowers:flower_"..flower.."_pot", "homedecor:potted_"..flower)
	minetest.register_alias("flowers:potted_"..flower, "homedecor:potted_"..flower)
	minetest.register_alias("flowers:flower_pot", "homedecor:flower_pot_small")
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

local ft_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.375, 0.5, 0.3125, 0.375 }
}

homedecor.register("fishtank", {
	description = "Fishtank",
	mesh = "homedecor_fishtank.obj",
	tiles = {
		"homedecor_generic_plastic_black.png",
		"homedecor_fishtank_filter.png",
		"homedecor_fishtank_fishes.png",
		"homedecor_fishtank_gravel.png",
		"homedecor_fishtank_water_top.png",
		"homedecor_fishtank_sides.png",
	},
	use_texture_alpha = true,
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name = "homedecor:fishtank_lighted", param2 = node.param2})
	end
})

homedecor.register("fishtank_lighted", {
	description = "Fishtank (lighted)",
	mesh = "homedecor_fishtank.obj",
	tiles = {
		"homedecor_generic_plastic_black.png",
		"homedecor_fishtank_filter.png",
		"homedecor_fishtank_fishes_lighted.png",
		"homedecor_fishtank_gravel_lighted.png",
		"homedecor_fishtank_water_top_lighted.png",
		"homedecor_fishtank_sides_lighted.png",
	},
	light_source = LIGHT_MAX-4,
	use_texture_alpha = true,
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name = "homedecor:fishtank", param2 = node.param2})
	end,
	drop = "homedecor:fishtank",
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
		homedecor.plain_wood,
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
		"homedecor_generic_wood_luxury.png^[colorize:#000000:90"
	},
	description = "Pool Table",
	inventory_image = "homedecor_pool_table_inv.png",
	groups = {snappy=3},
	selection_box = pooltable_cbox,
	collision_box = pooltable_cbox,
	expand = { forward="air" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:pool_table_2", "air")

homedecor.register("coatrack_wallmount", {
	tiles = { homedecor.plain_wood },
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
		homedecor.plain_wood,
		"homedecor_generic_wood_old.png"
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
	on_rotate = screwdriver.rotate_simple
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
		"homedecor_generic_wood_luxury.png^[colorize:#000000:175",
		"homedecor_piano_keys.png",
		"homedecor_generic_metal_brass.png",
	},
	inventory_image = "homedecor_piano_inv.png",
	description = "Piano",
	groups = { snappy = 3 },
	selection_box = piano_cbox,
	collision_box = piano_cbox,
	expand = { right="air" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow
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
	mesh = "homedecor_beer_taps.obj",
	tiles = {
		"homedecor_generic_metal_bright.png",
		"homedecor_generic_metal_black.png",
	},
	inventory_image = "homedecor_beertap_inv.png",
	groups = { snappy=3 },
	walkable = false,
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
	selection_box = beer_cbox,
	on_use = minetest.item_eat(2)
})

homedecor.register("tool_cabinet", {
	description = "Metal tool cabinet and work table",
	mesh = "homedecor_tool_cabinet.obj",
	tiles = {
		"homedecor_generic_metal_black.png^[colorize:#ff0000:150",
		"homedecor_tool_cabinet_drawers.png",
		"homedecor_generic_metal_black.png^[colorize:#006000:150",
		"homedecor_generic_metal_black.png^[brighten",
		"homedecor_generic_metal_bright.png",
		"homedecor_tool_cabinet_misc.png",
	},
	inventory_image = "homedecor_tool_cabinet_inv.png",
	on_rotate = screwdriver.rotate_simple,
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
		"homedecor_generic_metal_black.png^[brighten",
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
			"homedecor_generic_wood_luxury.png^[colorize:#000000:50",
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

local p_cbox = {
	type = "fixed",
	fixed = {
		{ -0.5, -0.5, 0.4375, 0.5, 0.5, 0.5 }
	}
}

for i = 1,20 do
	homedecor.register("painting_"..i, {
		description = "Decorative painting #"..i,
		mesh = "homedecor_painting.obj",
		tiles = {
			"default_wood.png",
			"homedecor_blank_canvas.png",
			"homedecor_painting"..i..".png"
		},
		selection_box = p_cbox,
		walkable = false,
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
		homedecor.white_wood,
		homedecor.dark_wood,
		"group:wood",
		"group:stick",
		"dye:brown",
		"dye:white"
	},
	{	"brass",
		"brass",
		homedecor.white_wood,
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

for _, side in ipairs({"diagonal_left", "diagonal_right", "horizontal"}) do

	for i in ipairs(homedecor.banister_materials) do

		local name = homedecor.banister_materials[i][1]
		local nodename = "banister_"..name.."_"..side

		local groups = { snappy = 3, not_in_creative_inventory = 1 }
		local cbox = {
			type = "fixed",
			fixed = { -9/16, -3/16, 5/16, 9/16, 24/16, 8/16 }
		}

		if side == "horizontal" then
			groups = { snappy = 3 }
			cbox = {
				type = "fixed",
				fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 }
			}
		else
			minetest.register_alias(string.gsub("homedecor:"..nodename, "diagonal_", ""), "homedecor:"..nodename)
		end

		homedecor.register(nodename, {
			description = S("Banister for Stairs ("..homedecor.banister_materials[i][2]..", "..side..")"),
			mesh = "homedecor_banister_"..side..".obj",
			tiles = {
				homedecor.banister_materials[i][3],
				homedecor.banister_materials[i][4]
			},
			inventory_image = "homedecor_banister_"..name.."_inv.png",
			groups = groups,
			selection_box = cbox,
			collision_box = cbox,
			on_place = homedecor.place_banister,
			drop = "homedecor:banister_"..name.."_horizontal",
		})
	end
end

homedecor.register("spiral_staircase", {
	description = "Spiral Staircase",
	mesh = "homedecor_spiral_staircase.obj",
	tiles = {
		"homedecor_generic_metal_wrought_iron.png",
	},
	selection_box = {
		type = "fixed",
		fixed = { -1.5, -0.5, -1.5, 0.5, 2.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5625, -0.5, -0.5625, -0.4375, 2.5, -0.4375}, -- NodeBox9
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0}, -- NodeBox14
			{-0.5, -0.125, -0.5, -0.25, -0.0625, 0.5}, -- NodeBox15
			{-0.25, -0.125, -0.0625, 0, -0.0625, 0.5}, -- NodeBox16
			{-1, 0.25, -0.5, -0.5, 0.3125, 0.5}, -- NodeBox17
			{-1.5, 0.625, -0.5, -0.5, 0.6875, -0.25}, -- NodeBox18
			{-1.5, 0.625, -0.25, -0.9375, 0.6875, 0}, -- NodeBox19
			{-1.5, 1, -1, -0.5, 1.0625, -0.5}, -- NodeBox20
			{-0.75, 1.375, -1.5, -0.5, 1.4375, -0.5}, -- NodeBox21
			{-1, 1.375, -1.5, -0.75, 1.4375, -1}, -- NodeBox22
			{-0.5, 1.75, -1.5, 0.0625, 1.8125, -0.5}, -- NodeBox23
			{-0.5, 2.125, -0.8125, 0.5, 2.1875, -0.5}, -- NodeBox24
			{-0.0625, 2.125, -1.0625, 0.5, 2.1875, -0.75}, -- NodeBox25
			{-1.5, -0.125, 0.4375, 0.5, 1.625, 0.5}, -- NodeBox26
			{-1.5, 1.5625, -1.5, -1.4375, 2.875, 0.5}, -- NodeBox27
			{-1.5, 1.75, -1.5, 0.5, 3.3125, -1.4375}, -- NodeBox28
			{0.4375, -0.5, -0.5, 0.5, 0.875, 0.5}, -- NodeBox29
			{0.4375, 2.125, -1.5, 0.5, 3.3125, 0.5}, -- NodeBox30
		}
	},
	groups = {choppy=2},
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.rotate_simple,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local leftx =  homedecor.fdir_to_left[fdir+1][1]
		local leftz =  homedecor.fdir_to_left[fdir+1][2]
		local revx  = -homedecor.fdir_to_fwd[fdir+1][1]
		local revz  = -homedecor.fdir_to_fwd[fdir+1][2]

		local corner1 = { x = pos.x + leftx + revx, y = pos.y, z = pos.z + leftz + revz}
		local corner2 = { x = pos.x, y = pos.y + 2, z = pos.z }

		local minp = { x = math.min(corner1.x, corner2.x),
		               y = math.min(corner1.y, corner2.y),
		               z = math.min(corner1.z, corner2.z) }

		local maxp = { x = math.max(corner1.x, corner2.x),
		               y = math.max(corner1.y, corner2.y),
		               z = math.max(corner1.z, corner2.z) }

		if #minetest.find_nodes_in_area(minp, maxp, "air") < 11 then
			minetest.set_node(pos, {name = "air"})
			minetest.chat_send_player(placer:get_player_name(), "This object takes up a 2x3x2 block of space (the bottom step goes in the forward-right corner), and some of it is occupied!" )
			return true
		end

		local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

		if belownode and belownode.name == "homedecor:spiral_staircase" then
			local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
			minetest.set_node(pos, { name = "air" })
			minetest.set_node(newpos, { name = "homedecor:spiral_staircase", param2 = belownode.param2 })
		end
	end
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)

	local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

	if belownode and belownode.name == "homedecor:spiral_staircase" then

		minetest.set_node(pos, { name = "air" })

		local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
		local checknode = minetest.get_node(newpos)

		if checknode and checknode.name == "air" then
			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			minetest.set_node(newpos, { name = newnode.name, param2 = fdir })
		else
			return true
		end
	end
end)

local svm_cbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
}

homedecor.register("soda_machine", {
	description = "Soda Vending Machine",
	mesh = "homedecor_soda_machine.obj",
	tiles = {"homedecor_soda_machine.png"},
	groups = {snappy=3},
	selection_box = svm_cbox,
	collision_box = svm_cbox,
	expand = { top="air" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.rotate_simple,
	on_punch = function(pos, node, puncher, pointed_thing)
		local wielditem = puncher:get_wielded_item()
		local wieldname = wielditem:get_name()
		local fdir_to_fwd = { {0, -1}, {-1, 0}, {0, 1}, {1, 0} }
		local fdir = node.param2
		local pos_drop = { x=pos.x+fdir_to_fwd[fdir+1][1], y=pos.y, z=pos.z+fdir_to_fwd[fdir+1][2] }
		if wieldname == "homedecor:coin" then
			wielditem:take_item()
			puncher:set_wielded_item(wielditem)
			minetest.spawn_item(pos_drop, "homedecor:soda_can")
			minetest.sound_play("insert_coin", {
				pos=pos, max_hear_distance = 5
			})
		else
			minetest.chat_send_player(puncher:get_player_name(), "Please insert a coin in the machine.")
		end
	end
})

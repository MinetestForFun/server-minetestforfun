-- This file supplies glowlights

local dirs1 = { 20, 23, 22, 21 }
local dirs2 = { 9, 18, 7, 12 }

local S = homedecor.gettext

local colors = {"yellow","white"}

for i in ipairs(colors) do
	local color = colors[i]

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thin_"..color },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.set_node(pos, {name = "homedecor:glowlight_quarter_"..color, param2 = 20})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thick_"..color },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.set_node(pos, {name = "homedecor:glowlight_half_"..color, param2 = 20})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thin_"..color.."_wall" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
			local nfdir = dirs2[fdir+1]
			minetest.set_node(pos, {name = "homedecor:glowlight_quarter_"..color, param2 = nfdir})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thick_"..color.."_wall" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
			local nfdir = dirs2[fdir+1]
			minetest.set_node(pos, {name = "homedecor:glowlight_half_"..color, param2 = nfdir})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_small_cube_"..color.."_ceiling" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.set_node(pos, {name = "homedecor:glowlight_small_cube_"..color, param2 = 20})
		end,
	})

local glowlight_nodebox = {
	half = homedecor.nodebox.slab_y(1/2),
	quarter = homedecor.nodebox.slab_y(1/4),
	small_cube = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
}

homedecor.register("glowlight_half_"..color, {
	description = S("Thick Glowlight ("..color..")"),
	tiles = {
		"homedecor_glowlight_"..color.."_top.png",
		"homedecor_glowlight_"..color.."_bottom.png",
		"homedecor_glowlight_thick_"..color.."_sides.png",
		"homedecor_glowlight_thick_"..color.."_sides.png",
		"homedecor_glowlight_thick_"..color.."_sides.png",
		"homedecor_glowlight_thick_"..color.."_sides.png"
	},
	selection_box = glowlight_nodebox.half,
	node_box = glowlight_nodebox.half,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("glowlight_quarter_"..color, {
	description = S("Thin Glowlight ("..color..")"),
	tiles = {
		"homedecor_glowlight_"..color.."_top.png",
		"homedecor_glowlight_"..color.."_bottom.png",
		"homedecor_glowlight_thin_"..color.."_sides.png",
		"homedecor_glowlight_thin_"..color.."_sides.png",
		"homedecor_glowlight_thin_"..color.."_sides.png",
		"homedecor_glowlight_thin_"..color.."_sides.png"
	},
	selection_box = glowlight_nodebox.quarter,
	node_box = glowlight_nodebox.quarter,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

-- Glowlight "cubes"

homedecor.register("glowlight_small_cube_"..color, {
	description = S("Small Glowlight Cube ("..color..")"),
	tiles = {
		"homedecor_glowlight_cube_"..color.."_tb.png",
		"homedecor_glowlight_cube_"..color.."_tb.png",
		"homedecor_glowlight_cube_"..color.."_sides.png",
		"homedecor_glowlight_cube_"..color.."_sides.png",
		"homedecor_glowlight_cube_"..color.."_sides.png",
		"homedecor_glowlight_cube_"..color.."_sides.png"
	},
	selection_box = glowlight_nodebox.small_cube,
	node_box = glowlight_nodebox.small_cube,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

end

homedecor.register("plasma_lamp", {
	description = "Plasma Lamp",
	drawtype = "glasslike_framed",
	tiles = {"default_gold_block.png","homedecor_glass_face_clean.png"},
	special_tiles = {
		{
			name="homedecor_plasma_storm.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		}
	},
	use_texture_alpha = true,
	light_source = LIGHT_MAX - 1,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.swap_node(pos, {name = "homedecor:plasma_lamp", param2 = 255})
	end
})

homedecor.register("plasma_ball", {
	description = "Plasma Ball",
	mesh = "homedecor_plasma_ball.obj",
	tiles = {
		"homedecor_generic_plastic_black.png",
		{
			name = "homedecor_plasma_ball_streamers.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		},
		"homedecor_plasma_ball_glass.png"
	},
	inventory_image = "homedecor_plasma_ball_inv.png",
	selection_box = {	
		type = "fixed",
		fixed = { -0.1875, -0.5, -0.1875, 0.1875, 0, 0.1875 }
	},
	walkable = false,
	use_texture_alpha = true,
	light_source = LIGHT_MAX - 5,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

local tc_cbox = {
	type = "fixed",
	fixed = {
		{ -0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875 },
	}
}

homedecor.register("candle", {
	description = S("Thick Candle"),
	mesh = "homedecor_candle_thick.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	inventory_image = "homedecor_candle_inv.png",
	selection_box = tc_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

local c_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0.05, 0.125 },
	}
}

homedecor.register("candle_thin", {
	description = S("Thin Candle"),
	mesh = "homedecor_candle_thin.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	inventory_image = "homedecor_candle_thin_inv.png",
	selection_box = c_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

local cs_cbox = {
	type = "fixed",
	fixed = {
		{ -0.15625, -0.5, -0.15625, 0.15625, 0.3125, 0.15625 },
	}
}

homedecor.register("candlestick_wrought_iron", {
	description = S("Candlestick (wrought iron)"),
	mesh = "homedecor_candlestick.obj",
	tiles = {
		"homedecor_candle_sides.png",
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"homedecor_generic_metal_wrought_iron.png",
	},
	inventory_image = "homedecor_candlestick_wrought_iron_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

homedecor.register("candlestick_brass", {
	description = S("Candlestick (brass)"),
	mesh = "homedecor_candlestick.obj",
	tiles = {
		"homedecor_candle_sides.png",
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"homedecor_generic_metal_brass.png",
	},
	inventory_image = "homedecor_candlestick_brass_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

homedecor.register("wall_sconce", {
	description = S("Wall sconce"),
	mesh = "homedecor_wall_sconce.obj",
	tiles = {
		'homedecor_candle_sides.png',
		{name="homedecor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		'homedecor_wall_sconce_back.png',
		'homedecor_generic_metal_wrought_iron.png',
	},
	inventory_image = "homedecor_wall_sconce_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.1875, -0.25, 0.3125, 0.1875, 0.25, 0.5 }
	},
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

local ol_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16, -8/16, -3/16, 5/16, 4/16, 3/16 },
	}
}

homedecor.register("oil_lamp", {
	description = S("Oil lamp (hurricane)"),
	mesh = "homedecor_oil_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_metal_black.png",
		"homedecor_generic_metal_black.png^[colorize:#ff0000:160",
		"homedecor_oil_lamp_wick.png",
		"homedecor_generic_metal_black.png^[colorize:#ff0000:150",
		"homedecor_oil_lamp_glass.png",
	},
	use_texture_alpha = true,
	inventory_image = "homedecor_oil_lamp_inv.png",
	selection_box = ol_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

homedecor.register("oil_lamp_tabletop", {
	description = S("Oil Lamp (tabletop)"),
	mesh = "homedecor_oil_lamp_tabletop.obj",
	tiles = {"homedecor_oil_lamp_tabletop.png"},
	inventory_image = "homedecor_oil_lamp_tabletop_inv.png",
	selection_box = ol_cbox,
	collision_box = ol_cbox,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

local gl_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.45, 0.25 },
}

minetest.register_alias("homedecor:wall_lantern", "homedecor:ground_lantern")

homedecor.register("ground_lantern", {
	description = S("Ground Lantern"),
	mesh = "homedecor_ground_lantern.obj",
	tiles = { "homedecor_light.png", "homedecor_generic_metal_wrought_iron.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_ground_lantern_inv.png",
	wield_image = "homedecor_ground_lantern_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = gl_cbox,
	walkable = false
})

local hl_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.2, 0.25, 0.5, 0.5 },
}

homedecor.register("hanging_lantern", {
	description = S("Hanging Lantern"),
	mesh = "homedecor_hanging_lantern.obj",
	tiles = { "homedecor_generic_metal_wrought_iron.png", "homedecor_light.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_hanging_lantern_inv.png",
	wield_image = "homedecor_hanging_lantern_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = hl_cbox,
	walkable = false
})

local cl_cbox = {
	type = "fixed",
	fixed = { -0.35, -0.45, -0.35, 0.35, 0.5, 0.35 }
}

homedecor.register("ceiling_lantern", {
	drawtype = "mesh",
	mesh = "homedecor_ceiling_lantern.obj",
	tiles = { "homedecor_light.png", "homedecor_generic_metal_wrought_iron.png" },
	use_texture_alpha = true,
	inventory_image = "homedecor_ceiling_lantern_inv.png",
	description = "Ceiling Lantern",
	groups = {snappy=3},	
	light_source = 11,
	selection_box = cl_cbox,
	walkable = false
})

homedecor.register("lattice_lantern_large", {
	description = S("Lattice lantern (large)"),
	tiles = { 'homedecor_lattice_lantern_large.png' },
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_glass_defaults(),
})

homedecor.register("lattice_lantern_small", {
	description = S("Lattice lantern (small)"),
	tiles = {
		'homedecor_lattice_lantern_small_tb.png',
		'homedecor_lattice_lantern_small_tb.png',
		'homedecor_lattice_lantern_small_sides.png'
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})

local repl = { off="low", low="med", med="hi", hi="max", max="off", }

local brights_tab = { 0, 50, 100, 150, 200 }

local lamp_colors = {
	{"white", "#ffffffe0:175"},
	{"blue", "#2626c6e0:200"},
	{"green", "#27a927e0:200"},
	{"pink", "#ff8fb7e0:200"},
	{"red", "#ad2323e0:200"},
	{"violet", "#7f29d7e0:200"}
}

local tlamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
}

local slamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 1.5, 0.25 }
}

local function reg_lamp(suffix, nxt, tilesuffix, light, color)
	local lampcolor = "_"..color[1]
	local colordesc = " ("..color[1]..")"
	local woolcolor = color[1]
	local invcolor = color[2]
	local wool_brighten = (light or 0) * 7
	local bulb_brighten = (light or 0) * 14

	if color == "" then
		lampcolor = ""
		colordesc  = " (white)"
		woolcolor = "white"
	end

	homedecor.register("table_lamp"..lampcolor.."_"..suffix, {
		description = S("Table Lamp "..colordesc),
		mesh = "homedecor_table_lamp.obj",
		tiles = {
			"wool_"..woolcolor..".png^[colorize:#ffffff:"..wool_brighten,
			"homedecor_table_standing_lamp_lightbulb.png^[colorize:#ffffff:"..bulb_brighten,
			"homedecor_generic_wood_red.png",
			"homedecor_generic_metal_black.png^[brighten",
		},
		inventory_image = "homedecor_table_lamp_foot_inv.png^(homedecor_table_lamp_top_inv.png^[colorize:"..invcolor..")",
		walkable = false,
		light_source = light,
		selection_box = tlamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		groups = {cracky=2,oddly_breakable_by_hand=1,
			not_in_creative_inventory=((light ~= nil) and 1) or nil,
		},
		drop = "homedecor:table_lamp"..lampcolor.."_off",
		on_punch = function(pos, node, puncher)
			node.name = "homedecor:table_lamp"..lampcolor.."_"..repl[suffix]
			minetest.set_node(pos, node)
		end,
	})

	-- standing lamps

	homedecor.register("standing_lamp"..lampcolor.."_"..suffix, {
		description = S("Standing Lamp"..colordesc),
		mesh = "homedecor_standing_lamp.obj",
		tiles = {
			"wool_"..woolcolor..".png^[colorize:#ffffff:"..wool_brighten,
			"homedecor_table_standing_lamp_lightbulb.png^[colorize:#ffffff:"..bulb_brighten,
			"homedecor_generic_wood_red.png",
			"homedecor_generic_metal_black.png^[brighten",
		},
		inventory_image = "homedecor_standing_lamp_foot_inv.png^(homedecor_standing_lamp_top_inv.png^[colorize:"..invcolor..")",
		walkable = false,
		light_source = light,
		groups = {cracky=2,oddly_breakable_by_hand=1,
			not_in_creative_inventory=((light ~= nil) and 1) or nil,
		},
		selection_box = slamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.rotate_simple,
		on_punch = function(pos, node, puncher)
			node.name = "homedecor:standing_lamp"..lampcolor.."_"..repl[suffix]
			minetest.set_node(pos, node)
		end,
		expand = { top="air" },
	})

	minetest.register_alias("homedecor:standing_lamp_bottom"..lampcolor.."_"..suffix, "homedecor:standing_lamp"..lampcolor.."_"..suffix)
	minetest.register_alias("homedecor:standing_lamp_top"..lampcolor.."_"..suffix, "air")
	minetest.register_alias("homedecor:standing_lamp_"..suffix, "homedecor:standing_lamp_white_"..suffix)
	minetest.register_alias("homedecor:standing_lamp_whiteoff", "homedecor:standing_lamp_white_off")
	minetest.register_alias("homedecor:table_lamp_"..suffix, "homedecor:table_lamp_white_"..suffix)
	minetest.register_alias("homedecor:table_lamp_whiteoff", "homedecor:table_lamp_white_off")

	-- for old maps that had the original 3dforniture mod
	if lampcolor == "" then
		minetest.register_alias("3dforniture:table_lamp_"..suffix, "homedecor:table_lamp_"..suffix)
	end
end

for _, color in ipairs(lamp_colors) do
	reg_lamp("off",  "low",  "",   nil,  color )
	reg_lamp("low",  "med",  "l",    3,  color )
	reg_lamp("med",  "hi",   "m",    7,  color )
	reg_lamp("hi",   "max",  "h",   11,  color )
	reg_lamp("max",  "off",  "x",   14,  color )
end

local dlamp_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.5, -0.15, 0.32, 0.12, 0.15 },
}

local dlamp_colors = { "red","blue","green","violet" }

for _, color in ipairs(dlamp_colors) do 
	homedecor.register("desk_lamp_"..color, {
		description = S("Desk Lamp ("..color..")"),
		mesh = "homedecor_desk_lamp.obj",
		tiles = {
			"homedecor_table_standing_lamp_lightbulb.png^[colorize:#ffffff:200",
			"homedecor_generic_metal_black.png^[colorize:"..color..":150",
			"homedecor_generic_metal_black.png",
			"homedecor_generic_metal_black.png^[colorize:"..color..":150"
		},
		inventory_image = "homedecor_desk_lamp_stem_inv.png^(homedecor_desk_lamp_metal_inv.png^[colorize:"..color..":140)",
		selection_box = dlamp_cbox,
		walkable = false,
		groups = {snappy=3},
	})
end

homedecor.register("ceiling_lamp", {
	description = S("Ceiling Lamp"),
	mesh = "homedecor_ceiling_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_ceiling_lamp_glass.png",
		"homedecor_table_standing_lamp_lightbulb.png^[colorize:#ffffff:200",
		"homedecor_generic_plastic_black.png^[colorize:#442d04:200",
	},
	inventory_image = "homedecor_ceiling_lamp_inv.png",
	light_source = LIGHT_MAX,
	groups = {snappy=3},
	walkable = false,
	on_punch = function(pos, node, puncher)
		minetest.set_node(pos, {name = "homedecor:ceiling_lamp_off"})
	end,
})

homedecor.register("ceiling_lamp_off", {
	description = S("Ceiling Lamp (off)"),
	mesh = "homedecor_ceiling_lamp.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_ceiling_lamp_glass.png",
		"homedecor_table_standing_lamp_lightbulb.png",
		"homedecor_generic_plastic_black.png^[colorize:#442d04:200",
	},
	groups = {snappy=3, not_in_creative_inventory=1},
	walkable = false,
	on_punch = function(pos, node, puncher)
		minetest.set_node(pos, {name = "homedecor:ceiling_lamp"})
	end,
	drop = "homedecor:ceiling_lamp"
})

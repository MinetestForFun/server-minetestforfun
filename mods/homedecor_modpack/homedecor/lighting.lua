
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
			minetest.add_node(pos, {name = "homedecor:glowlight_quarter_"..color, param2 = 20})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thick_"..color },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.add_node(pos, {name = "homedecor:glowlight_half_"..color, param2 = 20})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thin_"..color.."_wall" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
			local nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "homedecor:glowlight_quarter_"..color, param2 = nfdir})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thick_"..color.."_wall" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
			local nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "homedecor:glowlight_half_"..color, param2 = nfdir})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_small_cube_"..color.."_ceiling" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.add_node(pos, {name = "homedecor:glowlight_small_cube_"..color, param2 = 20})
		end,
	})
end

local glowlight_nodebox = {
	half = homedecor.nodebox.slab_y(1/2),
	quarter = homedecor.nodebox.slab_y(1/4),
	small_cube = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
	},
}

-- Yellow

homedecor.register("glowlight_half_yellow", {
	description = S("Yellow Glowlight (thick)"),
	tiles = {
		'homedecor_glowlight_yellow_top.png',
		'homedecor_glowlight_yellow_bottom.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png'
	},
	selection_box = glowlight_nodebox.half,
	node_box = glowlight_nodebox.half,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("glowlight_quarter_yellow", {
	description = S("Yellow Glowlight (thin)"),
	tiles = {
		'homedecor_glowlight_yellow_top.png',
		'homedecor_glowlight_yellow_bottom.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png'
	},
	selection_box = glowlight_nodebox.quarter,
	node_box = glowlight_nodebox.quarter,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- White

homedecor.register("glowlight_half_white", {
	description = S("White Glowlight (thick)"),
	tiles = {
		'homedecor_glowlight_white_top.png',
		'homedecor_glowlight_white_bottom.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png'
	},
	selection_box = glowlight_nodebox.half,
	node_box = glowlight_nodebox.half,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("glowlight_quarter_white", {
	description = S("White Glowlight (thin)"),
	tiles = {
		'homedecor_glowlight_white_top.png',
		'homedecor_glowlight_white_bottom.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png'
	},
	selection_box = glowlight_nodebox.quarter,
	node_box = glowlight_nodebox.quarter,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- Glowlight "cubes"

homedecor.register("glowlight_small_cube_yellow", {
	description = S("Yellow Glowlight (small cube)"),
	tiles = {
		'homedecor_glowlight_cube_yellow_tb.png',
		'homedecor_glowlight_cube_yellow_tb.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png'
	},
	selection_box = glowlight_nodebox.small_cube,
	node_box = glowlight_nodebox.small_cube,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("glowlight_small_cube_white", {
	description = S("White Glowlight (small cube)"),
	tiles = {
		'homedecor_glowlight_cube_white_tb.png',
		'homedecor_glowlight_cube_white_tb.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png'
	},
	selection_box = glowlight_nodebox.small_cube,
	node_box = glowlight_nodebox.small_cube,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

homedecor.register("plasma_lamp", {
	description = "Plasma Lamp",
	drawtype = "glasslike_framed",
	tiles = {"homedecor_gold_block.png","homedecor_glass_face_clean.png"},
	special_tiles = {
		{
			name="homedecor_plasma_storm.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		}
	},
--	use_texture_alpha = true,
	light_source = LIGHT_MAX - 1,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.swap_node(pos, {name = "homedecor:plasma_lamp", param2 = 255})
	end
})

homedecor.register("candle", {
	description = S("Thick Candle"),
	tiles = {
		'homedecor_candle_top.png',
		'homedecor_candle_top.png',
		{name="homedecor_candle_sides.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125, -0.5, -0.125, 0.125, 0, 0.125 },
			{ -0.125, 0, 0, 0.125, 0.5, 0 },
			{ 0, 0, -0.125, 0, 0.5, 0.125 }
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875 },
		}
	},
	sunlight_propagates = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("candle_thin", {
	description = S("Little Candle"),
	inventory_image = 'homedecor_candle_inv.png',
	drawtype = "plantlike",
	tiles = {
		{name="homedecor_candle.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1, -0.5, -0.1, 0.125, 0.05, 0.125 },
		}
	},
	sunlight_propagates = true,
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

homedecor.register("oil_lamp", {
	description = S("Oil lamp"),
	drawtype = "plantlike",
	tiles = { 'homedecor_oil_lamp.png' },
	inventory_image = 'homedecor_oil_lamp.png',
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.3, -0.5, -0.3, 0.3, 0.5, 0.3 },
		}
	},
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("wall_lantern", {
	description = S("Wall lantern"),
	drawtype = "plantlike",
	tiles = { 'homedecor_wall_lantern.png' },
	inventory_image = 'homedecor_wall_lantern.png',
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.3, -0.5, -0.3, 0.3, 0.5, 0.3 },
		}
	},
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
	sounds = default.node_sound_wood_defaults(),
})

homedecor.register("lattice_lantern_large", {
	description = S("Lattice lantern (large)"),
	tiles = { 'homedecor_lattice_lantern_large.png' },
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
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
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

local repl = { off="low", low="med", med="hi", hi="max", max="off", }
local lamp_colors = { "", "blue", "green", "pink", "red", "violet" }

local tlamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
}

local slamp_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 1.5, 0.25 }
}

local function reg_lamp(suffix, nxt, tilesuffix, light, color)
	local lampcolor = "_"..color
	local colordesc = " ("..color..")"
	if color == "" then
		lampcolor = ""
		colordesc  = " (white)"
	end

	homedecor.register("table_lamp"..lampcolor.."_"..suffix, {
		description = S("Table Lamp "..colordesc),
		mesh = "homedecor_table_lamp.obj",
		tiles = { "homedecor_table_standing_lamp"..lampcolor.."_"..suffix..".png" },
		walkable = false,
		light_source = light,
		selection_box = tlamp_cbox,
		collision_box = tlamp_cbox,
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
		tiles = { "homedecor_table_standing_lamp"..lampcolor.."_"..suffix..".png" },
		inventory_image = "homedecor_standing_lamp"..lampcolor.."_inv.png",
		walkable = false,
		light_source = light,
		groups = {cracky=2,oddly_breakable_by_hand=1,
			not_in_creative_inventory=((light ~= nil) and 1) or nil,
		},
		selection_box = slamp_cbox,
		collision_box = slamp_cbox,
		on_punch = function(pos, node, puncher)
			node.name = "homedecor:standing_lamp"..lampcolor.."_"..repl[suffix]
			minetest.set_node(pos, node)
		end,
		expand = { top="air" },
	})

	-- "bottom" in the node name is obsolete now, as "top" node doesn't exist anymore.
	minetest.register_alias("homedecor:standing_lamp_bottom"..lampcolor.."_"..suffix, "homedecor:standing_lamp"..lampcolor.."_"..suffix)
	minetest.register_alias("homedecor:standing_lamp_top"..lampcolor.."_"..suffix, "air")

	-- for old maps that had 3dfornit`ure
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

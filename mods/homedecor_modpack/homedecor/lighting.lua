
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
				nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "homedecor:glowlight_quarter_"..color, param2 = nfdir})
		end,
	})

	minetest.register_abm({
		nodenames = { "homedecor:glowlight_thick_"..color.."_wall" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
				nfdir = dirs2[fdir+1]
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

-- Yellow

minetest.register_node('homedecor:glowlight_half_yellow', {
	description = S("Yellow Glowlight (thick)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_yellow_top.png',
		'homedecor_glowlight_yellow_bottom.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png',
		'homedecor_glowlight_thick_yellow_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node('homedecor:glowlight_quarter_yellow', {
	description = S("Yellow Glowlight (thin)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_yellow_top.png',
		'homedecor_glowlight_yellow_bottom.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png',
		'homedecor_glowlight_thin_yellow_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- White

minetest.register_node('homedecor:glowlight_half_white', {
	description = S("White Glowlight (thick)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_white_top.png',
		'homedecor_glowlight_white_bottom.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png',
		'homedecor_glowlight_thick_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node('homedecor:glowlight_quarter_white', {
	description = S("White Glowlight (thin)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_white_top.png',
		'homedecor_glowlight_white_bottom.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png',
		'homedecor_glowlight_thin_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- Glowlight "cubes"

minetest.register_node('homedecor:glowlight_small_cube_yellow', {
	description = S("Yellow Glowlight (small cube)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_cube_yellow_tb.png',
		'homedecor_glowlight_cube_yellow_tb.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png',
		'homedecor_glowlight_cube_yellow_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node('homedecor:glowlight_small_cube_white', {
	description = S("White Glowlight (small cube)"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_glowlight_cube_white_tb.png',
		'homedecor_glowlight_cube_white_tb.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png',
		'homedecor_glowlight_cube_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("homedecor:plasma_lamp", {
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
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		minetest.swap_node(pos, {name = "homedecor:plasma_lamp", param2 = 255})
	end
})

minetest.register_node('homedecor:candle', {
	description = S("Thick Candle"),
	drawtype = "nodebox",
	tiles = {
		'homedecor_candle_top.png',
		'homedecor_candle_bottom.png',
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
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node('homedecor:candle_thin', {
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
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-4,
})

minetest.register_node('homedecor:oil_lamp', {
	description = S("Oil lamp"),
	drawtype = "plantlike",
	tiles = { 'homedecor_oil_lamp.png' },
	inventory_image = 'homedecor_oil_lamp.png',
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
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

minetest.register_node('homedecor:wall_lantern', {
	description = S("Wall lantern"),
	drawtype = "plantlike",
	tiles = { 'homedecor_wall_lantern.png' },
	inventory_image = 'homedecor_wall_lantern.png',
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
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

minetest.register_node('homedecor:lattice_lantern_large', {
	description = S("Lattice lantern (large)"),
	tiles = { 'homedecor_lattice_lantern_large.png' },
	sunlight_propagates = false,
	paramtype = "light",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node('homedecor:lattice_lantern_small', {
	description = S("Lattice lantern (small)"),
	drawtype = "nodebox",
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
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

local repl = { off="low", low="med", med="hi", hi="max", max="off", }
local lamp_colors = { "", "blue", "green", "pink", "red", "violet" }

local function reg_lamp(suffix, nxt, tilesuffix, light, color)
	local lampcolor = "_"..color
	local standingcolor = "_"..color
	local colordesc = " ("..color..")"
	if color == "" then
		lampcolor = ""
		standingcolor = "_white"
		colordesc  = " (white)"
	end
	minetest.register_node("homedecor:table_lamp"..lampcolor.."_"..suffix, {
	description = S("Table Lamp "..colordesc),
	drawtype = "nodebox",
	tiles = {
		"forniture_table_lamp_s"..tilesuffix..".png",
		"forniture_table_lamp_s"..tilesuffix..".png",
		"forniture_table_lamp"..lampcolor.."_l"..tilesuffix..".png",
	},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.1500, -0.500, -0.1500,  0.1500, -0.45,  0.1500 },
			{ -0.0500, -0.450, -0.0500,  0.0500, -0.40,  0.0500 },
			{ -0.0250, -0.400, -0.0250,  0.0250, -0.10,  0.0250 },
			{ -0.0125, -0.125, -0.2000,  0.0125, -0.10,  0.2000 },
			{ -0.2000, -0.125, -0.0125,  0.2000, -0.10,  0.0125 },
			{ -0.2000, -0.100, -0.2000, -0.1750,  0.30,  0.2000 },
			{  0.1750, -0.100, -0.2000,  0.2000,  0.30,  0.2000 },
			{ -0.1750, -0.100, -0.2000,  0.1750,  0.30, -0.1750 },
			{ -0.1750, -0.100,  0.1750,  0.1750,  0.30,  0.2000 },
		},
	},
	walkable = false,
	light_source = light,
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.30, 0.2 },
	},
	groups = {cracky=2,oddly_breakable_by_hand=1,
		not_in_creative_inventory=((light ~= nil) and 1) or nil,
	},
	drop = "homedecor:table_lamp"..lampcolor.."_off",
	on_punch = function(pos, node, puncher)
		node.name = "homedecor:table_lamp"..lampcolor.."_"..repl[suffix]
		minetest.set_node(pos, node)
		nodeupdate(pos)
	end,
	})
	if lampcolor == "" then 
		minetest.register_alias("3dforniture:table_lamp_"..suffix, "homedecor:table_lamp_"..suffix)
	end

	-- standing lamps

	minetest.register_node("homedecor:standing_lamp_bottom"..lampcolor.."_"..suffix, {
	description = S("Standing Lamp"..colordesc),
	drawtype = "nodebox",
	tiles = {
		"forniture_table_lamp_s"..tilesuffix..".png",
		"homedecor_standing_lamp_bottom_sides.png",
	},
	inventory_image = "homedecor_standing_lamp"..standingcolor.."_inv.png",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
                        { -0.1500, -0.500, -0.1500,  0.1500, -0.45,  0.1500 },
			{ -0.0500, -0.450, -0.0500,  0.0500, -0.40,  0.0500 },
			{ -0.0250, -0.400, -0.0250,  0.0250, 0.50,  0.0250 },
		},
	},
	walkable = false,
	light_source = light,
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0}
	},
	groups = {cracky=2,oddly_breakable_by_hand=1,
		not_in_creative_inventory=((light ~= nil) and 1) or nil,
	},
		on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:standing_lamp_bottom"..lampcolor.."_"..suffix, "homedecor:standing_lamp_top"..lampcolor.."_"..suffix)
	end,
	})
	
	minetest.register_node("homedecor:standing_lamp_top"..lampcolor.."_"..suffix, {
	drawtype = "nodebox",
	tiles = {
		"forniture_table_lamp_s"..tilesuffix..".png",
		"forniture_table_lamp_s"..tilesuffix..".png",
		"forniture_standing_lamp"..lampcolor.."_l"..tilesuffix..".png"
	},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.0250, -0.500, -0.0250,  0.0250, 0.10,  0.0250 },
			{ -0.0125, 0.0625, -0.2000,  0.0125, 0.10,  0.2000 },
			{ -0.2000, 0.0625, -0.0125,  0.2000, 0.10,  0.0125 },
			{ -0.2000, 0.100, -0.2000, -0.1750,  0.50,  0.2000 },
			{  0.1750, 0.100, -0.2000,  0.2000,  0.50,  0.2000 },
			{ -0.1750, 0.100, -0.2000,  0.1750,  0.50, -0.1750 },
			{ -0.1750, 0.100,  0.1750,  0.1750,  0.50,  0.2000 },
		},
	},
	walkable = false,
	light_source = light,
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -1.5, -0.2, 0.2, 0.5, 0.2 },
	},
	groups = {snappy=3, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher)
		node.name = "homedecor:standing_lamp_top"..lampcolor.."_"..repl[suffix]
		minetest.set_node(pos, node)
		nodeupdate(pos)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y - 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:standing_lamp_bottom"..lampcolor.."_off" then
			minetest.remove_node(pos2)
		end
	end,
	drop = "homedecor:standing_lamp_bottom"..lampcolor.."_off"
	})
end

for _, color in ipairs(lamp_colors) do
	reg_lamp("off",  "low",  "",   nil,  color )
	reg_lamp("low",  "med",  "l",    3,  color )
	reg_lamp("med",  "hi",   "m",    7,  color )
	reg_lamp("hi",   "max",  "h",   11,  color )
	reg_lamp("max",  "off",  "x",   14,  color )
end

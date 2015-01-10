-- Various misc. nodes

local S = homedecor.gettext

minetest.register_node('homedecor:ceiling_paint', {
	description = S("Textured Ceiling Paint"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_paint.png' },
	inventory_image = 'homedecor_ceiling_paint_roller.png',
	wield_image = 'homedecor_ceiling_paint_roller.png',
	sunlight_propagates = true,
	paramtype = 'light',
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

minetest.register_node('homedecor:ceiling_tile', {
	description = S("Drop-Ceiling Tile"),
	drawtype = 'signlike',
	tiles = { 'homedecor_ceiling_tile.png' },
	wield_image = 'homedecor_ceiling_tile.png',
	inventory_image = 'homedecor_ceiling_tile.png',
	sunlight_propagates = true,
	paramtype = 'light',
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

minetest.register_node('homedecor:rug_small', {
	description = S("Small Throw Rug"),
	drawtype = 'signlike',
	tiles = { 'homedecor_rug_small.png' },
	wield_image = 'homedecor_rug_small.png',
	inventory_image = 'homedecor_rug_small.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "wallmounted",
	is_ground_content = true,
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

minetest.register_node('homedecor:rug_large', {
	description = S("Large Area Rug"),
	drawtype = 'signlike',
	tiles = { 'homedecor_rug_large.png' },
	wield_image = 'homedecor_rug_large.png',
	inventory_image = 'homedecor_rug_large.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "wallmounted",
	is_ground_content = true,
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

minetest.register_node('homedecor:flower_pot_terracotta', {
	description = S("Terracotta Flower Pot"),
	drawtype = "mesh",
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_terracotta.png" },
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('homedecor:flower_pot_black', {
	description = S("Black Plastic Flower Pot"),
	drawtype = "mesh",
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_black.png" },
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('homedecor:flower_pot_green', {
	description = S("Green Plastic Flower Pot"),
	drawtype = "mesh",
	mesh = "homedecor_flowerpot.obj",
	tiles = { "homedecor_flower_pot_green.png" },
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("homedecor:pole_brass", {
    description = S("Brass Pole"),
    drawtype = "mesh",
	mesh = "homedecor_round_pole.obj",
    tiles = {"homedecor_tile_brass2.png"},
    inventory_image = "homedecor_pole_brass_inv.png",
    wield_image = "homedecor_pole_brass_inv.png",
    paramtype = "light",
	paramtype2 = "facedir",
    is_ground_content = true,
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
	walkable = true,
})
	
minetest.register_node("homedecor:pole_wrought_iron", {
    description = S("Wrought Iron Pole"),
    drawtype = "nodebox",
    tiles = {"homedecor_tile_wrought_iron2.png"},
    inventory_image = "homedecor_pole_wrought_iron_inv.png",
    wield_image = "homedecor_pole_wrought_iron_inv.png",
    paramtype = "light",
	paramtype2 = "facedir",
    is_ground_content = true,
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
	walkable = true,
})

local welcome_mat_colors = { "green", "brown", "grey" }

for _, color in ipairs(welcome_mat_colors) do
	minetest.register_node("homedecor:welcome_mat_"..color, {
		description = "Welcome Mat ("..color..")",
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
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

minetest.register_node("homedecor:chimney", {
	drawtype = "nodebox",
	paramtype = "light",
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
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("homedecor:fishtank", {
	drawtype = "nodebox",
	description = "Fishtank",
	tiles = {
		"homedecor_fishtank_top.png",
		"homedecor_fishtank_bottom.png",
		"homedecor_fishtank_right.png",
		"homedecor_fishtank_left.png",
		"homedecor_fishtank_back.png",
		"homedecor_fishtank_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:fishtank_lighted", {
	drawtype = "nodebox",
	description = "Fishtank",
	tiles = {
		"homedecor_fishtank_top.png",
		"homedecor_fishtank_bottom.png",
		"homedecor_fishtank_right_lighted.png",
		"homedecor_fishtank_left_lighted.png",
		"homedecor_fishtank_back_lighted.png",
		"homedecor_fishtank_front_lighted.png"
	},
	paramtype = "light",
	light_source = LIGHT_MAX-4,
	paramtype2 = "facedir",
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

minetest.register_node('homedecor:cardboard_box', {
	drawtype = "nodebox",
	description = S("Cardboard box"),
	tiles = {
		'homedecor_cardboard_box_tb.png',
		'homedecor_cardboard_box_tb.png',
		'homedecor_cardboard_box_sides.png'
	},
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
    selection_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
    },
	node_box = {
		type = "fixed",
		fixed = {
			{0.1875, -0.5,    -0.25,    0.25,   0,       0.25},
			{-0.25,  -0.5,    -0.25,   -0.1875, 0,       0.25},
			{-0.25,  -0.5,     0.1875,  0.25,   0,       0.25},
			{-0.25,  -0.5,    -0.25,    0.25,   0,      -0.1875},
			{-0.25,  -0.5,    -0.25,    0.25,  -0.4375,  0.25},
			{0.1875, -0.0625, -0.25,    0.5,    0,       0.25},
			{-0.5,   -0.0625, -0.25,   -0.1875, 0,       0.25},
			{-0.25,  -0.0625,  0.1875,  0.25,   0,       0.5},
			{-0.25,  -0.0625, -0.5,     0.25,   0,      -0.1875},
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,6]"..
				"list[current_name;main;2,0;4,1;]"..
				"list[current_player;main;0,2;8,4;]")
		meta:set_string("infotext", S("Cardboard box"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in cardboard box at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to cardboard box at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from cardboard box at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})

minetest.register_node("homedecor:dvd_cd_cabinet", {
	description = "DVD/CD cabinet",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node('homedecor:filing_cabinet', {
	drawtype = "nodebox",
	description = S("Filing Cabinet"),
	tiles = {
		'forniture_wood.png',
		'homedecor_filing_cabinet_bottom.png',
		'forniture_wood.png',
		'forniture_wood.png',
		'forniture_wood.png',
		'homedecor_filing_cabinet_front.png'
	},
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
        },
        node_box = {
                type = "fixed",
		fixed = {
			{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
			{ -7/16, -7/16, -8/16,  7/16,  7/16,   8/16 },	-- drawer
		}
        },
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,7]"..
				"list[current_name;main;0,0;8,2;]"..
				"list[current_player;main;0,3;8,4;]")
		meta:set_string("infotext", S("Filing cabinet"))
		local inv = meta:get_inventory()
		inv:set_size("main", 16)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in filing cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to filing cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from filing cabinet at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})

minetest.register_node("homedecor:dishwasher", {
	description = "Dishwasher",
	drawtype = "nodebox",
	tiles = {
		"homedecor_dishwasher_top.png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, 0.1875, 0.1875},
			{-0.4375, -0.5, -0.5, 0.4375, 0.4375, 0.4375},
		}
	},
    selection_box = {
            type = "fixed",
            fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
    },
	groups = { snappy = 3 },
})

minetest.register_node("homedecor:dishwasher_wood", {
	description = "Dishwasher",
	tiles = {
		"homedecor_kitchen_cabinet_top.png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
})

minetest.register_node("homedecor:dishwasher_steel", {
	description = "Dishwasher",
	tiles = {
		"homedecor_kitchen_cabinet_top_steel.png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
})

minetest.register_node("homedecor:dishwasher_marble", {
	description = "Dishwasher",
	tiles = {
		"homedecor_kitchen_cabinet_top_marble.png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
})

minetest.register_node("homedecor:dishwasher_granite", {
	description = "Dishwasher",
	tiles = {
		"homedecor_kitchen_cabinet_top_granite.png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
})

minetest.register_node("homedecor:doghouse_base", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.0, 0.5 }
	},
	groups = {snappy=3},
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
				"homedecor:doghouse_base", "homedecor:doghouse_roof")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:doghouse_roof" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:doghouse_roof", {
	tiles = {
		"homedecor_doghouse_roof_top.png",
		"homedecor_doghouse_roof_bottom.png",
		"homedecor_doghouse_roof_side.png",
		"homedecor_doghouse_roof_side.png",
		"homedecor_doghouse_roof_front.png",
		"homedecor_doghouse_roof_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
	groups = {snappy=3, not_in_creative_inventory=1},
})

minetest.register_node("homedecor:pool_table", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:pool_table", "homedecor:pool_table_2", false)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:pool_table_2" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:pool_table_2", {
	tiles = {
		"homedecor_pool_table_top1.png^[transformR180",
		"homedecor_pool_table_bottom1.png",
		"homedecor_pool_table_sides1.png^[transformFX",
		"homedecor_pool_table_sides1.png",
		"homedecor_pool_table_end1.png",
		"homedecor_pool_table_end1.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

minetest.register_node("homedecor:trash_can", {
	tiles = {
		"homedecor_trashcan_tb.png",
		"homedecor_trashcan_tb.png",
		"homedecor_trashcan_sides.png",
		"homedecor_trashcan_sides.png",
		"homedecor_trashcan_sides.png",
		"homedecor_trashcan_sides.png"
	},
	inventory_image = "homedecor_trashcan_inv.png",
	description = "Trash Can",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.125, -0.1875, 0.125, 0.125}, -- NodeBox1
			{0.1875, -0.5, -0.125, 0.25, 0.125, 0.125}, -- NodeBox2
			{-0.125, -0.5, -0.25, 0.125, 0.125, -0.1875}, -- NodeBox3
			{-0.125, -0.5, 0.1875, 0.125, 0.125, 0.25}, -- NodeBox4
			{-0.1875, -0.5, 0.125, -0.125, 0.125, 0.1875}, -- NodeBox5
			{-0.1875, -0.5, -0.1875, -0.125, 0.125, -0.125}, -- NodeBox6
			{0.125, -0.5, -0.1875, 0.1875, 0.125, -0.125}, -- NodeBox7
			{0.125, -0.5, 0.125, 0.1875, 0.125, 0.1875}, -- NodeBox8
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.125, 0.25 }
	}
})

minetest.register_node("homedecor:well_base", {
	tiles = {
		"homedecor_well_base_top.png",
		"default_cobble.png"
	},
	inventory_image = "homedecor_well_inv.png",
	description = "Water well",
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:well_base", "homedecor:well_top")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:well_top" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:well_top", {
	tiles = {
		"homedecor_well_roof_top.png",
		"homedecor_well_roof_wood.png",
		"homedecor_well_roof_side3.png",
		"homedecor_well_roof_side3.png",
		"homedecor_well_roof_side2.png",
		"homedecor_well_roof_side1.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

minetest.register_node("homedecor:coatrack_wallmount", {
	tiles = { "forniture_wood.png" },
	inventory_image = "homedecor_coatrack_wallmount_inv.png",
	description = "Coatrack (wallmounted)",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:coat_tree", {
	tiles = { "forniture_wood.png" },
	inventory_image = "homedecor_coatrack_inv.png",
	description = "Coat tree",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:doorbell", {
	tiles = { "homedecor_doorbell.png" },
	inventory_image = "homedecor_doorbell_inv.png",
	description = "Doorbell",
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0, 0.46875, 0.0625, 0.1875, 0.5}, -- NodeBox1
			{-0.03125, 0.0625, 0.45, 0.03125, 0.125, 0.4675}, -- NodeBox2
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.sound_play("homedecor_doorbell", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 15
		}) 
	end
})

minetest.register_node("homedecor:kitchen_faucet", {
	tiles = { "homedecor_bright_metal.png" },
	inventory_image = "homedecor_kitchen_faucet_inv.png",
	description = "Kitchen Faucet",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0, -0.5, 0.375, 0.0625, -0.1875, 0.4375}, -- NodeBox1
			{0, -0.1875, 0.35, 0.0625, -0.15, 0.4375}, -- NodeBox2
			{0, -0.15, 0.32, 0.0625, -0.11, 0.41}, -- NodeBox3
			{0.007, -0.12, 0.17, 0.055, -0.11, 0.1285}, -- NodeBox4
			{0, -0.11, 0.125, 0.0625, -0.07, 0.37}, -- NodeBox5
			{-0.05, -0.48, 0.385, 0.115, -0.455, 0.43}, -- NodeBox6
			{-0.05, -0.49, 0.395, 0.115, -0.445, 0.42}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.055, -0.5, 0.125, 0.12, -0.065, 0.4375 }
	},
})

minetest.register_node("homedecor:cutlery_set", {
	tiles = {
		"homedecor_cutlery_set_top.png",
		"homedecor_cutlery_set_sides.png",
		"homedecor_cutlery_set_sides.png"
	},
	inventory_image = "homedecor_cutlery_set_inv.png",
	description = "Cutlery set",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.4375, 0.125, -0.49, -0.1875}, -- NodeBox1
			{0.035, -0.5, -0.12, 0.042, -0.375, -0.036}, -- NodeBox2
			{-0.042, -0.5, -0.12, -0.035, -0.375, -0.036}, -- NodeBox3
			{-0.042, -0.5, -0.12, 0.042, -0.375, -0.112}, -- NodeBox4
			{-0.042, -0.5, -0.044, 0.042, -0.375, -0.036}, -- NodeBox5
			{-0.042, -0.40, -0.12, 0.042, -0.5, -0.036}, -- NodeBox6
			{-0.22, -0.5, -0.45, -0.205, -0.49, -0.245}, -- NodeBox7
			{-0.23, -0.5, -0.245, -0.195, -0.49, -0.24}, -- NodeBox8
			{-0.23, -0.5, -0.24, -0.225, -0.49, -0.1875}, -- NodeBox9
			{-0.22, -0.5, -0.24, -0.215, -0.49, -0.1875}, -- NodeBox10
			{-0.21, -0.5, -0.24, -0.205, -0.49, -0.1875}, -- NodeBox11
			{-0.2, -0.5, -0.24, -0.195, -0.49, -0.1875}, -- NodeBox12
			{0.205, -0.5, -0.45, 0.22, -0.49, -0.3125}, -- NodeBox13
			{0.193, -0.5, -0.3125, 0.22, -0.49, -0.185839}, -- NodeBox14
			{0.2, -0.5, -0.322, 0.22, -0.49, -0.175}, -- NodeBox15
			{-0.1095, -0.5, -0.1875, 0.1095, -0.48, -0.172}, -- NodeBox16
			{-0.1095, -0.5, -0.453, 0.1095, -0.48, -0.4375}, -- NodeBox17
			{-0.14, -0.5, -0.422, -0.125, -0.48, -0.203}, -- NodeBox18
			{0.125, -0.5, -0.422, 0.14, -0.48, -0.203}, -- NodeBox19
			{-0.125, -0.5, -0.203, -0.1095, -0.48, -0.1875}, -- NodeBox20
			{0.1095, -0.5, -0.203, 0.125, -0.48, -0.1875}, -- NodeBox21
			{-0.125, -0.5, -0.4375, -0.1095, -0.48, -0.422}, -- NodeBox22
			{0.1095, -0.5, -0.4375, 0.125, -0.48, -0.422}, -- NodeBox23
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.5, 0.25, -0.375, 0 }
	}
})

local bottle_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0, 0.125}
	}
}

minetest.register_node("homedecor:bottle_brown", {
	tiles = { "homedecor_bottle_brown.png" },
	inventory_image = "homedecor_bottle_brown_inv.png",
	description = "Brown bottle",
	drawtype = "mesh",
	mesh = "homedecor_bottle.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = bottle_cbox,
	selection_box = bottle_cbox
})

minetest.register_node("homedecor:bottle_green", {
	tiles = { "homedecor_bottle_green.png" },
	inventory_image = "homedecor_bottle_green_inv.png",
	description = "Green bottle",
	drawtype = "mesh",
	mesh = "homedecor_bottle.obj",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:4_bottles_brown", {
	tiles = { "homedecor_bottle_brown.png" },
	inventory_image = "homedecor_4_bottles_brown_inv.png",
	description = "Four brown bottles",
	drawtype = "mesh",
	mesh = "homedecor_4_bottles.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

minetest.register_node("homedecor:4_bottles_green", {
	tiles = { "homedecor_bottle_green.png" },
	inventory_image = "homedecor_4_bottles_green_inv.png",
	description = "Four green bottles",
	drawtype = "mesh",
	mesh = "homedecor_4_bottles.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

minetest.register_node("homedecor:4_bottles_multi", {
	tiles = { "homedecor_4_bottles_multi.png" },
	inventory_image = "homedecor_4_bottles_multi_inv.png",
	description = "Four misc brown/green bottles",
	drawtype = "mesh",
	mesh = "homedecor_4_bottles_multi.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {snappy=3},
	collision_box = fbottle_cbox,
	selection_box = fbottle_cbox
})

minetest.register_node("homedecor:coffee_maker", {
	tiles = {
		"homedecor_coffeemaker_top.png",
		"homedecor_coffeemaker_bottom.png",
		"homedecor_coffeemaker_right.png",
		"homedecor_coffeemaker_right.png^[transformFX",
		"homedecor_coffeemaker_back.png",
		"homedecor_coffeemaker_front.png"
	},
	description = "Coffee Maker",
	inventory_image = "homedecor_coffeemaker_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0.0625, -0.5, -0.025, 0.375, -0.375, 0.5}, -- NodeBox1
			{0.0625, -0.375, 0.3125, 0.375, 0, 0.5}, -- NodeBox2
			{0.0625, -0.052, 0.02, 0.375, 0.19, 0.5}, -- NodeBox3
			{0.078, -0.375, 0, 0.36, -0.0625, 0.3125}, -- NodeBox4
			{0.1875, -0.098, -0.0525, 0.25, -0.078, 0}, -- NodeBox5
			{0.1875, -0.36, -0.090, 0.25, -0.078, -0.0525}, -- NodeBox6
			{0.1875, -0.36, -0.0525, 0.25, -0.34, 0}, -- NodeBox7
			{-0.1875, -0.5, -0.3125, -0.1, -0.4, -0.225}, -- NodeBox8
			{-0.1975, -0.5, -0.3225, -0.1, -0.375, -0.3125}, -- NodeBox9
			{-0.1975, -0.5, -0.235, -0.1, -0.375, -0.225}, -- NodeBox10
			{-0.1975, -0.5, -0.3225, -0.1875, -0.375, -0.225}, -- NodeBox11
			{-0.11, -0.5, -0.3225, -0.1, -0.375, -0.225}, -- NodeBox12
			{-0.1, -0.485, -0.2838, -0.06, -0.475, -0.2638}, -- NodeBox13
			{-0.1, -0.4, -0.2838, -0.06, -0.39, -0.2638}, -- NodeBox14
			{-0.075, -0.485, -0.2838, -0.06, -0.39, -0.2638}, -- NodeBox15
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.22, -0.5, -0.35, 0.4, 0.21, 0.5 }
	}
})

local fdir_to_steampos = {
	x = { 0.15,   0.275, -0.15,  -0.275 },
	z = { 0.275, -0.15,  -0.275,  0.15  }
}

minetest.register_abm({
	nodenames = "homedecor:coffee_maker",
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local fdir = node.param2
		if fdir and fdir < 4 then

			local steamx = fdir_to_steampos.x[fdir + 1]
			local steamz = fdir_to_steampos.z[fdir + 1]

			minetest.add_particlespawner({
				amount = 1,
				time = 1,
				minpos = {x=pos.x - steamx, y=pos.y - 0.35, z=pos.z - steamz},
				maxpos = {x=pos.x - steamx, y=pos.y - 0.35, z=pos.z - steamz},
				minvel = {x=-0.003, y=0.01, z=-0.003},
				maxvel = {x=0.003, y=0.01, z=-0.003},
				minacc = {x=0.0,y=-0.0,z=-0.0},
				maxacc = {x=0.0,y=0.003,z=-0.0},
				minexptime = 2,
				maxexptime = 5,
				minsize = 1,
				maxsize = 1.2,
				collisiondetection = false,
				texture = "homedecor_steam.png",
			})
		end
	end
})

minetest.register_node("homedecor:dartboard", {
	description = "Dartboard",
	drawtype = "mesh",
	mesh = "homedecor_dartboard.obj",
	tiles = { "homedecor_dartboard.png" },
	inventory_image = "homedecor_dartboard_inv.png",
	wield_image = "homedecor_dartboard_inv.png",
	paramtype = "light",
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

minetest.register_node("homedecor:piano_left", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:piano_left", "homedecor:piano_right", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:piano_right" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:piano_right", {
	tiles = {
		"homedecor_piano_top_right.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_sides.png",
		"homedecor_piano_front_right.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	}
})

minetest.register_node("homedecor:toaster", {
        description = "Toaster",
	tiles = {
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png"
	},
	inventory_image = "homedecor_toaster_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.125, 0.125, -0.3125, 0.125}, -- NodeBox1
		},
	},
	on_rightclick = function(pos, node, clicker)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:toaster_loaf", param2 = fdir })
		minetest.sound_play("toaster", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5
		})
	end
})

minetest.register_node("homedecor:toaster_loaf", {
	tiles = {
		"homedecor_toaster_toploaf.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png",
		"homedecor_toaster_sides.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = { snappy=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.125, 0.125, -0.3125, 0.125}, -- NodeBox1
			{-0.03125, -0.3125, -0.0935, 0, -0.25, 0.0935}, -- NodeBox2
			{0.0625, -0.3125, -0.0935, 0.0935, -0.25, 0.0935}, -- NodeBox3
		},
	},
	on_rightclick = function(pos, node, clicker)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:toaster", param2 = fdir })
	end,
	drop = "homedecor:toaster"
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

minetest.register_node("homedecor:trophy", {
        description = "Trophy",
	tiles = {
		"default_gold_block.png"
	},
	inventory_image = "homedecor_trophy_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:sportbench", {
	description = "Sport bench",
	tiles = {
		"homedecor_sportbench_top.png",
		"wool_black.png",
		"homedecor_sportbench_left.png^[transformFX", 
		"homedecor_sportbench_left.png",
		"homedecor_sportbench_bottom.png",
		"homedecor_sportbench_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:skateboard", {
        description = "Skateboard",
	tiles = {
		"homedecor_skateboard_top.png",
		"homedecor_skateboard_bottom.png",
		"homedecor_skateboard_sides.png"
	},
	inventory_image = "homedecor_skateboard_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:copper_pans", {
	description = "Copper pans",
	tiles = {
		"homedecor_polished_copper.png"
	},
	inventory_image = "homedecor_copper_pans_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.1875, -0.0625, -0.48, 0.125}, -- NodeBox1
			{-0.375, -0.48, -0.1875, -0.36, -0.3125, 0.125}, -- NodeBox2
			{-0.0775, -0.48, -0.1875, -0.0625, -0.3125, 0.125}, -- NodeBox3
			{-0.375, -0.48, 0.11, -0.0625, -0.3125, 0.125}, -- NodeBox4
			{-0.375, -0.48, -0.1875, -0.0625, -0.3125, -0.1725}, -- NodeBox5
			{-0.25, -0.36, -0.5, -0.1875, -0.33, -0.1875}, -- NodeBox6
			{0.0625, -0.5, 0, 0.375, -0.48, 0.3125}, -- NodeBox7
			{0.0625, -0.48, 0, 0.0775, -0.3125, 0.3125}, -- NodeBox8
			{0.36, -0.48, 0, 0.375, -0.3125, 0.3125}, -- NodeBox9
			{0.0625, -0.48, 0, 0.375, -0.3125, 0.0175}, -- NodeBox10
			{0.0625, -0.48, 0.295, 0.375, -0.3125, 0.3125}, -- NodeBox11
			{0.1875, -0.36, -0.3125, 0.25, -0.33, 0}, -- NodeBox12
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.375, -0.5, -0.5, 0.375, -0.3125, 0.3125 }
	},
	on_place = minetest.rotate_node
})

minetest.register_node("homedecor:paper_towel", {
	drawtype = "mesh",
	mesh = "homedecor_paper_towel.obj",
	tiles = { "homedecor_paper_towel.png" },
	inventory_image = "homedecor_paper_towel_inv.png",
	description = "Paper towels",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3 },
	selection_box = { 
		type = "fixed",
		fixed = { -0.4375, 0.125, 0.0625, 0.4375, 0.4375, 0.5 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.4375, 0.125, 0.0625, 0.4375, 0.4375, 0.5 }
	}
})

minetest.register_node("homedecor:stonepath", {
	description = "Garden stone path",
	tiles = {
		"default_stone.png"
	},
	inventory_image = "homedecor_stonepath_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:barbecue", {
	description = "Barbecue",
	tiles = {
		{name="homedecor_barbecue_top.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		"forniture_black_metal.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:barbecue", "homedecor:barbecue_meat")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:barbecue_meat" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:barbecue_meat", {
	tiles = {
		"homedecor_barbecue_meat.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.125, -0.0625, -0.4375, 0.125}, -- NodeBox1
			{0.125, -0.5, -0.125, 0.3125, -0.4375, 0.125}, -- NodeBox2
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
       }
})

minetest.register_node("homedecor:beer_tap", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:beer_mug", {
	description = "Beer mug",
	tiles = {
		"homedecor_beer_top.png",
		"homedecor_beer_bottom.png",
		"homedecor_beer_right.png",
		"homedecor_beer_right.png^[transformFX",
		"homedecor_beer_front.png^[transformFX",
		"homedecor_beer_front.png"
	},
	inventory_image = "homedecor_beer_inv.png",
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
                	{-0.125, -0.5, -0.25, 0.0625, -0.25, -0.0625}, -- NodeBox1
			{0.0625, -0.3125, -0.18, 0.135, -0.285, -0.14}, -- NodeBox2
			{0.1, -0.465, -0.18, 0.135, -0.285, -0.14}, -- NodeBox3
			{0.0625, -0.465, -0.18, 0.135, -0.4375, -0.14}, -- NodeBox4
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.125, -0.5, -0.25, 0.135, -0.25, -0.0625 }
	}
})

minetest.register_node("homedecor:tool_cabinet_bottom", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:tool_cabinet_bottom", "homedecor:tool_cabinet_top")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:tool_cabinet_top" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:tool_cabinet_top", {
	tiles = {
		"homedecor_tool_cabinet_top_top.png",
		"homedecor_tool_cabinet_top_bottom.png",
		"homedecor_tool_cabinet_top_right.png",
		"homedecor_tool_cabinet_top_left.png",
		"homedecor_tool_cabinet_top_back.png",
		"homedecor_tool_cabinet_top_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	}
})

minetest.register_node("homedecor:swing", {
	description = "Tree's swing",
	tiles = {
		"homedecor_swing_top.png",
		"homedecor_swing_top.png^[transformR180",
		"homedecor_swing_top.png"
	},
	inventory_image = "homedecor_swing_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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

minetest.register_node("homedecor:swing_rope", {
	tiles = {
		"homedecor_swingrope_sides.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.025, -0.3, 0.5, 0.0375}, -- NodeBox1
			{0.3, -0.5, 0.025, 0.3125, 0.5, 0.0375}, -- NodeBox2
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	}
})

local bookcolors = {
	"red",
	"green",
	"blue"
}

for c in ipairs(bookcolors) do
	local color = bookcolors[c]
	local color_d = S(bookcolors[c])

minetest.register_node("homedecor:book_"..color, {
	description = S("Book (%s)"):format(color_d),
	tiles = {
		"homedecor_book_"..color.."_top.png",
		"homedecor_book_"..color.."_bottom.png",
		"homedecor_book_right.png",
		"homedecor_book_"..color.."_bottom.png",
		"homedecor_book_back.png",
		"homedecor_book_back.png^[transformFX"
	},
	inventory_image = "homedecor_book_"..color.."_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{0, -0.5, -0.375, 0.3125, -0.4375, 0.0625}, -- NodeBox1
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:book_open_"..color, param2 = fdir })
	end,
})

minetest.register_node("homedecor:book_open_"..color, {
	tiles = {
		"homedecor_book_open_top.png",
		"homedecor_book_open_"..color.."_bottom.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png",
		"homedecor_book_open_sides.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.375, 0.3125, -0.47, 0.0625}, -- NodeBox1
		}
	},
	drop = "homedecor:book_"..color,
	on_punch = function(pos, node, puncher, pointed_thing)
		local fdir = node.param2
		minetest.set_node(pos, { name = "homedecor:book_"..color, param2 = fdir })
	end,
})

end

minetest.register_node("homedecor:calendar", {
	description = "Calendar",
	drawtype = "signlike",
	tiles = {"homedecor_calendar.png"},
	inventory_image = "homedecor_calendar.png",
	wield_image = "homedecor_calendar.png",
	paramtype = "light",
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

minetest.register_node("homedecor:desk_globe", {
	description = "Desk globe",
	drawtype = "mesh",
	mesh = "homedecor_desk_globe.obj",
	tiles = {"homedecor_desk_globe.png"},
	inventory_image = "homedecor_desk_globe_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = globe_cbox,
	collision_box = globe_cbox,
	groups = {choppy=2},
	sounds = default.node_sound_defaults(),
})

local wine_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.25, 0.5, 0.5, 0.5 }
}

minetest.register_node("homedecor:wine_rack", {
	description = "Wine Rack",
	drawtype = "mesh",
	mesh = "homedecor_wine_rack.obj",
	tiles = {"homedecor_wine_rack.png"},
	inventory_image = "homedecor_wine_rack_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2},
	selection_box = wine_cbox,
	collision_box = wine_cbox,
	sounds = default.node_sound_defaults(),
})


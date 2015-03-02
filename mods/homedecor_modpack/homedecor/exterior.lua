local S = homedecor.gettext
dofile(homedecor.modpath.."/furniture.lua")

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

homedecor.register("bench_large_1_left", {
	description = "Garden Bench (style 1)",
	tiles = {
		"homedecor_bench_large_1_left_top.png",
		"homedecor_bench_large_1_left_bottom.png",
		"homedecor_bench_large_1_ends.png^[transformFX",
		"homedecor_bench_large_1_ends.png",
		"homedecor_bench_large_1_left_back.png",
		"homedecor_bench_large_1_left_front.png"
	},
	inventory_image = "homedecor_bench_large_1_inv.png",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.375, 0.5, 0.4375, 0.4375}, -- NodeBox1
			{-0.5, 0, 0.375, 0.5, 0.1875, 0.4375}, -- NodeBox2
			{-0.5, -0.125, 0.115, 0.5, -0.0625, 0.35}, -- NodeBox3
			{-0.5, -0.125, -0.0872, 0.5, -0.0625, 0.079}, -- NodeBox4
			{-0.3125, -0.5, 0.4375, -0.25, 0.375, 0.5}, -- NodeBox5
			{-0.3125, -0.25, -0.0625, -0.25, -0.125, 0.4375}, -- NodeBox6
			{-0.3125, -0.5, -0.0625, -0.25, -0.25, 0}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.09375, 1.5, 0.5, 0.5 }
	},
	expand = { right="homedecor:bench_large_1_right" },
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y-0 -- player's sit position.
		homedecor.sit_exec(pos, node, clicker)
	end,
})

homedecor.register("bench_large_1_right", {
	tiles = {
		"homedecor_bench_large_1_left_top.png^[transformFX",
		"homedecor_bench_large_1_left_bottom.png^[transformFX",
		"homedecor_bench_large_1_ends.png^[transformFX",
		"homedecor_bench_large_1_ends.png",
		"homedecor_bench_large_1_left_back.png^[transformFX",
		"homedecor_bench_large_1_left_front.png^[transformFX"
	},
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.375, 0.5, 0.4375, 0.4375}, -- NodeBox1
			{-0.5, 0, 0.375, 0.5, 0.1875, 0.4375}, -- NodeBox2
			{-0.5, -0.125, 0.115, 0.5, -0.0625, 0.35}, -- NodeBox3
			{-0.5, -0.125, -0.0872, 0.5, -0.0625, 0.079}, -- NodeBox4
			{0.25, -0.5, 0.4375, 0.3125, 0.375, 0.5}, -- NodeBox5
			{0.25, -0.25, -0.0625, 0.3125, -0.125, 0.5}, -- NodeBox6
			{0.25, -0.5, -0.0625, 0.3125, -0.25, 0}, -- NodeBox7
		}
	},
	selection_box = homedecor.nodebox.null,
})


homedecor.register("bench_large_2_left", {
	description = "Garden Bench (style 2)",
	tiles = {
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_bench_large_2_left_back.png",
		"homedecor_bench_large_2_left_back.png^[transformFX"
	},
	inventory_image = "homedecor_bench_large_2_inv.png",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, -- NodeBox1
			{-0.375, 0.3125, 0.4375, 0.5, 0.4375, 0.5}, -- NodeBox2
			{-0.375, -0.0625, 0.4375, 0.5, 0.0625, 0.5}, -- NodeBox3
			{-0.3125, 0.0625, 0.45, -0.25, 0.3125, 0.48}, -- NodeBox4
			{-0.1875, 0.0625, 0.45, -0.125, 0.3125, 0.48}, -- NodeBox5
			{-0.0625, 0.0625, 0.45, 0, 0.3125, 0.48}, -- NodeBox6
			{0.0625, 0.0625, 0.45, 0.125, 0.3125, 0.48}, -- NodeBox7
			{0.1875, 0.0625, 0.45, 0.25, 0.3125, 0.48}, -- NodeBox8
			{0.3125, 0.0625, 0.45, 0.375, 0.3125, 0.48}, -- NodeBox9
			{0.4375, 0.0625, 0.45, 0.5, 0.3125, 0.48}, -- NodeBox10
			{-0.5, 0.0625, -0.145362, -0.375, 0.125, 0.375}, -- NodeBox11
			{-0.5, -0.5, -0.0625, -0.375, 0.0625, 0.0625}, -- NodeBox12
			{-0.4375, -0.125, -0.0625, 0.5, -0.0911603, 0.4375}, -- NodeBox13
			{-0.4375, -0.4375, 0.0625, -0.375, -0.3125, 0.375}, -- NodeBox14
			{-0.375, -0.342324, 0.25, 0.5, -0.4375, 0.1875}, -- NodeBox15
			{-0.5, -0.25, -0.0290173, 0.5, -0.125, 0.0125346}, -- NodeBox16
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.15625, 1.5, 0.5, 0.5 }
	},
	expand = { right="homedecor:bench_large_2_right" },
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y-0 -- player's sit position.
		homedecor.sit_exec(pos, node, clicker)
	end,
})

homedecor.register("bench_large_2_right", {
	tiles = {
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_bench_large_2_right_back.png",
		"homedecor_bench_large_2_right_back.png^[transformFX"
	},
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.3125, 0.4375, 0.375, 0.4375, 0.5}, -- NodeBox2
			{-0.5, -0.0625, 0.4375, 0.375, 0.0625, 0.5}, -- NodeBox3
			{-0.5, 0.0625, 0.45, -0.4375, 0.3125, 0.48}, -- NodeBox4
			{-0.375, 0.0625, 0.45, -0.3125, 0.3125, 0.48}, -- NodeBox5
			{-0.25, 0.0625, 0.45, -0.1875, 0.3125, 0.48}, -- NodeBox6
			{-0.125, 0.0625, 0.45, -0.0625, 0.3125, 0.48}, -- NodeBox7
			{0, 0.0625, 0.45, 0.0625, 0.3125, 0.48}, -- NodeBox8
			{0.125, 0.0625, 0.45, 0.1875, 0.3125, 0.48}, -- NodeBox9
			{0.25, 0.0625, 0.45, 0.3125, 0.3125, 0.48}, -- NodeBox10
			{0.375, 0.0625, -0.145362, 0.5, 0.125, 0.375}, -- NodeBox11
			{0.375, -0.5, -0.0625, 0.5, 0.125, 0.0625}, -- NodeBox12
			{0.375, -0.4375, 0.0625, 0.4375, -0.3125, 0.375}, -- NodeBox13
			{-0.5, -0.4375, 0.1875, 0.375, -0.342324, 0.25}, -- NodeBox14
			{-0.5, -0.125, -0.0625, 0.4375, -0.0911603, 0.4375}, -- NodeBox15
			{-0.5, -0.25, -0.0290173, 0.5, -0.125, 0.0125346}, -- NodeBox16
		}
	},
	selection_box = homedecor.nodebox.null,
})

homedecor.register("deckchair_head", {
	tiles = {
		"homedecor_deckchair_top_c1.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png^[transformFX",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_front.png"
	},
	groups = { snappy = 3, not_in_creative_inventory = 1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.3125, -0.0625, 0.375, -0.25, 0}, -- NodeBox1
			{-0.375, -0.25, 0, 0.375, -0.1875, 0.0625}, -- NodeBox2
			{-0.375, -0.1875, 0.0625, 0.375, -0.125, 0.125}, -- NodeBox3
			{-0.375, -0.125, 0.125, 0.375, -0.0625, 0.1875}, -- NodeBox4
			{-0.375, -0.0625, 0.1875, 0.375, 0, 0.25}, -- NodeBox5
			{-0.375, 0, 0.25, 0.375, 0.0625, 0.3125}, -- NodeBox6
			{-0.375, 0.0625, 0.3125, 0.375, 0.125, 0.375}, -- NodeBox7
			{-0.375, 0.125, 0.375, 0.375, 0.1875, 0.4375}, -- NodeBox8
			{-0.375, 0.1875, 0.4375, 0.375, 0.25, 0.5}, -- NodeBox9
			{-0.375, -0.375, -0.5, 0.375, -0.3125, 0.0625}, -- NodeBox10
			{0.3125, -0.1875, -0.5, 0.4375, -0.1575, 0.0625}, -- NodeBox11
			{-0.4375, -0.1875, -0.5, -0.3125, -0.1575, 0.0625}, -- NodeBox12
			{0.3125, -0.5, 0, 0.375, -0.25, 0.0625}, -- NodeBox13
			{-0.375, -0.5, 0, -0.3125, -0.25, 0.0625}, -- NodeBox14
		}
	},
	selection_box = homedecor.nodebox.null
})

homedecor.register("deckchair_foot", {
	tiles = {
		"homedecor_deckchair_top_c2.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png^[transformFX",
		"homedecor_deckchair_front.png"
	},
	description = "Deck chair",
	inventory_image = "homedecor_deckchair_inv.png",
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, -0.5, 0.375, -0.3125, 0.5}, -- NodeBox1
			{0.3125, -0.5, -0.5, 0.375, -0.375, -0.4375}, -- NodeBox2
			{-0.375, -0.5, -0.5, -0.3125, -0.375, -0.4375}, -- NodeBox3
			{0.3125, -0.1875, 0.3, 0.4375, -0.1575, 0.5}, -- NodeBox4
			{-0.4375, -0.1875, 0.3, -0.3125, -0.1575, 0.5}, -- NodeBox5
			{-0.365, -0.3125, 0.32, -0.3225, -0.1875, 0.4375}, -- NodeBox6
			{0.3225, -0.3125, 0.32, 0.365, -0.1875, 0.4375}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.45, -0.5, -0.5, 0.45, 0.35, 1.5 }
	},
	expand = { forward="homedecor:deckchair_head" },
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

homedecor.register("simple_bench", {
	tiles = {
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_bench_large_2_left_back.png",
		"homedecor_bench_large_2_left_back.png^[transformFX"
	},
	description = "Simple Bench",
	groups = {snappy=3},
	node_box = {
	type = "fixed",
	fixed = {
			{-0.5, -0.15, 0,  0.5,  -0.05, 0.4},
			{-0.4, -0.5,  0.1, -0.3, -0.15, 0.3},
			{ 0.3, -0.5,  0.1,  0.4, -0.15, 0.3},
			}
	},
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y-0 -- player's sit position.
		homedecor.sit_exec(pos, node, clicker)
	end,
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

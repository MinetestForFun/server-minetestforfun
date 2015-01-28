local S = homedecor.gettext

-- 3dforniture tables ... well, they used to be :P

local table_colors = { "", "mahogany", "white" }

for _, i in ipairs(table_colors) do
	local color = "_"..i
	local desc = S("Table ("..i..")")

	if i == "" then
		color = ""
		desc = S("Table")
	end

	homedecor.register("table"..color, {
		description = desc,
		tiles = { "forniture_wood"..color..".png" },
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3,  0.4, -0.3 },
				{  0.3, -0.5, -0.4,  0.4,  0.4, -0.3 },
				{ -0.4, -0.5,  0.3, -0.3,  0.4,  0.4 },
				{  0.3, -0.5,  0.3,  0.4,  0.4,  0.4 },
				{ -0.5,  0.4, -0.5,  0.5,  0.5,  0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1,  0.3 },
				{  0.3, -0.2, -0.4,  0.4, -0.1,  0.3 },
				{ -0.3, -0.2, -0.4,  0.4, -0.1, -0.3 },
				{ -0.3, -0.2,  0.3,  0.3, -0.1,  0.4 },
			},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	})
end

local function sit(pos, node, clicker)
	local name = clicker:get_player_name()
	local meta = minetest:get_meta(pos)
	local param2 = node.param2
	if clicker:get_player_name() == meta:get_string("player") then
		meta:set_string("player", "")
		pos.y = pos.y-0.5
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand", 30)
	else
		meta:set_string("player", clicker:get_player_name())
		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_physics_override(0, 0, 0)
		default.player_attached[name] = true
		if param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif param2 == 3 then
			clicker:set_look_yaw(4.75)
		elseif param2 == 0 then
			clicker:set_look_yaw(3.15)
		else
			clicker:set_look_yaw(6.28)
		end
	end
end

local function sit_exec(pos, node, clicker) -- don't move these functions inside sit()
	if not clicker or not clicker:is_player()
		or clicker:get_player_control().up == true or clicker:get_player_control().down == true
		or clicker:get_player_control().left == true or clicker:get_player_control().right == true
		or clicker:get_player_control().jump == true then  -- make sure that the player is immobile.
	return end
	sit(pos, node, clicker)
	clicker:setpos(pos)
	default.player_set_animation(clicker, "sit", 30)
end

local chaircolors = {
	{ "", "plain" },
	{ "black", "Black" },
	{ "red", "Red" },
	{ "pink", "Pink" },
	{ "violet", "Violet" },
	{ "blue", "Blue" },
	{ "dark_green", "Dark Green" },
}

for i in ipairs(chaircolors) do

	local color = "_"..chaircolors[i][1]
	local color2 = chaircolors[i][1]
	local name = S(chaircolors[i][2])
	local chairtiles = {
			"forniture_kitchen_chair_top"..color..".png",
			"forniture_wood.png",
			"forniture_kitchen_chair_sides"..color..".png",
			"forniture_kitchen_chair_sides"..color..".png^[transformFX",
			"forniture_kitchen_chair_back"..color..".png",
			"forniture_kitchen_chair_front"..color..".png",
	}
	if chaircolors[i][1] == "" then
		color = ""
		chairtiles = { "forniture_wood.png" }
	end

	homedecor.register("chair"..color, {
		description = S("Kitchen chair (%s)"):format(name),
		tiles = chairtiles,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.3125, -0.5, 0.1875, -0.1875, 0.5, 0.3125},
				{0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
				{-0.3125, -0.5, -0.3125, -0.1875, 0, -0.1875},
				{0.1875, -0.5, -0.3125, 0.3125, 0, -0.1875},
				{-0.3125, -0.125, -0.3125, 0.3125, 0, 0.3125},
				{-0.25, 0.0625, 0.25, 0.25, 0.4375, 0.25},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		on_rightclick = function(pos, node, clicker)
			pos.y = pos.y-0 -- player's sit position.
			sit_exec(pos, node, clicker)
		end,
	})

	if color ~= "" then
		homedecor.register("armchair"..color, {
			description = S("Armchair (%s)"):format(name),
			tiles = { "forniture_armchair_top"..color..".png" },
			sunlight_propagates = true,
			node_box = {
			type = "fixed",
			fixed = {
				{ -0.50, -0.50, -0.45, -0.30,  0.05,  0.30 },
				{ -0.45, -0.50, -0.50, -0.35,  0.05, -0.45 },
				{ -0.45,  0.05, -0.45, -0.35,  0.10,  0.15 },
				{  0.30, -0.50, -0.45,  0.50,  0.05,  0.30 },
				{  0.35, -0.50, -0.50,  0.45,  0.05, -0.45 },
				{  0.35,  0.05, -0.45,  0.45,  0.10,  0.15 },
				{ -0.50, -0.50,  0.30,  0.50,  0.45,  0.50 },
				{ -0.45,  0.45,  0.35,  0.45,  0.50,  0.45 },
				{ -0.30, -0.45, -0.35,  0.30, -0.10,  0.30 },
				{ -0.30, -0.45, -0.40,  0.30, -0.15, -0.35 },
				{ -0.50,  0.05,  0.15, -0.30,  0.45,  0.30 },
				{ -0.45,  0.10,  0.10, -0.35,  0.45,  0.15 },
				{ -0.45,  0.45,  0.15, -0.35,  0.50,  0.35 },
				{  0.30,  0.05,  0.15,  0.50,  0.45,  0.30 },
				{  0.35,  0.10,  0.10,  0.45,  0.45,  0.15 },
				{  0.35,  0.45,  0.15,  0.45,  0.50,  0.35 },
			},
			},
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
			on_rightclick = function(pos, node, clicker)
				pos.y = pos.y-0.1 -- player's sit position.
				sit_exec(pos, node, clicker)
				clicker:set_hp(20)
			end,
		})

		minetest.register_craft({
			output = "homedecor:armchair"..color.." 2",
			recipe = {
			{ "wool:"..color2,""},
			{ "group:wood","group:wood" },
			{ "wool:"..color2,"wool:"..color2 },
			},
		})
	end
end

minetest.register_node(":homedecor:openframe_bookshelf", {
	description = "Bookshelf (open-frame)",
	drawtype = "mesh",
	mesh = "homedecor_openframe_bookshelf.obj",
	tiles = { "homedecor_openframe_bookshelf.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
	},
})

local bedcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"brown",
	"darkgrey",
	"orange",
	"yellow",
	"pink",
}

local function bed_extension(pos, color)

	local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
	local thisnode = minetest.get_node(pos)
	local bottomnode = minetest.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})

	local fdir = thisnode.param2

	if string.find(topnode.name, "homedecor:bed_.*_foot$") then
		if fdir == topnode.param2 then
			local newnode = string.gsub(thisnode.name, "_foot", "_footext")
			minetest.set_node(pos, { name = newnode, param2 = fdir})
		end
	end

	if string.find(bottomnode.name, "homedecor:bed_.*_foot$") then
		if fdir == bottomnode.param2 then
			local newnode = string.gsub(bottomnode.name, "_foot", "_footext")
			minetest.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newnode, param2 = fdir})
		end
	end
end

local function unextend_bed(pos, color)
	local bottomnode = minetest.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})
	local fdir = bottomnode.param2
	if  string.find(bottomnode.name, "homedecor:bed_.*_footext$") then
		local newnode = string.gsub(bottomnode.name, "_footext", "_foot")
		minetest.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newnode, param2 = fdir})
	end
end

for _, color in ipairs(bedcolors) do

	homedecor.register("bed_"..color.."_head", {
		tiles = {
			"homedecor_bed_"..color.."_top1.png",
			"homedecor_bed_bottom1.png",
			"homedecor_bed_"..color.."_side1.png",
			"homedecor_bed_"..color.."_side1.png^[transformFX",
			"homedecor_bed_head1.png",
			"homedecor_bed_"..color.."_head2.png"
		},
		groups = {snappy=3, not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,     -0.5,     0.4375,   -0.375,  0.5,      0.5},      --  NodeBox1
				{0.375,    -0.5,     0.4375,   0.5,     0.5,      0.5},      --  NodeBox2
				{-0.5,     0.25,     0.4375,   0.5,     0.4375,   0.5},      --  NodeBox3
				{-0.5,     -0.0625,        0.4375,   0.5,     0.1875,   0.5},      --  NodeBox4
				{-0.5,  -0.375,   -0.5,     0.5,  -0.125,   0.5},      --  NodeBox5
				{0.375,    -0.375,   -0.5,     0.4375,  -0.125,   0.5},      --  NodeBox6
				{-0.4375,   -0.3125,  -0.5,     0.4375,   -0.0625,  0.4375},   --  NodeBox7
				{-0.3125,  -0.125,   0.0625,   0.3125,  0.0625,   0.4375},   --  NodeBox8
			}
		},
		selection_box = homedecor.nodebox.null
	})

	homedecor.register("bed_"..color.."_foot", {
		tiles = {
			"homedecor_bed_"..color.."_top2.png",
			"homedecor_bed_bottom2.png",
			"homedecor_bed_"..color.."_side2.png",
			"homedecor_bed_"..color.."_side2.png^[transformFX",
			"homedecor_bed_foot2.png",
			"homedecor_bed_"..color.."_foot1.png"
		},
		inventory_image = "homedecor_bed_"..color.."_inv.png",
		description = S("Bed (%s)"):format(color),
		groups = {snappy=3},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,     -0.5,     -0.5,     -0.375,  0.1875,   -0.4375},  --  NodeBox1
				{0.375,    -0.5,     -0.5,     0.5,     0.1875,   -0.4375},  --  NodeBox2
				{-0.5,     0,        -0.5,     0.5,     0.125,    -0.4375},  --  NodeBox3
				{-0.5,  -0.375,   -0.5,     0.5,  -0.125,   0.5},      --  NodeBox4
				{-0.4375,   -0.3125,  -0.4375,  0.4375,   -0.0625,  0.5},      --  NodeBox5
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
		},
		on_construct = function(pos)
			bed_extension(pos, color)
		end,
		expand = { forward = "homedecor:bed_"..color.."_head" },
		after_unexpand = function(pos)
			unextend_bed(pos, color)
		end,
	})

	homedecor.register("bed_"..color.."_footext", {
		tiles = {
			"homedecor_bed_"..color.."_top2.png",
			"homedecor_bed_bottom2.png",
			"homedecor_bed_"..color.."_side2ext.png",
			"homedecor_bed_"..color.."_side2ext.png^[transformFX",
			"homedecor_bed_foot2ext.png",
			"homedecor_bed_"..color.."_foot1ext.png"
		},
		groups = {snappy=3, not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,     -0.5,     -0.5,     -0.375,  0.5,   -0.4375},  --  NodeBox1
				{0.375,    -0.5,     -0.5,     0.5,     0.5,   -0.4375},  --  NodeBox2
				{-0.5,     0,        -0.5,     0.5,     0.125,    -0.4375},  --  NodeBox3
				{-0.5,  -0.375,   -0.5,     0.5,  -0.125,   0.5},      --  NodeBox4
				{-0.4375,   -0.3125,  -0.4375,  0.4375,   -0.0625,  0.5},      --  NodeBox5
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
		},
		expand = { forward = "homedecor:bed_"..color.."_head" },
		after_unexpand = function(pos)
			unextend_bed(pos, color)
		end,
		drop = "homedecor:bed_"..color.."_foot"
	})

end

homedecor.register("wardrobe_top", {
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png^[transformR90",
		"forniture_wood.png^[transformR270",
		"forniture_wood.png^[transformR90",
		"homedecor_wardrobe_frontt.png"
	},
	groups = {snappy=3, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,     -0.5,   -0.4375,  0.5,      0.5,      0.5},      --  NodeBox1
			{0.0625,   -0.4375,  -0.5,     0.4375,   0.4375,   -0.4375},  --  NodeBox2
			{-0.4375,  -0.4375,  -0.5,     -0.0625,  0.4375,   -0.4375},  --  NodeBox3
		}
	},
	selection_box = homedecor.nodebox.null,
})

homedecor.register("wardrobe_bottom", {
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png^[transformR180",
		"forniture_wood.png^[transformR90",
		"forniture_wood.png^[transformR270",
		"forniture_wood.png^[transformR90",
		"homedecor_wardrobe_frontb.png"
	},
	inventory_image = "homedecor_wardrobe_inv.png",
	description = "Wardrobe",
		groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,     -0.5,     -0.4375,  0.5,  0.5,      0.5},      --  NodeBox1
			{-0.4375,  -0.375,   -0.5,     0.4375,   -0.125,   -0.4375},  --  NodeBox2
			{-0.4375,  -0.0625,  -0.5,     0.4375,   0.1875,   -0.4375},  --  NodeBox3
			{-0.4375,  0.25,     -0.5,     0.4375,   0.5,      -0.4375},  --  NodeBox4
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	expand = { top="homedecor:wardrobe_top" },
	infotext = S("Wardrobe cabinet"),
	inventory = {
		size=24,
	},
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
		sit_exec(pos, node, clicker)
	end,
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
		sit_exec(pos, node, clicker)
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
		sit_exec(pos, node, clicker)
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

homedecor.register("wall_shelf", {
	description = "Wall Shelf",
	tiles = {
		"homedecor_wood_table_large_edges.png",
	},
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4, 0.47, 0.5, 0.47, 0.5},
			{-0.5, 0.47, -0.1875, 0.5, 0.5, 0.5}
		}
	}
})

homedecor.register("grandfather_clock_bottom", {
	description = "Grandfather Clock",
	tiles = {
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_bottom.png"
	},
	inventory_image = "homedecor_grandfather_clock_inv.png",
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.4, -0.3125, 0.5, 0.4}, -- NodeBox1
			{-0.3125, -0.4375, -0.3125, 0.3125, 0.5, 0.4}, -- NodeBox2
			{0.3125, -0.5, -0.4, 0.4, 0.5, 0.4}, -- NodeBox3
			{-0.3125, -0.5, -0.4, 0.3125, -0.405, 0.4}, -- NodeBox4
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, 1.5, 0.4 }
	},
	expand = { top="homedecor:grandfather_clock_top" },
})

homedecor.register("grandfather_clock_top", {
	tiles = {
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_top.png"
	},
	groups = { snappy = 3, not_in_creative_inventory=1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.4, -0.3125, 0.5, 0.4}, -- NodeBox1
			{-0.3125, -0.1875, -0.4, 0.3125, 0.5, 0.4}, -- NodeBox2
			{0.3125, -0.5, -0.4, 0.4, 0.5, 0.4}, -- NodeBox3
			{-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.4}, -- NodeBox4
		}
	},
	selection_box = homedecor.nodebox.null,
})

homedecor.register("office_chair_upscale", {
	description = "Office chair (upscale)",
	drawtype = "mesh",
	tiles = { "homedecor_office_chair_upscale.png" },
	mesh = "homedecor_office_chair_upscale.obj",
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, 29/32, 8/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -5/16,   1/16, -7/16,  5/16,   4/16,  7/16 }, -- seat
			{ -5/16,   4/16,  4/16,  5/16,  29/32, 15/32 }, -- seatback
			{ -7/16,   1/16, -9/32, -5/16,   7/16,  6/16 }, -- right arm
			{  5/16,   1/16, -9/32,  7/16,   7/16,  6/16 }, -- left arm
			{ -1/16, -11/32, -1/16,  1/16,   1/16,  1/16 }, -- cylinder
			{ -8/16,  -8/16, -8/16,  8/16, -11/32,  8/16 }  -- legs/wheels
		}
	},
	expand = { top = "air" },
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y+0.14 -- player's sit position.
		sit_exec(pos, node, clicker)
	end,
})

homedecor.register("office_chair_basic", {
	description = "Office chair (basic)",
	drawtype = "mesh",
	tiles = { "homedecor_office_chair_basic.png" },
	mesh = "homedecor_office_chair_basic.obj",
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, 29/32, 8/16 }
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -5/16,   1/16, -7/16,  5/16,   4/16,  7/16 }, -- seat
			{ -5/16,   4/16,  4/16,  5/16,  29/32, 15/32 }, -- seatback
			{ -1/16, -11/32, -1/16,  1/16,   1/16,  1/16 }, -- cylinder
			{ -8/16,  -8/16, -8/16,  8/16, -11/32,  8/16 }  -- legs/wheels
		}
	},
	expand = { top = "air" },
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y+0.14 -- player's sit position.
		sit_exec(pos, node, clicker)
	end,
})

-- Aliases for 3dforniture mod.

minetest.register_alias("3dforniture:table", "homedecor:table")
minetest.register_alias("3dforniture:chair", "homedecor:chair")
minetest.register_alias("3dforniture:armchair", "homedecor:armchair_black")
minetest.register_alias("homedecor:armchair", "homedecor:armchair_black")

minetest.register_alias('table', 'homedecor:table')
minetest.register_alias('chair', 'homedecor:chair')
minetest.register_alias('armchair', 'homedecor:armchair')

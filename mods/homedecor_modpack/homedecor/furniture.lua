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

	minetest.register_node("homedecor:table"..color, {
		description = desc,
		tiles = { "forniture_wood"..color..".png" },
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
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

	minetest.register_node("homedecor:chair"..color, {
	    description = S("Kitchen chair (%s)"):format(name),
		tiles = chairtiles,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
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
	})

	if color ~= "" then 
		minetest.register_node("homedecor:armchair"..color, {
			description = S("Armchair (%s)"):format(name),
			tiles = { "forniture_armchair_top"..color..".png" },
			drawtype = "nodebox",
			sunlight_propagates = true,
			paramtype = "light",
			paramtype2 = "facedir",
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
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
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
 
	minetest.register_node("homedecor:bed_"..color.."_head", {
		tiles = {
			"homedecor_bed_"..color.."_top1.png",
			"homedecor_bed_bottom1.png",
			"homedecor_bed_"..color.."_side1.png",
			"homedecor_bed_"..color.."_side1.png^[transformFX",
			"homedecor_bed_head1.png",
			"homedecor_bed_"..color.."_head2.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
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
		selection_box = {
			type = "fixed",
			fixed = { 0, 0, 0, 0, 0, 0 }
		}
	})

	minetest.register_node("homedecor:bed_"..color.."_foot", {
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
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,     -0.5,     -0.5,     -0.375,  0.1875,   -0.4375},  --  NodeBox1
				{0.375,    -0.5,     -0.5,     0.5,     0.1875,   -0.4375},  --  NodeBox2
				{-0.5,     0,        -0.5,     0.5,     0.125,    -0.4375},  --  NodeBox3
				{-0.5,  -0.375,   -0.5,     0.5,  -0.125,   0.5},      --  NodeBox5
				{-0.4375,   -0.3125,  -0.4375,  0.4375,   -0.0625,  0.5},      --  NodeBox6
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
		},
		on_construct = function(pos)
			bed_extension(pos, color)
		end,
 
		on_place = function(itemstack, placer, pointed_thing)
			return homedecor.stack_sideways(itemstack, placer, pointed_thing,
				"homedecor:bed_"..color.."_foot", "homedecor:bed_"..color.."_head", false)
		end,
 
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local fdir = oldnode.param2
			if not fdir or fdir > 3 then return end
			local pos2 = { x = pos.x + homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
			if minetest.get_node(pos2).name == "homedecor:bed_"..color.."_head" then
				minetest.remove_node(pos2)
			end
			unextend_bed(pos, color)
		 end
	})
 
	minetest.register_node("homedecor:bed_"..color.."_footext", {
		tiles = {
			"homedecor_bed_"..color.."_top2.png",
			"homedecor_bed_bottom2.png",
			"homedecor_bed_"..color.."_side2ext.png",
			"homedecor_bed_"..color.."_side2ext.png^[transformFX",
			"homedecor_bed_foot2ext.png",
			"homedecor_bed_"..color.."_foot1ext.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
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
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local fdir = oldnode.param2
			if not fdir or fdir > 3 then return end
			local pos2 = { x = pos.x + homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
			if minetest.get_node(pos2).name == "homedecor:bed_"..color.."_head" then
				minetest.remove_node(pos2)
			end
			unextend_bed(pos, color)
		end,
		drop = "homedecor:bed_"..color.."_foot"
	})
 
end

minetest.register_node("homedecor:wardrobe_top", {
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png^[transformR90",
		"forniture_wood.png^[transformR270",
		"forniture_wood.png^[transformR90",
		"homedecor_wardrobe_frontt.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,     -0.5,   -0.4375,  0.5,      0.5,      0.5},      --  NodeBox1
			{0.0625,   -0.4375,  -0.5,     0.4375,   0.4375,   -0.4375},  --  NodeBox2
			{-0.4375,  -0.4375,  -0.5,     -0.0625,  0.4375,   -0.4375},  --  NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

minetest.register_node("homedecor:wardrobe_bottom", {
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
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:wardrobe_bottom", "homedecor:wardrobe_top")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:wardrobe_top" then
			minetest.remove_node(pos2)
		end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,8]"..
				"list[current_name;main;0,0;8,3;]"..
				"list[current_player;main;0,4;8,4;]")
		meta:set_string("infotext", S("Wardrobe cabinet"))
		local inv = meta:get_inventory()
		inv:set_size("main", 24)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("%s moves stuff in wardrobe at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s moves stuff to wardrobe at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("%s takes stuff from wardrobe at %s"):format(
		    player:get_player_name(),
		    minetest.pos_to_string(pos)
		))
	end,
})

minetest.register_node("homedecor:simple_bench", {
	tiles = {
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_bench_large_2_left_back.png",
		"homedecor_bench_large_2_left_back.png^[transformFX"
	},
	description = "Simple Bench",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
                    {-0.5, -0.15, 0,  0.5,  -0.05, 0.4},
                    {-0.4, -0.5,  0.1, -0.3, -0.15, 0.3},
                    { 0.3, -0.5,  0.1,  0.4, -0.15, 0.3},
	}
	},
})


minetest.register_node("homedecor:bench_large_1_left", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:bench_large_1_left", "homedecor:bench_large_1_right", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:bench_large_1_right" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:bench_large_1_right", {
	tiles = {
		"homedecor_bench_large_1_left_top.png^[transformFX",
		"homedecor_bench_large_1_left_bottom.png^[transformFX",
		"homedecor_bench_large_1_ends.png^[transformFX",
		"homedecor_bench_large_1_ends.png",
		"homedecor_bench_large_1_left_back.png^[transformFX",
		"homedecor_bench_large_1_left_front.png^[transformFX"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})


minetest.register_node("homedecor:bench_large_2_left", {
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
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:bench_large_2_left", "homedecor:bench_large_2_right", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:bench_large_2_right" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:bench_large_2_right", {
	tiles = {
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_generic_wood.png",
		"homedecor_bench_large_2_right_back.png",
		"homedecor_bench_large_2_right_back.png^[transformFX"
	},
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

minetest.register_node("homedecor:deckchair_head", {
	tiles = {
		"homedecor_deckchair_top_c1.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png^[transformFX",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
		selection_box = {
			type = "fixed",
			fixed = { 0, 0, 0, 0, 0, 0 }
		}
})

minetest.register_node("homedecor:deckchair_foot", {
	tiles = {
		"homedecor_deckchair_top_c2.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png",
		"homedecor_deckchair_sides.png^[transformFX",
		"homedecor_deckchair_front.png"
	},
	description = "Deck chair",
	inventory_image = "homedecor_deckchair_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:deckchair_foot", "homedecor:deckchair_head", false)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:deckchair_head" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:wall_shelf", {
	description = "Wall Shelf",
	tiles = {
		"homedecor_wood_table_large_edges.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4, 0.47, 0.5, 0.47, 0.5},
			{-0.5, 0.47, -0.1875, 0.5, 0.5, 0.5}
		}
	}
})

minetest.register_node("homedecor:grandfather_clock_bottom", {
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
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_vertically(itemstack, placer, pointed_thing,
			"homedecor:grandfather_clock_bottom", "homedecor:grandfather_clock_top")
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:grandfather_clock_top" then
			minetest.remove_node(pos2)
		end
	end,
})

minetest.register_node("homedecor:grandfather_clock_top", {
	tiles = {
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_sides.png",
		"homedecor_grandfather_clock_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
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
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
})

-- Aliases for 3dforniture mod.

minetest.register_alias("3dforniture:table", "homedecor:table")
minetest.register_alias("3dforniture:chair", "homedecor:chair")
minetest.register_alias("3dforniture:armchair", "homedecor:armchair_black")
minetest.register_alias("homedecor:armchair", "homedecor:armchair_black")

minetest.register_alias('table', 'homedecor:table')
minetest.register_alias('chair', 'homedecor:chair')
minetest.register_alias('armchair', 'homedecor:armchair')

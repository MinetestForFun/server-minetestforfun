local S = homedecor.gettext

local bbq_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.3125, 0.5, 0.53125, 0.3125 }
}

homedecor.register("barbecue", {
	description = "Barbecue",
	mesh = "homedecor_barbecue.obj",
	tiles = {
		"homedecor_generic_metal_black.png",
		{	name="homedecor_embers.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=2
			}
		},
		"homedecor_barbecue_meat.png",
	},
	groups = { snappy=3 },
	light_source = 9,
	selection_box = bbq_cbox,
	collision_box = bbq_cbox,
	sounds = default.node_sound_stone_defaults(),
	-- no need for placeholder it appears
	expand = { top="air" },
})

minetest.register_alias("homedecor:barbecue_meat", "air")

local bl1_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.25, 1.5, 0.5, 0.5 }
}

local bl1_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.25, 1.5, 0, 0.5 },
		{-0.5, -0.5, 0.45, 1.5, 0.5, 0.5 },
	}
}

homedecor.register("bench_large_1", {
	mesh = "homedecor_bench_large_1.obj",
	tiles = {
		"homedecor_generic_wood_old.png",
		"homedecor_generic_metal_wrought_iron.png"
	},
	description = "Garden Bench (style 1)",
	inventory_image = "homedecor_bench_large_1_inv.png",
	groups = { snappy = 3 },
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = bl1_sbox,
	node_box = bl1_cbox,
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:bench_large_1_left", "homedecor:bench_large_1")
minetest.register_alias("homedecor:bench_large_1_right", "air")

local bl2_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.25, 1.5, 0.5, 0.5 }
}

local bl2_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.25, 1.5, 0, 0.5 },
		{-0.5, -0.5, 0.45, 1.5, 0.5, 0.5 },
	}
}

homedecor.register("bench_large_2", {
	description = "Garden Bench (style 2)",
	mesh = "homedecor_bench_large_2.obj",
	tiles = { "homedecor_generic_wood_old.png" },
	inventory_image = "homedecor_bench_large_2_inv.png",
	groups = {snappy=3},
	selection_box = bl2_sbox,
	node_box = bl2_cbox,
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:bench_large_2_left", "homedecor:bench_large_2")
minetest.register_alias("homedecor:bench_large_2_right", "air")

local dc_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0, 1 }
}

homedecor.register("deckchair", {
	mesh = "homedecor_deckchair.obj",
	tiles = {"homedecor_deckchair.png"},
	description = "Deck Chair",
	groups = { snappy = 3 },
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = dc_cbox,
	collision_box = dc_cbox,
	on_rotate = screwdriver.disallow
})

minetest.register_alias("homedecor:deckchair_foot", "homedecor:deckchair")
minetest.register_alias("homedecor:deckchair_head", "air")

homedecor.register("deckchair_striped_blue", {
	mesh = "homedecor_deckchair.obj",
	tiles = {"homedecor_deckchair_striped_blue.png"},
	description = "Deck Chair",
	groups = { snappy = 3 },
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = dc_cbox,
	collision_box = dc_cbox,
	on_rotate = screwdriver.disallow
})

homedecor.register("doghouse", {
	mesh = "homedecor_doghouse.obj",
	tiles = {
		"homedecor_shingles_terracotta.png",
		"default_wood.png",
		"building_blocks_towel.png"
	},
	description = "Doghouse",
	inventory_image = "homedecor_doghouse_inv.png",
	selection_box = homedecor.nodebox.slab_y(1.5),
	collision_box = homedecor.nodebox.slab_y(1.5),
	groups = {snappy=3},
	expand = { top="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = screwdriver.rotate_simple
})

minetest.register_alias("homedecor:doghouse_roof", "air")
minetest.register_alias("homedecor:doghouse_base", "homedecor:doghouse")

homedecor.register("simple_bench", {
	tiles = { "homedecor_generic_wood_old.png" },
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
	sounds = default.node_sound_wood_defaults(),
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
	},
	sounds = default.node_sound_stone_defaults(),
})

local lattice_colors = {
	{"wood", ".png^[colorize:#704214:180"},
	{"white_wood", ".png"},
	{"wood_vegetal", ".png^[colorize:#704214:180^homedecor_lattice_vegetal.png"},
	{"white_wood_vegetal", ".png^homedecor_lattice_vegetal.png"},
}

for _, m in ipairs(lattice_colors) do
homedecor.register("lattice_"..m[1], {
	description = "Garden Lattice ("..m[1]..")",
	tiles = {"homedecor_lattice"..m[2]},
	inventory_image = "homedecor_lattice"..m[2],
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.47, 0.5, 0.5, 0.47}, -- NodeBox1
			{-0.5, 0.421875, 0.44, 0.5, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.44, 0.5, -0.421875, 0.5}, -- NodeBox3
			{0.421875, -0.5, 0.44, 0.5, 0.5, 0.5}, -- NodeBox4
			{-0.5, -0.5, 0.44, -0.421875, 0.5, 0.5} -- NodeBox5
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.44, 0.5, 0.5, 0.5}
	},
	sounds = default.node_sound_wood_defaults(),
})
end

homedecor.register("swing", {
	description = "Tree's swing",
	tiles = {
		"homedecor_swing_top.png",
		"homedecor_swing_top.png^[transformR180",
		"homedecor_swing_top.png"
	},
	inventory_image = "homedecor_swing_inv.png",
	groups = { snappy=3, oddly_breakable_by_hand=3 },
	sounds = default.node_sound_wood_defaults(),
	walkable = false,
	on_rotate = screwdriver.disallow,
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
	hint = {
		place_on = "bottom"
	},
	on_place = function(itemstack, placer, pointed_thing)
		local isceiling, pos = homedecor.find_ceiling(itemstack, placer, pointed_thing)
		if isceiling then
			local height = 0

			for i = 0, 4 do	-- search up to 5 spaces downward from the ceiling for the first non-buildable-to node...
				height = i
				local testpos = { x=pos.x, y=pos.y-i-1, z=pos.z }
				local testnode = minetest.get_node_or_nil(testpos)
				local testreg = testnode and core.registered_nodes[testnode.name]

				if not testreg or not testreg.buildable_to then
					if i < 1 then
						minetest.chat_send_player(placer:get_player_name(), "No room under there to hang a swing.")
						return itemstack
					else
						break
					end
				end
			end

			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			for j = 0, height do -- then fill that space with ropes...
				local testpos = { x=pos.x, y=pos.y-j, z=pos.z }
				local testnode = minetest.get_node(testpos)
				local testreg = core.registered_nodes[testnode.name]
				minetest.set_node(testpos, { name = "homedecor:swing_rope", param2 = fdir })
			end

			minetest.set_node({ x=pos.x, y=pos.y-height, z=pos.z }, { name = "homedecor:swing", param2 = fdir })

			if not homedecor.expect_infinite_stacks then
				itemstack:take_item()
			end
		else
			minetest.chat_send_player(placer:get_player_name(), "You have to point at the bottom side of an overhanging object to place a swing.")
		end
		return itemstack
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
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.025, -0.3, 0.5, 0.0375}, -- NodeBox1
			{0.3, -0.5, 0.025, 0.3125, 0.5, 0.0375}, -- NodeBox2
		}
	},
	selection_box = homedecor.nodebox.null
})

homedecor.register("well", {
	mesh = "homedecor_well.obj",
	tiles = {
		"homedecor_rope_texture.png",
		"homedecor_generic_metal_black.png^[brighten",
		"default_water.png",
		"default_cobble.png",
		"default_wood.png",
		"homedecor_shingles_wood.png"
	},
	inventory_image = "homedecor_well_inv.png",
	description = "Water well",
	groups = { snappy = 3 },
	selection_box = homedecor.nodebox.slab_y(2),
	collision_box = homedecor.nodebox.slab_y(2),
	expand = { top="placeholder" },
	sounds = default.node_sound_stone_defaults(),
	on_rotate = screwdriver.rotate_simple
})

if minetest.get_modpath("bucket") then
	local original_bucket_on_use = minetest.registered_items["bucket:bucket_empty"].on_use
	minetest.override_item("bucket:bucket_empty", {
		on_use = function(itemstack, user, pointed_thing)
			local inv = user:get_inventory()

			if pointed_thing.type == "node" and minetest.get_node(pointed_thing.under).name == "homedecor:well" then
				if inv:room_for_item("main", "bucket:bucket_water 1") then
					itemstack:take_item()
					inv:add_item("main", "bucket:bucket_water 1")
				else
					minetest.chat_send_player(user:get_player_name(), "No room in your inventory to add a filled bucket!")
				end
				return itemstack
			else if original_bucket_on_use then
				return original_bucket_on_use(itemstack, user, pointed_thing)
			else return end
		end
	end
	})
end

homedecor.shrub_colors = {
	"green",
	"red",
	"yellow"
}

local shrub_cbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }

for _, color in ipairs(homedecor.shrub_colors) do
	minetest.register_node("homedecor:shrubbery_large_"..color, {
		description = S("Shrubbery ("..color..")"),
		drawtype = "mesh",
		mesh = "homedecor_cube.obj",
		tiles = {"homedecor_shrubbery_"..color..".png"},
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3, flammable=2},
		sounds = default.node_sound_leaves_defaults(),
	})

	minetest.register_node("homedecor:shrubbery_"..color, {
		description = S("Shrubbery ("..color..")"),
		drawtype = "mesh",
		mesh = "homedecor_shrubbery.obj",
		tiles = {
			"homedecor_shrubbery_"..color..".png",
			"homedecor_shrubbery_"..color.."_bottom.png",
			"homedecor_shrubbery_roots.png"
		},
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3, flammable=2},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = shrub_cbox,
		collision_box = shrub_cbox,
	})
end

minetest.register_alias("homedecor:well_top", "air")
minetest.register_alias("homedecor:well_base", "homedecor:well")

minetest.register_alias("gloopblocks:shrubbery", "homedecor:shrubbery_green")
minetest.register_alias("gloopblocks:shrubbery_large", "homedecor:shrubbery_large_green")

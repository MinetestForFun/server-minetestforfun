-- This file supplies refrigerators

local S = homedecor.gettext

-- nodebox models

local fridge_model_bottom = {
	type = "fixed",
	fixed = {
		{0, -0.4375, -0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
		{-0.5, -0.5, -0.42, 0.5, 0.5, 0.5}, -- NodeBox2
		{-0.5, -0.4375, -0.4375, -0.0625, 0.5, 0.5}, -- NodeBox3
		{0, 0.25, -0.5, 0.0625, 0.3125, -0.4375}, -- NodeBox4
		{-0.125, 0.25, -0.5, -0.0625, 0.3125, -0.4375}, -- NodeBox5
		{0, 0.25, -0.5, 0.0625, 0.5, -0.473029}, -- NodeBox6
		{-0.125, 0.25, -0.5, -0.0625, 0.5, -0.473029}, -- NodeBox7
	}
}

local fridge_model_top = {
	type = "fixed",
	fixed = {
		{0, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- NodeBox1
		{-0.0625, -0.5, -0.42, 0, 0.5, 0.5}, -- NodeBox2
		{-0.5, -0.5, -0.4375, -0.0625, -0.4375, 0.5}, -- NodeBox3
		{-0.5, -0.5, -0.4375, -0.4375, 0.5, 0.5}, -- NodeBox4
		{-0.5, -0.1875, -0.4375, -0.0625, 0.5, 0.5}, -- NodeBox5
		{-0.4375, -0.4375, -0.125, -0.0625, -0.1875, 0.5}, -- NodeBox6
		{-0.125, -0.4375, -0.4375, -0.0625, -0.1875, -0.125}, -- NodeBox7
		{-0.3125, -0.3125, -0.307054, -0.25, -0.1875, -0.286307}, -- NodeBox8
		{-0.125, 0, -0.5, -0.0625, 0.0625, -0.4375}, -- NodeBox9
		{0, 0, -0.5, 0.0625, 0.0625, -0.4375}, -- NodeBox10
		{0, -0.5, -0.5, 0.0625, 0.0625, -0.473029}, -- NodeBox11
		{-0.125, -0.5, -0.5, -0.0625, 0.0625, -0.473029}, -- NodeBox12
	}
}

-- steel-textured fridge
homedecor.register("refrigerator_steel_bottom", {
	tiles = {
		"default_steel_block.png",
		"homedecor_refrigerator_steel_bottom.png",
		"homedecor_refrigerator_steel_sides1.png",
		"homedecor_refrigerator_steel_sides1.png^[transformFX",
		"homedecor_refrigerator_steel_back1.png",
		"homedecor_refrigerator_steel_front2.png"
	},
	inventory_image = "homedecor_refrigerator_steel_inv.png",
	description = S("Refrigerator (stainless steel)"),
	groups = {snappy=3},
	node_box = fridge_model_bottom,
	selection_box = homedecor.nodebox.slab_y(2),
	expand = {
		top="homedecor:refrigerator_steel_top"
	},
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true,
	},
})

homedecor.register("refrigerator_steel_top", {
	tiles = {
		"homedecor_refrigerator_steel_top.png",
		"default_steel_block.png",
		"homedecor_refrigerator_steel_sides1.png",
		"homedecor_refrigerator_steel_sides1.png^[transformFX",
		"homedecor_refrigerator_steel_back1.png",
		"homedecor_refrigerator_steel_front1.png"
	},
	groups = {snappy=3},
	node_box = fridge_model_top,
	selection_box = homedecor.nodebox.null,
})

-- white, enameled fridge

homedecor.register("refrigerator_white_bottom", {
	tiles = {
		"default_steel_block.png",
		"homedecor_refrigerator_white_bottom.png",
		"homedecor_refrigerator_white_sides1.png",
		"homedecor_refrigerator_white_sides1.png^[transformFX",
		"homedecor_refrigerator_white_back1.png",
		"homedecor_refrigerator_white_front2.png"
	},
	inventory_image = "homedecor_refrigerator_white_inv.png",
	description = S("Refrigerator"),
	groups = {snappy=3},
	node_box = fridge_model_bottom,
	selection_box = homedecor.nodebox.slab_y(2),
	expand = {
		top="homedecor:refrigerator_white_top"
	},
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true
	},
})

homedecor.register("refrigerator_white_top", {
	tiles = {
		"homedecor_refrigerator_white_top.png",
		"default_steel_block.png",
		"homedecor_refrigerator_white_sides1.png",
		"homedecor_refrigerator_white_sides1.png^[transformFX",
		"homedecor_refrigerator_white_back1.png",
		"homedecor_refrigerator_white_front1.png"
	},
	groups = {snappy=3},
	node_box = fridge_model_top,
	selection_box = homedecor.nodebox.null,
})

-- convert the old single-node fridges to the new two-node models

minetest.register_abm({
	nodenames = { "homedecor:refrigerator" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_white_bottom", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_white_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_locked" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_white_bottom_locked", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_white_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_steel" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_steel_bottom", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_steel_top", param2 = fdir })
	end
})

minetest.register_abm({
	nodenames = { "homedecor:refrigerator_steel_locked" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2
		local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
		minetest.swap_node(pos, { name = "homedecor:refrigerator_steel_bottom_locked", param2 = fdir })
		minetest.set_node(p_top, { name = "homedecor:refrigerator_steel_top", param2 = fdir })
	end
})

-- kitchen "furnaces"
homedecor.register_furnace("homedecor:oven", {
	description = S("Oven"),
	tile_format = "homedecor_oven_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

homedecor.register_furnace("homedecor:oven_steel", {
	description = S("Oven (stainless steel)"),
	tile_format = "homedecor_oven_steel_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

homedecor.register_furnace("homedecor:microwave_oven", {
	description = S("Microwave Oven"),
	tiles = {
		"homedecor_microwave_top.png", "homedecor_microwave_top.png^[transformR180",
		"homedecor_microwave_top.png^[transformR270", "homedecor_microwave_top.png^[transformR90",
		"homedecor_microwave_top.png^[transformR180", "homedecor_microwave_front.png"
	},
	tiles_active = {
		"homedecor_microwave_top.png", "homedecor_microwave_top.png^[transformR180",
		"homedecor_microwave_top.png^[transformR270", "homedecor_microwave_top.png^[transformR90",
		"homedecor_microwave_top.png^[transformR180", "homedecor_microwave_front_active.png"
	},
	output_slots = 2,
	output_width = 2,
	cook_speed = 1.5,
	extra_nodedef_fields = {
		drawtype = "nodebox",
		paramtype = "light",
		--paramtype2 = "facedir", -- Not needed, set by register_furnace
		node_box = {
			type = "fixed",
			fixed = { { -0.5, -0.5, -0.125, 0.5, 0.125, 0.5 } },
		},
	},
})

-- coffee!
-- coffee!
-- coffee!
homedecor.register("coffee_maker", {
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

homedecor.register("toaster", {
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

homedecor.register("toaster_loaf", {
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


homedecor.register("dishwasher", {
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
	selection_box = { type = "regular" },
	groups = { snappy = 3 },
})

homedecor.register("dishwasher_wood", {
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

homedecor.register("dishwasher_steel", {
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

homedecor.register("dishwasher_marble", {
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

homedecor.register("dishwasher_granite", {
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

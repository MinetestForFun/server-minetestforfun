-- This file supplies refrigerators

local S = homedecor.gettext

-- steel-textured fridge
homedecor.register("refrigerator_steel", {
	mesh = "homedecor_refrigerator.obj",
	tiles = { "homedecor_refrigerator_steel.png" },
	inventory_image = "homedecor_refrigerator_steel_inv.png",
	description = S("Refrigerator (stainless steel)"),
	groups = {snappy=3},
	sounds = default.node_sound_stone_defaults(),
	selection_box = homedecor.nodebox.slab_y(2),
	collision_box = homedecor.nodebox.slab_y(2),
	expand = { top="placeholder" },
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true,
	},
	on_rotate = screwdriver.rotate_simple
})

-- white, enameled fridge
homedecor.register("refrigerator_white", {
	mesh = "homedecor_refrigerator.obj",
	tiles = { "homedecor_refrigerator_white.png" },
	inventory_image = "homedecor_refrigerator_white_inv.png",
	description = S("Refrigerator"),
	groups = {snappy=3},
	selection_box = homedecor.nodebox.slab_y(2),
	collision_box = homedecor.nodebox.slab_y(2),
	sounds = default.node_sound_stone_defaults(),
	expand = { top="placeholder" },
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true,
	},
	on_rotate = screwdriver.rotate_simple
})

minetest.register_alias("homedecor:refrigerator_white_bottom", "homedecor:refrigerator_white")
minetest.register_alias("homedecor:refrigerator_white_top", "air")

minetest.register_alias("homedecor:refrigerator_steel_bottom", "homedecor:refrigerator_steel")
minetest.register_alias("homedecor:refrigerator_steel_top", "air")

minetest.register_alias("homedecor:refrigerator_white_bottom_locked", "homedecor:refrigerator_white_locked")
minetest.register_alias("homedecor:refrigerator_white_top_locked", "air")

minetest.register_alias("homedecor:refrigerator_steel_bottom_locked", "homedecor:refrigerator_steel_locked")
minetest.register_alias("homedecor:refrigerator_steel_top_locked", "air")

-- kitchen "furnaces"
homedecor.register_furnace("oven", {
	description = S("Oven"),
	tile_format = "homedecor_oven_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

homedecor.register_furnace("oven_steel", {
	description = S("Oven (stainless steel)"),
	tile_format = "homedecor_oven_steel_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

homedecor.register_furnace("microwave_oven", {
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
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.125, 0.5, 0.125, 0.5 },
		},
	},
})

-- coffee!
-- coffee!
-- coffee!

local cm_cbox = {
	type = "fixed",
	fixed = {
		{     0, -8/16,     0,  7/16,  3/16,  8/16 },
		{ -4/16, -8/16, -6/16, -1/16, -5/16, -3/16 }
	}
}

homedecor.register("coffee_maker", {
	mesh = "homedecor_coffeemaker.obj",
	tiles = {
		"homedecor_coffeemaker_decanter.png",
		"homedecor_coffeemaker_cup.png",
		"homedecor_coffeemaker_case.png",
	},
	description = "Coffee Maker",
	inventory_image = "homedecor_coffeemaker_inv.png",
	walkable = false,
	groups = {snappy=3},
	selection_box = cm_cbox,
	node_box = cm_cbox,
	on_rotate = screwdriver.disallow
})

local fdir_to_steampos = {
	x = { 0.15,   0.275, -0.15,  -0.275 },
	z = { 0.275, -0.15,  -0.275,  0.15  }
}

minetest.register_abm({
	nodenames = "homedecor:coffee_maker",
	label = "sfx",
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
	tiles = { "homedecor_toaster_sides.png" },
	inventory_image = "homedecor_toaster_inv.png",
	walkable = false,
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
	walkable = false,
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
	sounds = default.node_sound_stone_defaults(),
	groups = { snappy = 3 },
})

local materials = {"granite", "marble", "steel", "wood"}

for _, m in ipairs(materials) do
homedecor.register("dishwasher_"..m, {
	description = "Dishwasher ("..m..")",
	tiles = {
		"homedecor_kitchen_cabinet_top_"..m..".png",
		"homedecor_dishwasher_bottom.png",
		"homedecor_dishwasher_sides.png",
		"homedecor_dishwasher_sides.png^[transformFX",
		"homedecor_dishwasher_back.png",
		"homedecor_dishwasher_front.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_stone_defaults(),
})
end

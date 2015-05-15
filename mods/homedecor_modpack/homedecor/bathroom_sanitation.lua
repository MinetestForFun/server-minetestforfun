local S = homedecor.gettext

local toilet_sbox = {
	type = "fixed",
	fixed = { -6/16, -8/16, -8/16, 6/16, 9/16, 8/16 },
}

local toilet_cbox = {
	type = "fixed",
	fixed = { 
		{-6/16, -8/16, -8/16, 6/16, 1/16, 8/16 },
		{-6/16, -8/16, 4/16, 6/16, 9/16, 8/16 }
	}
}

homedecor.register("toilet", {
	description = S("Toilet"),
	mesh = "homedecor_toilet_closed.obj",
	tiles = {
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_generic_metal_black.png^[brighten"
	},
	selection_box = toilet_sbox,
	node_box = toilet_cbox,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch = function (pos, node, puncher)
		node.name = "homedecor:toilet_open"
		minetest.set_node(pos, node)
	end
})

homedecor.register("toilet_open", {
	mesh = "homedecor_toilet_open.obj",
	tiles = {
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_marble.png^[colorize:#ffffff:175",
		"default_water.png",
		"homedecor_generic_metal_black.png^[brighten"
	},
	selection_box = toilet_sbox,
	collision_box = toilet_cbox,
	drop = "homedecor:toilet",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch = function (pos, node, puncher)
		node.name = "homedecor:toilet"
		minetest.set_node(pos, node)
		minetest.sound_play("homedecor_toilet_flush", {
			pos=pos,
			max_hear_distance = 5,
			gain = 1,
		})
	end
})

-- toilet paper :-)

local tp_cbox = {
	type = "fixed",
	fixed = { -0.25, 0.125, 0.0625, 0.1875, 0.4375, 0.5 }
}

homedecor.register("toilet_paper", {
	description = S("Toilet paper"),
	mesh = "homedecor_toilet_paper.obj",
	tiles = {
		"homedecor_generic_quilted_paper.png",
		"default_wood.png"
	},
	inventory_image = "homedecor_toilet_paper_inv.png",
	selection_box = tp_cbox,
	walkable = false,
	groups = {snappy=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_defaults(),
})

--Sink

local sink_cbox = {
	type = "fixed",
	fixed = { -5/16, -8/16, 1/16, 5/16, 8/16, 8/16 }
}

homedecor.register("sink", {
	description = S("Bathroom Sink"),
	mesh = "homedecor_bathroom_sink.obj",
	tiles = {
		"homedecor_marble.png^[colorize:#ffffff:175",
		"homedecor_marble.png",
		"default_water.png"
	},
	inventory_image="homedecor_bathroom_sink_inv.png",
	selection_box = sink_cbox,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{ -5/16,  5/16, 1/16, -4/16, 8/16, 8/16 },
			{  5/16,  5/16, 1/16,  4/16, 8/16, 8/16 },
			{ -5/16,  5/16, 1/16,  5/16, 8/16, 2/16 },
			{ -5/16,  5/16, 6/16,  5/16, 8/16, 8/16 },
			{ -4/16, -8/16, 1/16,  4/16, 5/16, 6/16 }
		}
	},
	on_destruct = function(pos)
		homedecor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z})
	end
})

--Taps

local function taps_on_rightclick(pos, node, clicker)
	local below = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
	if below and
	  below.name == "homedecor:shower_tray" or
	  below.name == "homedecor:sink" or
	  below.name == "homedecor:kitchen_cabinet_with_sink" then
		local particledef = {
			outlet      = { x = 0, y = -0.44, z = 0.28 },
			velocity_x  = { min = -0.1, max = 0.1 },
			velocity_y  = -0.3,
			velocity_z  = { min = -0.1, max = 0 },
			spread      = 0
		}
		homedecor.start_particle_spawner(pos, node, particledef, "homedecor_faucet")
	end
end

homedecor.register("taps", {
	description = S("Bathroom taps/faucet"),
	mesh = "homedecor_bathroom_faucet.obj",
	tiles = {
		"homedecor_generic_metal_black.png^[brighten",
		"homedecor_generic_metal_bright.png",
		"homedecor_generic_metal_black.png^[colorize:#ffffff:200",
		"homedecor_generic_metal_bright.png"
	},
	inventory_image = "3dforniture_taps_inv.png",
	wield_image = "3dforniture_taps_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -4/16, -7/16, 4/16, 4/16, -4/16, 8/16 },
	},
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = taps_on_rightclick,
	on_destruct = homedecor.stop_particle_spawner,
	on_rotate = screwdriver.disallow
})

homedecor.register("taps_brass", {
	description = S("Bathroom taps/faucet (brass)"),
	mesh = "homedecor_bathroom_faucet.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_metal_black.png^[colorize:#ffffff:200",
		"homedecor_generic_metal_brass.png"
	},
	inventory_image = "3dforniture_taps_brass_inv.png",
	wield_image = "3dforniture_taps_brass_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -4/16, -7/16, 4/16, 4/16, -4/16, 8/16 },
	},
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = taps_on_rightclick,
	on_destruct = homedecor.stop_particle_spawner,
	on_rotate = screwdriver.disallow
})

--Shower Tray

homedecor.register("shower_tray", {
	description = S("Shower Tray"),
	tiles = {
		"forniture_marble_base_ducha_top.png",
		"homedecor_marble.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
			{ -0.5, -0.45, -0.5, 0.5, -0.4, -0.45 },
			{ -0.5, -0.45, 0.45, 0.5, -0.4, 0.5 },
			{ -0.5, -0.45, -0.45, -0.45, -0.4, 0.45 },
			{  0.45, -0.45, -0.45, 0.5, -0.4, 0.45 }
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 },
	},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	on_destruct = function(pos)
		homedecor.stop_particle_spawner({x=pos.x, y=pos.y+2, z=pos.z}) -- the showerhead
		homedecor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z}) -- the taps, if any
	end
})

--Shower Head


local sh_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.4, -0.05, 0.2, 0.1, 0.5 }
}

homedecor.register("shower_head", {
	drawtype = "mesh",
	mesh = "homedecor_shower_head.obj",
	tiles = {
		"homedecor_generic_metal_black.png^[brighten",
		"homedecor_shower_head.png"
	},
	inventory_image = "homedecor_shower_head_inv.png",
	description = "Shower Head",
	groups = {snappy=3},
	selection_box = sh_cbox,
	walkable = false,
	on_rotate = screwdriver.disallow,
	on_rightclick = function (pos, node, clicker)
		local below = minetest.get_node_or_nil({x=pos.x, y=pos.y-2.0, z=pos.z})
		if below and below.name == "homedecor:shower_tray" then
			local particledef = {
				outlet      = { x = 0, y = -0.42, z = 0.1 },
				velocity_x  = { min = -0.15, max = 0.15 },
				velocity_y  = -2,
				velocity_z  = { min = -0.3,  max = 0.1 },
				spread      = 0.12
			}
			homedecor.start_particle_spawner(pos, node, particledef, "homedecor_shower")
		end
	end,
	on_destruct = function(pos)
		homedecor.stop_particle_spawner(pos)
	end
})

local bs_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 1/16, 8/16, 8/16, 8/16 }
}

homedecor.register("bathroom_set", {
	drawtype = "mesh",
	mesh = "homedecor_bathroom_set.obj",
	tiles = {
		"homedecor_bathroom_set_mirror.png",
		"homedecor_bathroom_set_tray.png",
		"homedecor_bathroom_set_toothbrush.png",
		"homedecor_bathroom_set_cup.png",
		"homedecor_bathroom_set_toothpaste.png",
	},
	inventory_image = "homedecor_bathroom_set_inv.png",
	description = "Bathroom sundries set",
	groups = {snappy=3},
	selection_box = bs_cbox,
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_alias("3dforniture:toilet", "homedecor:toilet")
minetest.register_alias("3dforniture:toilet_open", "homedecor:toilet_open")
minetest.register_alias("3dforniture:sink", "homedecor:sink")
minetest.register_alias("3dforniture:taps", "homedecor:taps")
minetest.register_alias("3dforniture:shower_tray", "homedecor:shower_tray")
minetest.register_alias("3dforniture:shower_head", "homedecor:shower_head")
minetest.register_alias("3dforniture:table_lamp", "homedecor:table_lamp_off")

minetest.register_alias("toilet", "homedecor:toilet")
minetest.register_alias("sink", "homedecor:sink")
minetest.register_alias("taps", "homedecor:taps")
minetest.register_alias("shower_tray", "homedecor:shower_tray")
minetest.register_alias("shower_head", "homedecor:shower_head")
minetest.register_alias("table_lamp", "homedecor:table_lamp_off")

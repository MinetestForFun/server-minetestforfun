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
		"homedecor_marble_light.png",
		"homedecor_marble_light.png",
		"homedecor_marble_light.png",
		"homedecor_generic_metal_neutral.png"
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
		"homedecor_marble_light.png",
		"homedecor_marble_light.png",
		"homedecor_marble_light.png",
		"default_water.png",
		"homedecor_generic_metal_neutral.png"
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
		"homedecor_marble_light.png",
		"forniture_marble.png",
		"default_water.png"
	},
	inventory_image="homedecor_bathroom_sink_inv.png",
	selection_box = sink_cbox,
	collision_box = sink_cbox,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

--Taps

homedecor.register("taps", {
	description = S("Bathroom taps/faucet"),
	mesh = "homedecor_bathroom_faucet.obj",
	tiles = {
		"homedecor_generic_metal_neutral.png",
		"homedecor_generic_metal_bright.png",
		"homedecor_generic_metal_white.png",
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
})

homedecor.register("taps_brass", {
	description = S("Bathroom taps/faucet (brass)"),
	mesh = "homedecor_bathroom_faucet.obj",
	tiles = {
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_metal_brass.png",
		"homedecor_generic_metal_white.png",
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
})

--Shower Tray

homedecor.register("shower_tray", {
	description = S("Shower Tray"),
	tiles = {
		"forniture_marble_base_ducha_top.png",
		"forniture_marble.png"
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
		headpos = {x=pos.x, y=pos.y+2, z=pos.z}
		local above_spawner_meta = minetest.get_meta(headpos)

		local id = above_spawner_meta:get_int("active")
		local s_handle = above_spawner_meta:get_int("sound")

		if id ~= 0 then
			minetest.delete_particlespawner(id)
		end

		if s_handle then
			minetest.after(0, function(s_handle)
				minetest.sound_stop(s_handle)
			end, s_handle)
		end

		above_spawner_meta:set_int("active", nil)
		above_spawner_meta:set_int("sound", nil)
	end
})

--Shower Head

local fdir_to_flowpos = {
	minx = { 0.15, 0.05, -0.15, -0.05 }, maxx = { -0.15, -0.3, 0.15, 0.3 },
	minz = { 0.05, 0.15, -0.05, -0.15 }, maxz = { -0.3, -0.15, 0.3, 0.15 },
	velx = { 0, -0.2, 0, 0.2 }, velz = { -0.2, 0, 0.2, 0 }
}

local sh_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.4, -0.05, 0.2, 0.1, 0.5 }
}

homedecor.register("shower_head", {
	drawtype = "mesh",
	mesh = "homedecor_shower_head.obj",
	tiles = {
		"homedecor_generic_metal_neutral.png",
		"homedecor_shower_head.png"
	},
	inventory_image = "homedecor_shower_head_inv.png",
	description = "Shower Head",
	groups = {snappy=3},
	selection_box = sh_cbox,
	walkable = false,
	on_rightclick = function (pos, node, clicker)
		local below = minetest.get_node({x=pos.x, y=pos.y-2.0, z=pos.z})
		local is_tray = string.find(below.name, "homedecor:shower_tray")
		local fdir = node.param2
		local minx = fdir_to_flowpos.minx[fdir + 1]
		local maxx = fdir_to_flowpos.maxx[fdir + 1]
		local minz = fdir_to_flowpos.minz[fdir + 1]
		local maxz = fdir_to_flowpos.maxz[fdir + 1]
		local velx = fdir_to_flowpos.velx[fdir + 1]
		local velz = fdir_to_flowpos.velz[fdir + 1]

		local this_spawner_meta = minetest.get_meta(pos)
		local id = this_spawner_meta:get_int("active")
		local s_handle = this_spawner_meta:get_int("sound")

		if id ~= 0 then
			if s_handle then
				minetest.after(0, function(s_handle)
					minetest.sound_stop(s_handle)
				end, s_handle)
			end
			minetest.delete_particlespawner(id)
			this_spawner_meta:set_int("active", nil)
			this_spawner_meta:set_int("sound", nil)
			return
		end

		if fdir and fdir < 4 and is_tray and (not id or id == 0) then
			id = minetest.add_particlespawner({
				amount = 60, time = 0, collisiondetection = true,
				minpos = {x=pos.x - minx, y=pos.y-0.45, z=pos.z - minz},
				maxpos = {x=pos.x - maxx, y=pos.y-0.45, z=pos.z - maxz},
				minvel = {x=velx, y=-2, z=velz}, maxvel = {x=velx, y=-2, z=velz},
				minacc = {x=0, y=0, z=0}, maxacc = {x=0, y=-0.05, z=0},
				minexptime = 2, maxexptime = 4, minsize = 0.5, maxsize = 1,
				texture = "homedecor_water_particle.png",
			})
			s_handle = minetest.sound_play("homedecor_shower", {
				pos = pos,
				max_hear_distance = 5,
				loop = true 
			})
			this_spawner_meta:set_int("active", id)
			this_spawner_meta:set_int("sound", s_handle)
			return
		end
	end,
	on_destruct = function(pos)
		local this_spawner_meta = minetest.get_meta(pos)
		local id = this_spawner_meta:get_int("active")
		local s_handle = this_spawner_meta:get_int("sound")

		if id ~= 0 then
			minetest.delete_particlespawner(id)
		end

		if s_handle then
			minetest.after(0, function(s_handle)
				minetest.sound_stop(s_handle)
			end, s_handle)
		end

		this_spawner_meta:set_int("active", nil)
		this_spawner_meta:set_int("sound", nil)
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
